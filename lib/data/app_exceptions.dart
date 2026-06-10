class AppExceptions implements Exception {
  final String message;
  final String prefix;

  AppExceptions({
    this.message = '',
    this.prefix = '',
  });

  @override
  String toString() {
    return '$prefix,$message';
  }
}

//TODO: FOR NO INTERNET
class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message: message!, prefix: 'No internet');
}

//TODO: REQUEST TIME OUT
class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException([String? message])
      : super(
          message: message!,
          prefix: 'Request Time Out',
        );
}

//TODO: INTERNAL SERVER ERROR
class ServerException extends AppExceptions {
  ServerException([String? message])
      : super(
          message: message!,
          prefix: 'Internal Server Error',
        );
}

//TODO: INVALID URL FROM SERVER
class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message])
      : super(
    message: message!,
    prefix: 'Invalid Url',
  );
}

//TODO: ERROR WHILE COMMUNICATION
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(
    message: message!,
    prefix: 'Error while communication',
  );
}

//TODO: REQUEST TIME OUT
class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message: message!, prefix: 'Request Time out');
}