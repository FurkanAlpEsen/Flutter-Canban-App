import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(lg: 'tr')) {
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  void _changeLanguage(ChangeLanguageEvent event, Emitter<LanguageState> emit){
    // print(state.lg);
    // print(event.language);

    emit(LanguageState(lg: event.language));
      // emit(state.copyWith(language: event.language));
  }
}
