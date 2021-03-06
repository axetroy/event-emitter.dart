# event emitter for Dart
[![Build Status](https://travis-ci.org/axetroy/event-emitter.dart.svg?branch=master)](https://travis-ci.org/axetroy/event-emitter.dart)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Dart](https://img.shields.io/badge/dart-%3E=1.20.0-blue.svg?style=flat-square)

A Dart event emitter implementation without any dependencies.

## Requirement

- dart>=1.20.0

## Usage

```dart
import 'package:ee/ee.dart' show EventEmitter;

void main() {
    EventEmitter event = new EventEmitter();
    
    Function cancelSayHello = event.on('greet', (dynamic name) {
      print('hello ${name}');
    });
    
    Function cancelSayHi = event.on('greet', (dynamic name) {
      print('hi ${name}');
    });
    
    event.emit('greet', 'Axetroy');
    // hello Axetroy
    // hi Axetroy
    
    cancelSayHello();   // remove this listener
    
    event.emit('greet', 'Axetroy');
    // hi Axetroy
    
    event.off('greet');
    
    event.emit('greet', 'Axetroy');   // nothing happen
}
```

## Test
```bash
./scripts/test
```

## Contribute

```bash
git clone https://github.com/axetroy/event-emitter.dart.git
cd ./event-emitter.dart
pub get
./scripts/test
```

You can flow [Contribute Guide](https://github.com/axetroy/event-emitter.dart/blob/master/contributing.md)

## License

The [MIT License](https://github.com/axetroy/event-emitter.dart/blob/master/LICENSE)