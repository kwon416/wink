class WinkApiModel {
  final String message;
  final String code;
  final Map<String, dynamic> result;

  WinkApiModel({required this.message, required this.code, required this.result});

  factory WinkApiModel.fromJson(Map<String, dynamic> json) {
    return WinkApiModel(
        message: json['message'] as String,
        code: json['code'] as String,
        result: json['result'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'result': result
  };

  @override
  String toString() {
    return "{message: $message, code: $code, result: $result}";
  }
}