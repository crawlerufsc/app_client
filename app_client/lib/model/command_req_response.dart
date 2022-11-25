class CommandReqResponse {
  bool status = false;
  String? error;

  CommandReqResponse(this.status);

  CommandReqResponse.fromJson(Map<String, dynamic> json) {
    status = json['result'];
  }

  static CommandReqResponse withError(String msg) {
    var p = CommandReqResponse(false);
    p.error = msg;
    return p;
  }
}
