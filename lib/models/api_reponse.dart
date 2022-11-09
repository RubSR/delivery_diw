class ApiResponse{
  late Object _data;
  late bool _error;
  String? _apiErrorMessage;

  Object get data => _data;

  set data(Object value) {
    _data = value;
  }

  String get apiErrorMessage => _apiErrorMessage!;

  set apiErrorMessage(String value) {
    _apiErrorMessage = value;
  }

  bool get error => _error;

  set error(bool value) {
    _error = value;
  }
}