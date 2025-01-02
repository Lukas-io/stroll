import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stroll/src/utils/recorder_action.dart';

import 'audio_processing.dart';

class Recorder {
  AudioRecorder recorder = AudioRecorder();
  AudioPlayer player = AudioPlayer();

  Stopwatch recordingWatch = Stopwatch();
  Stopwatch playingWatch = Stopwatch();

  double audioPosition = 0;

  List<double> amplitudesList = [];
  List<double> amplitudesMax65 = [];
  StreamSubscription? amplitudeSubscription;
  RecorderAction currentAction = RecorderAction.start;

  bool playerMode = false;

  List<double> get amplitudes {
    if (playerMode) {
      return interpolateList(amplitudesList);
    } else {
      return amplitudesMax65;
    }
  }

  String get timeString {
    int recordingSeconds = recordingWatch.elapsed.inSeconds;
    int recMinutes = (recordingSeconds / 60).floor();
    int recSeconds = recordingSeconds % 60;
    String recordingTime =
        "${recMinutes > 9 ? recMinutes : "0$recMinutes"}:${recSeconds > 9 ? recSeconds : "0$recSeconds"}";

    int playingSeconds = playingWatch.elapsed.inSeconds;
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
      playingWatch.start();

      player.play();

      player.positionStream.listen((position) {
        audioPosition =
            position.inMilliseconds / recordingWatch.elapsedMilliseconds;

        onChanged();
      });

      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          pauseAudio();
          audioPosition = 1;
          onChanged();
        }
      });
    } catch (e) {
      debugPrint("Error playing Audio: $e");
    }
  }

  Future<void> pauseAudio() async {
    currentAction = RecorderAction.play;
    await player.pause();
    playingWatch.stop();
  }

  Future<void> seekAudio(Duration position) async {
    await player.seek(position);
  }

  Future<void> startRecording(
    Function(double amp) onAmplitudeChange,
  ) async {
    currentAction = RecorderAction.stop;

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/recording.wav';
    recordingWatch.start();

    List<int> audioData = [];

    Stream<Uint8List> stream = await recorder.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        numChannels: 1, // Specify channels
        sampleRate: 44100, // Specify sample rate
      ),
    );

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

    amplitudeSubscription = recorder
        .onAmplitudeChanged(const Duration(milliseconds: 48))
        .listen((Amplitude amp) {
      double normalizedAmplitude = 1 - (amp.current.abs() / 60);
      amplitudesList.add(normalizedAmplitude);
      if (amplitudesMax65.length >= 65) amplitudesMax65.removeAt(0);
      amplitudesMax65.add(normalizedAmplitude);

      onAmplitudeChange(normalizedAmplitude);
    });
  }

  Future<void> stopRecording() async {
    currentAction = RecorderAction.play;
    playerMode = true;
    recordingWatch.stop();
    await recorder.stop();

    amplitudeSubscription?.cancel();
  }

  Future<void> deleteRecording() async {
    currentAction = RecorderAction.start;
    playerMode = false;
    audioPosition = 0;
    amplitudesMax65.clear();
    recordingWatch.reset();
    playingWatch.reset();
    player.stop();
  }

  void dispose() {
    recorder.dispose();
    player.dispose();
  }
}
