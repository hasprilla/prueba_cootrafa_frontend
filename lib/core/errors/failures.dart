import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class CacheFailure extends Failure {}

class EmptyFailure extends Failure {}

class CredentialFailure extends Failure {}

class DuplicateEmailFailure extends Failure {}

class PasswordNotMatchFailure extends Failure {}

class InvalidEmailFailure extends Failure {}

class InvalidPasswordFailure extends Failure {}

class InvalidAmountFailure extends Failure {
  const InvalidAmountFailure(String message) : super(message: message);
}
