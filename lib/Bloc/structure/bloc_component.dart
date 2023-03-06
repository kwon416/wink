import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink/Bloc/structure/repository.dart';

class BusinessLogicComponent extends Bloc<MyEvent, MyState> {
  BusinessLogicComponent(this.repository) {
    on<AppStarted>((event, emit) {
      try {
        final data = await repository.getAllDataThatMeetsRequirements();
        emit(Success(data));
      } catch {
        emit(Failure(error));
      }
    });
  }

  final Repository repository;
}