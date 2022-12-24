class CommandReqResponse {
  int appliedValue = 0;
  bool status = false;
  String? error;

  CommandReqResponse(this.status, this.appliedValue);

  CommandReqResponse.fromJson(Map<String, dynamic> json) {
    status = json['result'];
    appliedValue = 0;
  }

  static CommandReqResponse withError(String msg) {
    var p = CommandReqResponse(false, 0);
    p.error = msg;
    return p;
  }
}
