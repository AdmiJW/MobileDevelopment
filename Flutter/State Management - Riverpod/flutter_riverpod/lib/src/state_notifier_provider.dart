

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterStatusState extends StateNotifier<String> {
  CounterStatusState() : super('Keep Going');

  void updateCounter(int count) {
    if (count >= 50) {
      state = 'You are doing great';
    } else if (count >= 40) {
      state = 'You are doing good';
    } else if (count >= 30) {
      state = 'You are doing okay';
    } else if (count >= 20) {
      state = 'You are doing bad';
    } else if (count >= 10) {
      state = 'You are doing worse';
    } else {
      state = 'You are doing terrible';
    }
  }


  void update(double bmi) {
    if (bmi >= 25) {
      state = 'You are overweight';
    } else if (bmi >= 18.5) {
      state = 'You are normal';
    } else {
      state = 'You are underweight';
    }
  }
}


final counterStatusProvider = StateNotifierProvider<CounterStatusState, String>((ref) {
  return CounterStatusState();
});