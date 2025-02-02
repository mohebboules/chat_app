import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? email;
  String? password;
  bool isLoading = false;
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case LoginEvent():
          await loginEventMethod(event, emit);
        case RegisterEvent():
          await registerEventMethod(emit, event);
      }
    });
  }

  Future<void> registerEventMethod(
      Emitter<AuthState> emit, RegisterEvent event) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(errorMessage: _registerErrorClassification(e)));
    }
  }

  Future<void> loginEventMethod(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(message: _loginErrorClassification(e)));
    } catch (e) {
      emit(LoginFailure(message: 'Something went wrong'));
    }
  }

  String _registerErrorClassification(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "Email already exists. try to log in instead";
      case 'weak-password':
        return "Your Password is weak";
      default:
        {
          debugPrint('unknown error from firebase: ${e.toString()}');
          return 'unknown error occured';
        }
    }
  }

  String _loginErrorClassification(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'user-not-found':
        return "No user was found for that email. try to register intead";

      case 'wrong-password':
        return "Incorrect Password";

      case 'invalid-credential':
        return 'Invalid username or password';

      case 'too-many-requests':
        return "You tried too many times, try again later";

      case 'invalid-email':
        return 'Invalid email';

      default:
        {
          debugPrint('unknown error from firebase: ${e.toString()}');
          return 'unknown error occured';
        }
    }
  }
}
