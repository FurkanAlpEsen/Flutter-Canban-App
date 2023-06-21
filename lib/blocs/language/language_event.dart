part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

// class ChangeLanguageEvent extends LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final String language;

  const ChangeLanguageEvent({
    required this.language,
  });

  @override
  List<Object> get props => [language];
}
