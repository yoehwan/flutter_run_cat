import 'dart:async';

typedef TickerCallback = Future Function(int tick);

class Ticker {
  Duration? _duration;
  TickerCallback? _onTick;
  void start({
    required Duration duration,
    required TickerCallback onTick,
  }) {
    _onTick = onTick;
    _duration = duration;
    _trigger = true;
    _run();
  }

  bool _trigger = false;
  bool get isActivate => _trigger;
  int _tick = 0;

  void _run() async {
    while (_trigger) {
      if (_onTick == null || _duration == null) return;
      await _onTick!(_tick);
      await Future.delayed(_duration!);
      _tick++;
    }
  }

  void update({Duration? duration, TickerCallback? onTick}) {
    _duration = duration ?? _duration;
    _onTick = onTick ?? _onTick;
  }

  void dispose() {
    _trigger = false;
    _tick = 0;
  }
}
