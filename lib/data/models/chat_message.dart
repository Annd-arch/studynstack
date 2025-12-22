// lib/data/models/chat_message.dart
import 'package:flutter/foundation.dart';

enum MessageType { text, action, typing }

class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final MessageType type;
  final DateTime timestamp;
  final dynamic meta; // optional payload, e.g. {'decks': List<Deck>}

  ChatMessage({
    String? id,
    required this.message,
    required this.isUser,
    this.type = MessageType.text,
    this.meta,
    DateTime? timestamp,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp = timestamp ?? DateTime.now();

  ChatMessage copyWith({
    String? message,
    bool? isUser,
    MessageType? type,
    dynamic meta,
  }) {
    return ChatMessage(
      id: id,
      message: message ?? this.message,
      isUser: isUser ?? this.isUser,
      type: type ?? this.type,
      meta: meta ?? this.meta,
      timestamp: timestamp,
    );
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, message: $message, isUser: $isUser, type: $type, meta: $meta)';
  }
}
