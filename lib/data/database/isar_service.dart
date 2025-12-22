import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'schemas.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [DeckSchema, FlashCardSchema, StudySessionSchema],
        directory: dir.path,
        inspector: true,
      );


      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  Future<List<Deck>> getMainDecks() async {
    final isar = await db;
    return isar.decks.filter().parentDeckIdEqualTo(0).findAll();
  }

  Future<List<Deck>> getSubDecks(int parentId) async {
    final isar = await db;
    return isar.decks.filter().parentDeckIdEqualTo(parentId).findAll();
  }

  Future<List<FlashCard>> getCardsForDeck(int deckId) async {
    final isar = await db;
    return isar.flashCards.filter().deckOwnerIdEqualTo(deckId).findAll();
  }

  Future<List<StudySession>> getAllSessions() async {
    final isar = await db;
    return isar.studySessions.where().findAll();
  }

  Future<int> getStudySessionCount(String deckName) async {
    final isar = await db;
    return isar.studySessions.filter().deckNameEqualTo(deckName).count();
  }

  Future<List<Deck>> getDecksByIds(List<int> ids) async {
    final isar = await db;

    final found = await isar.decks.getAll(ids);
    return found.whereType<Deck>().toList();
  }


  Future<void> saveSession(StudySession session) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.studySessions.put(session);
    });
  }


  Future<int> insertDeck(String name, {int parentId = 0}) async {
    final isar = await db;
    final existing =
        await isar.decks.filter().deckNameEqualTo(name).findFirst();
    if (existing != null) return existing.id;

    final deck = Deck()
      ..deckName = name
      ..parentDeckId = parentId;

    await isar.writeTxn(() async {
      await isar.decks.put(deck);
    });

    return deck.id;
  }

  Future<void> insertFlashcard({
    required int deckId,
    required String question,
    required String A,
    required String B,
    required String C,
    required String D,
    required String answer,
    String explanation = '',
  }) async {
    final isar = await db;
    final card = FlashCard()
      ..deckOwnerId = deckId
      ..question = question
      ..optionA = A
      ..optionB = B
      ..optionC = C
      ..optionD = D
      ..correctAnswer = Answer.values.firstWhere((e) => e.name == answer)
      ..explanation = explanation;

    await isar.writeTxn(() async {
      await isar.flashCards.put(card);
    });
  }

  Future<void> _prePopulate(Isar isar) async {

    return;
  }
}