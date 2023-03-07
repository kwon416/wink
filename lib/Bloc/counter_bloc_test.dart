import 'package:bloc/bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wink/Bloc/counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    test('initial state is 0', () {
      expect(counterBloc.state, 0);
    });

    blocTest('emits [1] when CounterIncrementPressed is added',
      build: () => counterBloc,
      act: (Bloc bloc) => bloc.add(CounterIncrementPressed()),
      expect: () => [1],
    );

    blocTest('emits [-1] when CounterDecrementPressed is added',
      build: () => counterBloc,
      act: (Bloc bloc) => bloc.add(CounterDecrementPressed()),
      expect: () => [-1],
    );

  });
}