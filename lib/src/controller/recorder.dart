import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stroll/src/utils/recorder_action.dart';
import 'package:permission_handler/permission_handler.dart';

import 'audio_processing.dart';

class Recorder {
  AudioRecorder recorder = AudioRecorder();
  AudioPlayer player = AudioPlayer();
  late int barNumbers;

  Duration recordingDuration = const Duration();
  Duration playingDuration = const Duration();

  double audioPosition = 0;

  List<double> amplitudesList = [];
  List<double> amplitudesMax = [];
  StreamSubscription? amplitudeSubscription;
  RecorderAction currentAction = RecorderAction.start;

  bool playerMode = false;

  set barNumber(int number) {
    barNumbers = number;
  }

  List<double> get amplitudes {
    if (playerMode) {
      return interpolateList(amplitudesList, barNumbers);
    } else {
      return amplitudesMax;
    }
  }

  String get timeString {
    int recordingSeconds = recordingDuration.inSeconds;
    int recMinutes = (recordingSeconds / 60).floor();
    int recSeconds = recordingSeconds % 60;
    String recordingTime =
        "${recMinutes > 9 ? recMinutes : "0$recMinutes"}:${recSeconds > 9 ? recSeconds : "0$recSeconds"}";

    int playingSeconds = playingDuration.inSeconds;
    int playMinutes = (playingSeconds / 60).floor();
    int playSeconds = playingSeconds % 60;
    String playingTime =
        "${playMinutes > 9 ? playMinutes : "0$playMinutes"}:${playSeconds > 9 ? playSeconds : "0$playSeconds"}";

    if (currentAction == RecorderAction.play ||
        currentAction == RecorderAction.pause) {
      return "$playingTime / $recordingTime";
    } else {
      return recordingTime;
    }
  }

  IconData get icon {
    switch (currentAction) {
      case RecorderAction.start:
        return Icons.circle;
      case RecorderAction.play:
        return Icons.play_arrow_rounded;
      case RecorderAction.stop:
        return Icons.stop_rounded;
      case RecorderAction.delete:
        return Icons.delete;
      case RecorderAction.pause:
        return Icons.pause;
    }
  }

  Future<void> playAudio(Function() onChanged) async {
    try {
      currentAction = RecorderAction.pause;

      player.play();

      final subscription = player.positionStream.listen((position) {
        audioPosition =
            position.inMilliseconds / recordingDuration.inMilliseconds;
        playingDuration = position;
        onChanged();
      });

      subscription.onDone(() => onChanged());
      subscription.onError((error) {
        debugPrint("Playing had an error: $error");
      });

      player.playerStateStream.listen((state) {
        if (audioPosition == 1) pauseAudio(onChanged);
      });
    } catch (e) {
      debugPrint("Error playing Audio: $e");
    }
  }

  Future<void> pauseAudio(Function() onPause) async {
    currentAction = RecorderAction.play;
    await player.pause();
    onPause();
  }

  Future<void> seekAudio(double position, Function() onSeek) async {
    if (player.playing) pauseAudio(onSeek);

    Duration seekDuration = Duration(
        milliseconds: (position * recordingDuration.inMilliseconds).floor());
    await player.seek(seekDuration);
  }

  Future<void> startRecording(
    Function(double amp) onAmplitudeChange,
  ) async {
    if (await Permission.microphone.isDenied) {
      await Permission.microphone.request();
    }
    currentAction = RecorderAction.stop;

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/recording.wav';

    List<int> audioData = [];

    recorder
        .startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        numChannels: 1, // Specify channels
        sampleRate: 44100, // Specify sample rate
      ),
    )
        .then((stream) {
      stream.listen((data) {
        audioData.addAll(data);
      }, onDone: () async {
        final wavFile = await File(filePath).create();
        final fileLength = audioData.length;

        final header = createWavHeader(dataSize: fileLength);

        await wavFile.writeAsBytes(header + audioData);

        await player.setFilePath(filePath);

        debugPrint('Recording saved!');
      });
    });
    Stopwatch watch = Stopwatch()..start();

    amplitudeSubscription = recorder
        .onAmplitudeChanged(const Duration(milliseconds: 48))
        .listen((Amplitude amp) {
      double normalizedAmplitude = 1 - (amp.current.abs() / 60);
      amplitudesList.add(normalizedAmplitude);
      if (amplitudesMax.length >= barNumbers) amplitudesMax.removeAt(0);
      amplitudesMax.add(normalizedAmplitude);
      recordingDuration = Duration(milliseconds: watch.elapsedMilliseconds);

      onAmplitudeChange(normalizedAmplitude);
    });
  }

  Future<void> stopRecording(Function() onStop) async {
    currentAction = RecorderAction.play;
    playerMode = true;
    await recorder.stop();

    await amplitudeSubscription?.cancel();

    player.playerStateStream.listen((state) {
      if (player.duration != null) recordingDuration = player.duration!;
      onStop();
    });
  }

  // Future<void> deleteRecording() async {
  //   currentAction = RecorderAction.start;
  //   playerMode = false;
  //   audioPosition = 0;
  //   amplitudesMax.clear();
  //   amplitudesList.clear();
  //   await amplitudeSubscription?.cancel();
  //   recordingWatch.reset();
  //   await recorder.stop();
  //   playingDuration = const Duration();
  //   await player.stop();
  //
  //   amplitudeSubscription = null;
  //   recordingWatch = Stopwatch();
  //   recorder = AudioRecorder();
  //   playingDuration = const Duration();
  //   player = AudioPlayer();
  // }

  void dispose() {
    recorder.dispose();
    player.dispose();
  }
}
