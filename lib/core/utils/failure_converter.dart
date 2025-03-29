
import '../errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (ServerFailure):
      return 'Server Failure';
    case const (CacheFailure):
      return 'Cache Failure';
    case const (EmptyFailure):
      return 'Empty Failure';
    case const (CredentialFailure):
      return 'Wrong Email or Password';
    case const (DuplicateEmailFailure):
      return 'Email already taken';
    case const (PasswordNotMatchFailure):
      return 'Password not match';
    case const (InvalidEmailFailure):
      return 'Invalid email format';
    case const (InvalidPasswordFailure):
      return 'Invalid password format';
    default:
      return 'Unexpected error';
  }
}
