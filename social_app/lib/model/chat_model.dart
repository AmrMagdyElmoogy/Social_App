class ChatModel {
  String receiveId;
  String sendId;
  String dateTime;
  String message;

  ChatModel({
    this.receiveId,
    this.sendId,
    this.dateTime,
    this.message,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    receiveId = json['receiveId'];
    sendId = json['sendId'];
    dateTime = json['dateTime'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'receiveId': receiveId,
      'sendId': sendId,
      'dateTime': dateTime,
      'message': message,
    };
  }
}
