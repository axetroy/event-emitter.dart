class EventEmitter {

  Map<String, List<Function>> events = new Map();

  EventEmitter() {
  }

  Function on(String event, void handler(dynamic data)) {
    final List eventContainer = this.events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add(handler);
    final Function offThisListener = () {
      eventContainer.remove(handler);
    };
    return offThisListener;
  }

  void once(String event, void handler(dynamic data)) {
    final List eventContainer = this.events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add((dynamic data) {
      handler(data);
      this.off(event);
    });
  }

  void off(String event) {
    events.remove(event);
  }

  void emit(String event, [dynamic data]) {
    final List eventContainer = events[event] ?? [];
    eventContainer.forEach((void handler(dynamic data)) {
      if (handler is Function) handler(data);
    });
  }

  void clear() {
    events.clear();
  }
}