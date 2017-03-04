import 'package:test/test.dart';
import 'package:event_emitter/event-emitter.dart' show EventEmitter;

void main() {
  EventEmitter emitter;
  setUp(() {
    emitter = new EventEmitter();
  });

  group('init', () {
    test('Init event emitter', () {
      expect(emitter.events, hasLength(0));
    });
  }, skip: false);

  group('on', () {
    test('Listen the event', () {
      expect(emitter.events, hasLength(0));
      bool fired = false;
      emitter.on('demo', (dynamic data) {
        fired = true;
      });
      expect(emitter.events, hasLength(1));
      emitter.emit('demo');
      expect(fired, isTrue);
    });
  }, skip: false);

  group('emit', () {
    test('Listen the event and emit many times', () {
      expect(emitter.events, hasLength(0));
      int firedTimes = 0;
      emitter.on('demo', (dynamic data) {
        firedTimes++;
      });
      expect(firedTimes, equals(0));
      emitter.emit('demo');
      expect(firedTimes, equals(1));
      emitter.emit('demo');
      expect(firedTimes, equals(2));
      emitter.emit('demo');
      expect(firedTimes, equals(3));
    });

    test('Listen the event and .on should return a Function to cancel listening', () {
      expect(emitter.events, hasLength(0));
      int firedTimes = 0;
      Function cancelListen = emitter.on('demo', (dynamic data) {
        firedTimes++;
      });
      expect(firedTimes, equals(0));
      emitter.emit('demo');
      expect(firedTimes, equals(1));

      // cancel listen
      cancelListen();

      // will not happen nothing
      emitter.emit('demo');
      emitter.emit('demo');
      emitter.emit('demo');
      emitter.emit('demo');
      emitter.emit('demo');
//    expect(firedTimes, equals(1));
      // event has been remove
      expect(emitter.events, hasLength(1));
    });

    test('Listen the event once, it should be only run once.', () {
      expect(emitter.events, hasLength(0));
      int firedTimes = 0;
      emitter.once('demo', (dynamic data) {
        firedTimes++;
      });
      expect(firedTimes, equals(0));
      emitter.emit('demo');
      expect(firedTimes, equals(1));
      emitter.emit('demo');
      expect(firedTimes, equals(1));
      emitter.emit('demo');
      expect(firedTimes, equals(1));
    });
  }, skip: true);
}