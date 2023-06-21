part of 'language_bloc.dart';

class LanguageState{

  final String lg;
  LanguageState({required this.lg});
  
  LanguageState copyWith({String? language}) {
    return LanguageState(lg: language ?? this.lg);
  }
}

// class LanguageInitial extends LanguageState {}
