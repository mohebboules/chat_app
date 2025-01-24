import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(message: _loginErrorClassification(e)));
    } catch (e) {
      emit(LoginFailure(message: 'Something went wrong'));
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
