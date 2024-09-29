class ApiResponse {
  bool isSuccessful;
  int? statusCode;
  String? message;
  Object? data;
  ApiResponse({
    required this.isSuccessful,
    this.statusCode,
    this.message,
    this.data,
  });

  @override
  String toString() {
    return 'ApiResponse(isSuccessful: $isSuccessful, statusCode: $statusCode, message: $message, data: $data)';
  }
}
