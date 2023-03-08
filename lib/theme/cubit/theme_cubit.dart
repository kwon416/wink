import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);


  void toggleTheme(bool isDark) {
    isDark
        ?emit(ThemeMode.dark)
        :emit(ThemeMode.light);
  }

  @override
  void onChange(Change<ThemeMode> change) {
    print(change);
    super.onChange(change);
  }
}