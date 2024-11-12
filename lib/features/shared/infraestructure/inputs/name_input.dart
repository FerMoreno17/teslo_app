import 'package:formz/formz.dart';

enum NameInputError { empty, length }

class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure() : super.pure('');

  const NameInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameInputError.empty) return 'El campo es requerido';
    if (displayError == NameInputError.length) return 'Mínimo 6 caracteres';

    return null;
  }

  @override
  NameInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameInputError.empty;
    if (value.length < 6) return NameInputError.length;

    return null;
  }
}
