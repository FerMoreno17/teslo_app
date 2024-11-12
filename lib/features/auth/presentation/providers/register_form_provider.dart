import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../shared/infraestructure/inputs/inputs.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final NameInput name;
  final EmailInput email;
  final PasswordInput password;
  final PasswordInput passwordClone;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.name = const NameInput.pure(),
      this.email = const EmailInput.pure(),
      this.password = const PasswordInput.pure(),
      this.passwordClone = const PasswordInput.pure()});

  RegisterFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          NameInput? name,
          EmailInput? email,
          PasswordInput? password,
          PasswordInput? passwordClone}) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email,
          password: password ?? this.password,
          passwordClone: passwordClone ?? this.passwordClone);

  @override
  String toString() {
    return '''
    LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      name: $name
      email: $email
      password: $password
      passwordClone: $passwordClone
 ''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());
  onNameChanged(String value) {
    final newName = NameInput.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate(
            [newName, state.email, state.password, state.passwordClone]));
  }

  onEmailChanged(String value) {
    final newEmail = EmailInput.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid:
            Formz.validate([newEmail,state.name, state.password, state.passwordClone]));
  }

  onPasswordChanged(String value) {
    final newPassword = PasswordInput.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate(
            [newPassword, state.email, state.name, state.passwordClone]));
  }

  onPasswordCloneChanged(String value) {
    final newPasswordClone = PasswordInput.dirty(value);
    state = state.copyWith(
        passwordClone: newPasswordClone,
        isValid: Formz.validate(
            [newPasswordClone, state.email, state.name, state.password]));
  }

  _touchEveryField() {
    final name = NameInput.dirty(state.name.value);
    final email = EmailInput.dirty(state.email.value);
    final password = PasswordInput.dirty(state.password.value);
    final passwordClone = PasswordInput.dirty(state.passwordClone.value);

    state = state.copyWith(
        name: name,
        email: email,
        password: password,
        passwordClone: passwordClone,
        isFormPosted: true,
        isPosting: true,
        isValid: Formz.validate([name, email, password, passwordClone]));
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
  }
}


final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier();
});
