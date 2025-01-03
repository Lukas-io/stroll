import 'package:flutter/material.dart';
import 'package:stroll/src/controller/recorder.dart';
import 'package:stroll/src/utils/extensions.dart';
import 'package:stroll/src/utils/recorder_action.dart';
import 'package:stroll/src/view/widgets/story/waveform_widget.dart';

import '../../../constants/colors.dart';

class RecordingWidgets extends StatefulWidget {
  final Function() onDelete;

  const RecordingWidgets({super.key, required this.onDelete});

  @override
  State<RecordingWidgets> createState() => _RecordingWidgetsState();
}

class _RecordingWidgetsState extends State<RecordingWidgets> {
  late Recorder recorder;
  double barWidth = 2.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        setState(() {
          recorder.barNumber =
              (MediaQuery.sizeOf(context).width / (barWidth + 4)).floor();
        });
      }
    });
    recorder = Recorder();

    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  Future<void> performAction(RecorderAction action, {String? audioPath}) async {
    switch (action) {
      case RecorderAction.start:
        recorder.startRecording((amp) {
          if (mounted) {
            setState(() {});
          }
        });
        break;
      case RecorderAction.delete:
        // recorder.deleteRecording();
        widget.onDelete();
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
    if (mounted)
      setState(() {
        print(action);
      });
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
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            double seekPosition =
                details.localPosition.dx / MediaQuery.sizeOf(context).width;
            recorder.seekAudio(seekPosition);
          },
          child: Container(
            color: Colors.transparent,
            child: WaveformWidget(
              amplitude: recorder.amplitudes,
              width: barWidth,
              height: 60.0,
              position: recorder.audioPosition,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () async {
                await performAction(RecorderAction.delete);
              },
              child: Text(
                "Delete",
                style: context.textTheme.titleMedium
                    ?.copyWith(color: greyTextColor),
              ),
            ),
            IconButton(
              onPressed: () async {
                await performAction(recorder.currentAction);
              },
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
              onPressed: () async {
                await performAction(RecorderAction.delete);
              },
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
          onPressed: () async {
            Navigator.pop(context);
            await performAction(RecorderAction.delete);
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
