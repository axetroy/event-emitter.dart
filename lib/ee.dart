library ee;

class EventEmitter {

  Map<String, List<Function>> _events = new Map();

  Map<String, List<Function>> get events => _events;

  EventEmitter() {
  }

  Function on(String event, void handler(dynamic data)) {
    final List eventContainer = _events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add(handler);
    void offThisListener() {
      eventContainer.remove(handler);
    };
    return offThisListener;
  }

  void once(String event, void handler(dynamic data)) {
    final List eventContainer = _events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add((dynamic data) {
      handler(data);
      this.off(event);
    });
  }

  void off(String event) {
    _events.remove(event);
  }

  void emit(String event, [dynamic data]) {
    final List eventContainer = _events[event] ?? [];
    eventContainer.forEach((void handler(dynamic data)) {
      if (handler is Function) handler(data);
    });
  }

  void clear() {
    _events.clear();
  }
}