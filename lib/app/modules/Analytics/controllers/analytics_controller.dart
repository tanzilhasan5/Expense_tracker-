import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  final selectedTimeFrame = 'Month'.obs;

  final timeFrames = const ['7 Days', 'Month', 'Year'];

  void changeTimeFrame(String frame) {
    selectedTimeFrame.value = frame;
  }
}
