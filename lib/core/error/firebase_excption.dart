class FirebaseExcption implements Exception {
  String message;
  FirebaseExcption(this.message);
}

class InvalidEmailOrPasswordException extends FirebaseExcption {
  InvalidEmailOrPasswordException(super.message);
}

class WeakPasswordException extends FirebaseExcption {
  WeakPasswordException(super.message);
}

class InvalidEmailException extends FirebaseExcption {
  InvalidEmailException(super.message);
}

class UserDisabledException extends FirebaseExcption {
  UserDisabledException(super.message);
}

class WrongPasswordException extends FirebaseExcption {
  WrongPasswordException(super.message);
}

class UserNotFoundException extends FirebaseExcption {
  UserNotFoundException(super.message);
}

class EmailAlreadyInUseException extends FirebaseExcption {
  EmailAlreadyInUseException(super.message);
}

class OperationNotAllowedException extends FirebaseExcption {
  OperationNotAllowedException(super.message);
}

class UnknownFirebaseException extends FirebaseExcption {
  UnknownFirebaseException(super.message);
}
