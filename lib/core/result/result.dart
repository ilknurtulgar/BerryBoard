class Result<T> {
  final bool success;
  final T? data;
  final String? message;

  Result._({required this.success, this.data, this.message});

  factory Result.success({T? data, String? message}) =>
      Result._(success: true, data: data, message: message);

  factory Result.error({String? message}) =>
      Result._(success: false, message: message);
}
