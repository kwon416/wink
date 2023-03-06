import 'package:bloc/bloc.dart';

class PresntationComponent {
  final Bloc bloc;

  PresntationComponent() {
    bloc.add(AppStarted());
  }

  build(){

  }
}