class ChatMessageResponseModel {
  final String id;
  final String message;
  final String reference;
  final DateTime date;

  ChatMessageResponseModel(
      {required this.id,
      required this.message,
      required this.reference,
      required this.date});
}
