class MessageModel {
  String reciverId;
  String senderId;
  String text;
  String dateTime;
  MessageModel({this.dateTime, this.text, this.reciverId, this.senderId});
  MessageModel.fromJson(Map<String, dynamic> json) {
    reciverId = json['reciverId'];
    senderId = json['senderId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'reciverId': reciverId,
      'senderId': senderId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
