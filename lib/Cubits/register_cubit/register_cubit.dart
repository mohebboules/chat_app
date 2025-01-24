import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(errorMessage: _registerErrorClassification(e)));
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
}
