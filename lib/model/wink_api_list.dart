class WinkApiListModel {
  final String message;
  final String code;
  final List result;
  final Map<String, dynamic> paging;

  WinkApiListModel({required this.message, required this.code, required this.result, required this.paging});

  factory WinkApiListModel.fromJson(Map<String, dynamic> json) {
    return WinkApiListModel(
        message: json['message'] as String,
        code: json['code'] as String,
        result: json['result'] as List,
      paging: json['paging'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'result': result,
    'paging': paging
  };

  @override
  String toString() {
    return "{message: $message, code: $code, result: $result, paging: $paging}";
  }

}