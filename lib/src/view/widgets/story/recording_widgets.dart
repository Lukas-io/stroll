import 'package:flutter/material.dart';
import 'package:stroll/src/controller/recorder.dart';
import 'package:stroll/src/utils/extensions.dart';
import 'package:stroll/src/utils/recorder_action.dart';
import 'package:stroll/src/view/widgets/story/waveform_widget.dart';

import '../../../constants/colors.dart';

class RecordingWidgets extends StatefulWidget {
  const RecordingWidgets({super.key});

  @override
  State<RecordingWidgets> createState() => _RecordingWidgetsState();
}

class _RecordingWidgetsState extends State<RecordingWidgets> {
  late Recorder recorder;

  @override
  void initState() {
    recorder = Recorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  void performAction(RecorderAction action, {String? audioPath}) async {
    switch (action) {
      case RecorderAction.start:
        recorder.startRecording((amp) {
          if (mounted) {
            setState(() {});
          }
        });
        break;
      case RecorderAction.delete:
        recorder.deleteRecording();
        break;
      case RecorderAction.play:
        recorder.playAudio(() {
          if (mounted) {
            setState(() {});
          }
        });
        break;

      case RecorderAction.stop:
        recorder.stopRecording();

        break;

      case RecorderAction.pause:
        recorder.pauseAudio();
        break;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          recorder.timeString,
          style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: recorder.currentAction == RecorderAction.stop
                  ? purpleTextColor
                  : greyTextColor),
        ),
        WaveformWidget(
          amplitude: recorder.amplitudes,
          width: 2.0,
          height: 60.0,
          position: recorder.audioPosition,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => performAction(RecorderAction.delete),
              child: Text(
                "Delete",
                style: context.textTheme.titleMedium
                    ?.copyWith(color: greyTextColor),
              ),
            ),
            IconButton(
              onPressed: () => performAction(recorder.currentAction),
              style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                  shape: const CircleBorder(
                      side: BorderSide(color: whiteTextColor, width: 2.5))),
              icon: Icon(
                recorder.icon,
                size: 65.0,
                color: primaryColor,
              ),
            ),
            TextButton(
              onPressed: () => performAction(RecorderAction.delete),
              child: Text(
                "Submit",
                style: context.textTheme.titleMedium
                    ?.copyWith(color: greyTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            performAction(RecorderAction.delete);
          },
          child: Text(
            "Unmatch",
            style: context.textTheme.titleMedium?.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
