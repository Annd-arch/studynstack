import 'package:isar/isar.dart';

part 'schemas.g.dart';

@collection
class Deck {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String deckName;

  late int parentDeckId;

  final cards = IsarLinks<FlashCard>();
}

@collection
class FlashCard {
  Id id = Isar.autoIncrement;

  late int deckOwnerId;

  late String question;
  late String optionA;
  late String optionB;
  late String optionC;
  late String optionD;

  @Enumerated(EnumType.name)
  late Answer correctAnswer;

  // Explanation sekarang nullable agar kompatibel dengan data lama
  String? explanation;
}

@collection
class StudySession {
  Id id = Isar.autoIncrement;

  late String deckName;
  late int scorePercentage;
  late DateTime sessionDate;
}

enum Answer { A, B, C, D }
