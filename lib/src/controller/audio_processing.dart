import 'dart:typed_data';

List<int> createWavHeader({
  int sampleRate = 44100,
  int numChannels = 1,
  int bitsPerSample = 16,
  required int dataSize, // Add this parameter
}) {
  var bytesPerSample = bitsPerSample ~/ 8;
  var blockAlign = numChannels * bytesPerSample;

  var h = BytesBuilder();

  // RIFF chunk descriptor
  h.add('RIFF'.codeUnits);
  h.addInt32(36 + dataSize, Endian.little); // Total file size - 8
  h.add('WAVE'.codeUnits);

  // fmt sub-chunk
  h.add('fmt '.codeUnits);
  h.addInt32(16, Endian.little); // Subchunk1Size
  h.addInt16(1, Endian.little); // AudioFormat (PCM = 1)
  h.addInt16(numChannels, Endian.little); // NumChannels
  h.addInt32(sampleRate, Endian.little); // SampleRate
  h.addInt32(sampleRate * blockAlign, Endian.little); // ByteRate
  h.addInt16(blockAlign, Endian.little); // BlockAlign
  h.addInt16(bitsPerSample, Endian.little); // BitsPerSample

  // data sub-chunk
  h.add('data'.codeUnits);
  h.addInt32(dataSize, Endian.little); // Data size

  return h.takeBytes();
}

// Extension methods to help with writing integers
extension on BytesBuilder {
  void addInt16(int value, Endian endian) {
    add(Uint8List(2)..buffer.asByteData().setInt16(0, value, endian));
  }

  void addInt32(int value, Endian endian) {
    add(Uint8List(4)..buffer.asByteData().setInt32(0, value, endian));
  }
}

List<double> interpolateList(List<double> inputList) {
  // If input list is empty
  if (inputList.isEmpty) return List.filled(65, 0.0);

  // If input list is >= 65, return first 65 elements
  if (inputList.length >= 65) {
    return inputList.sublist(0, 65);
  }

  List<double> outputList = [];
  int pointsPerSegment = 65 ~/ inputList.length;
  int remainingPoints = 65 % inputList.length;

  // Handle each segment
  for (int i = 0; i < inputList.length; i++) {
    double start = inputList[i];
    double end = inputList[(i + 1) % inputList.length];
    double difference = end - start;
    double step = difference / pointsPerSegment;

    // Add extra point to some segments to reach 65 total points
    int extraPoint = (i < remainingPoints) ? 1 : 0;

    for (int j = 0; j < pointsPerSegment + extraPoint; j++) {
      outputList.add(start + (step * j));
    }
  }

  return outputList;
}
