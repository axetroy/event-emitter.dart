import 'package:test/test.dart';
import 'package:ee/ee.dart' show EventEmitter;

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
  }, skip: false);

  group('cancel', () {
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
      expect(firedTimes, equals(1));
      // event has been remove
      expect(emitter.events, hasLength(1));
      // the event key still here
      expect(emitter.events, containsPair('demo', []));
    }, skip: false);

    test('cancel a listening in multiple listnings', () {
      expect(emitter.events, hasLength(0));
      Function cancel1 = emitter.on('1', (dynamic data) {});
      Function cancel2 = emitter.on('2', (dynamic data) {});
      Function cancel3 = emitter.on('3', (dynamic data) {});

      expect(emitter.events.keys, hasLength(3));
      cancel1();
      // will not remove this event, just remove this handler, so the length is unchange
      expect(emitter.events.keys, hasLength(3));
      expect(emitter.events, containsPair('1', []));
    });

    test('cancel a listening in multiple listnings which listen the same key', () {
      expect(emitter.events, hasLength(0));
      listener1(dynamic data) {};
      listener2(dynamic data) {};
      listener3(dynamic data) {};
      Function cancel1 = emitter.on('1', listener1);
      Function cancel2 = emitter.on('1', listener2);
      Function cancel3 = emitter.on('1', listener3);

      expect(emitter.events.keys, hasLength(1));
      expect(emitter.events["1"], hasLength(3));
      cancel1();
      // will not remove this event, just remove this handler, so the length is unchange
      expect(emitter.events.keys, hasLength(1));
      expect(emitter.events["1"], hasLength(2));
      expect(emitter.events["1"][0] == listener2, isTrue);
      expect(emitter.events["1"][1] == listener3, isTrue);

      cancel3();
      expect(emitter.events.keys, hasLength(1));
      expect(emitter.events["1"], hasLength(1));
      expect(emitter.events["1"][0] == listener2, isTrue);

    });
  }, skip: false);

  group('once', () {
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
  }, skip: false);

  group('off', () {
    test('cancel a listening', () {
      bool hasSayHi = false;
      emitter.on('hello', (dynamic name) {
        hasSayHi = true;
      });

      expect(emitter.events, hasLength(1));
      expect(emitter.events, contains('hello'));

      expect(hasSayHi, isFalse);
      emitter.emit('hello', 'axetroy');
      expect(hasSayHi, isTrue);

      emitter.off('hello');
      hasSayHi = false;
      emitter.emit('hello', 'axetroy');
      expect(hasSayHi, isFalse); // it will not trigger the handler again
      expect(emitter.events, isEmpty);
    });
  }, skip: false);


  tearDown(() {
    emitter.clear();
  });
}