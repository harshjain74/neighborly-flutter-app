import 'package:dartz/dartz.dart';
import 'package:neighborly_flutter_app/core/error/failures.dart';
import 'package:neighborly_flutter_app/features/authentication/domain/entities/auth_response_entity.dart';
import 'package:neighborly_flutter_app/features/authentication/domain/repositories/auth_repository.dart';

class SignupWithEmailUsecase {
  final AuthRepository repository;

  SignupWithEmailUsecase(this.repository);

  Future<Either<Failure, AuthResponseEntity>> call(
      String email, String password) async {
    return await repository.signupWithEmail(
      email: email,
      password: password,
    );
     
  }
}
