class ChatMessageResponseModel {
  final String id;
  final String message;
  final String query;
  final String reference;
  final DateTime createdAt;

  ChatMessageResponseModel(
      {required this.id,
      required this.message,
      required this.query,
      required this.reference,
      required this.createdAt});
}
