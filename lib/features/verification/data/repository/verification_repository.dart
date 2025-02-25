import 'package:email_otp/email_otp.dart';

class VerificationRepository{
  Future checkEmailValidationRepository({required String otp})async{
    EmailOTP.verifyOTP(otp: otp);
  }
  Future emailValidationRepository({required String email}) async{
    return await EmailOTP.sendOTP(email: email);
  }
}