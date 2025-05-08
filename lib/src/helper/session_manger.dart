import 'dart:async';

class SessionManager {
  static DateTime? _startTime;
  static Timer? _sessionTimer;

  static void startSession() {
    print('Session Started');
    _startTime = DateTime.now();
    _startTimer();
  }

  static void _startTimer() {
    const thirteenHours = Duration(hours: 12);

    _sessionTimer?.cancel();
    _sessionTimer = Timer(thirteenHours, () {});
  }

  static void resetSession() {
    startSession();
  }

  static void cancelSession() {
    _sessionTimer?.cancel();
  }

  static bool isSessionExpired() {
    if (_startTime == null) return true;

    return DateTime.now().difference(_startTime!) >= Duration(hours: 12);
  }
}
