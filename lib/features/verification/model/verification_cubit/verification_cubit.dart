import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/signup/domain/signup_cubit/signup_cubit.dart';
import 'package:chat_app/features/verification/data/repository/verification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  static VerificationCubit get(context) => BlocProvider.of(context);

  VerificationRepository verificationRepository = VerificationRepository();
SignupCubit signupCubit = SignupCubit();
  Future checkEmailValidationCubit({required String otp}) async {
    emit(LoadingCheckEmailValidationState());
    verificationRepository
        .checkEmailValidationRepository(otp: otp)
        .then((value) {
          
          emit(SuccessfullyCheckEmailValidationState());

    })
        .catchError((error) {
          emit(ErrorCheckEmailValidationState(error.toString()));
    });
  }
  Future emailValidationCubit({required String email}) async {
    emit(LoadingEmailValidationState());
    await verificationRepository
        .emailValidationRepository(email: email)
        .then((value) {
      isExpired = false;
      timeCounter();
      emit(SuccessfullyEmailValidationState());
    })
        .catchError((error) {
      emit(ErrorEmailValidationState(error.toString()));
    });
  }
  int start = 60;
  bool isExpired = false;
  late Timer timer ;
  void timeCounter(){
     start = 60 ;
    const sec = Duration(seconds: 1);
     timer = Timer.periodic(sec, (timer){
      if(start == 0){
        timer.cancel();
        isExpired = true;
        emit(TimeCounterState());
      }else{
        start--;
        emit(TimeCounterState());
      }
    } );


}
  }