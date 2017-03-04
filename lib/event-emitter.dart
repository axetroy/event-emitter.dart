class EventEmitter {

  Map<String, List<Function>> events = new Map();

  EventEmitter() {
  }

  Function on(String event, Function handler) {
    final List eventContainer = this.events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add(handler);
    final Function offThisListener = () {
      eventContainer.remove(handler);
    };
    return offThisListener;
  }

  void once(String event, Function handler) {
    final List eventContainer = this.events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add((data) {
      handler(data);
      this.off(event);
    });
  }

  void off(String event) {
    events.remove(event);
  }

  void emit(String event, [dynamic data]) {
    final List eventContainer = events[event] ?? [];
    eventContainer.forEach((Function handler) {
      if (handler is Function) handler(data);
    });
  }

  void clear() {
    events.clear();
  }
}