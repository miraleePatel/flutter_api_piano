// ignore_for_file: prefer_typing_uninitialized_variables

///******************************************* Exception model class *******************************************///

class ApiException implements Exception {
  final _message;
  final _prefix;
  ApiException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

///***************************** throw exception when failed to communication with server *****************************///

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

///***************************** throw exception when called invalid request *****************************///

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

///***************************** throw exception when pass unauthorised user tokene *****************************///

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

///***************************** throw exception when invalid input from userdata *****************************///

class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
