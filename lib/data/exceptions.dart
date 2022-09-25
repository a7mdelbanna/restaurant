class TimeOutException implements Exception {
  TimeOutException(this.errorMessage);
  final String errorMessage;
  @override
  toString() {
    return errorMessage;
  }
}

class WrongPasswordException implements Exception {
  WrongPasswordException(this.errorMessage);
  final String errorMessage;
  @override
  toString() {
    return errorMessage;
  }
}

class WrongPhoneException implements Exception {
  WrongPhoneException(this.errorMessage);
  final String errorMessage;
  @override
  toString() {
    return errorMessage;
  }
}

class DataException implements Exception {
  DataException(this.errorMessage);

  final String errorMessage;

  @override
  toString() {
    return errorMessage;
  }
}

class DeniedException implements Exception {
  DeniedException(this.errorMessage);

  final String errorMessage;

  @override
  toString() {
    return errorMessage;
  }
}

class PermissionDeniedPermanentlyException implements Exception {
  PermissionDeniedPermanentlyException(this.errorMessage);

  final String errorMessage;

  @override
  toString() {
    return errorMessage;
  }
}

class SocketException implements Exception {
  SocketException(this.errorMessage);

  final String errorMessage;

  @override
  toString() {
    return errorMessage;
  }
}

class FailedToAddOrderException implements Exception {
  FailedToAddOrderException(this.errorMessage);
  final String errorMessage;
  @override
  toString() {
    return errorMessage;
  }
}
