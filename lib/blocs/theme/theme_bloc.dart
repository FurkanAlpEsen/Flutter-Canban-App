import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDarkTheme: false)) {
    on<ChangeThemeEvent>(_changeTheme);
  }

  void _changeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    if (state.isDarkTheme) {
      emit(state.copyWith(isDarkTheme: false));
    } else {
      emit(state.copyWith(isDarkTheme: true));
    }
  }
}
