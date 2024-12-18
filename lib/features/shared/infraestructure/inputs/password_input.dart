import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordInputError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class PasswordInput extends FormzInput<String, PasswordInputError> {


  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PasswordInputError.empty ) return 'El campo es requerido';
    if ( displayError == PasswordInputError.length ) return 'Mínimo 6 caracteres';
    if ( displayError == PasswordInputError.format ) return 'Debe de tener Mayúscula, letras y un número';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return PasswordInputError.empty;
    if ( value.length < 6 ) return PasswordInputError.length;
    if ( !passwordRegExp.hasMatch(value) ) return PasswordInputError.format;

    return null;
  }
}