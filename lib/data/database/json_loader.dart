// lib/data/database/json_loader.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'schemas.dart';
import 'isar_service.dart';

class JsonLoader {
  final IsarService isarService;
  JsonLoader(this.isarService);

  Future<void> loadMateri({bool force = false}) async {
    final isar = await isarService.db;
    final existing = await isar.decks.count();
    if (!force && existing > 0) {
      debugPrint('JsonLoader: DB sudah berisi data (skip import).');
      return;
    }

    final raw = await rootBundle.loadString('assets/data/materi.json');
    final Map<String, dynamic> data = jsonDecode(raw);

    await isar.writeTxn(() async {
      if (force) {
        await isar.flashCards.clear();
        await isar.decks.clear();
        await isar.studySessions.clear();
        debugPrint('JsonLoader: DB dikosongkan (force=true).');
      }

      for (final matEntry in data.entries) {
        final String mainName = matEntry.key;
        final Map<String, dynamic> subsMap =
            Map<String, dynamic>.from(matEntry.value);
        Deck mainDeck = await _getOrCreateDeck(isar, mainName, parentId: 0);

        for (final subEntry in subsMap.entries) {
          final String subName = subEntry.key;
          final List<dynamic> questions = List<dynamic>.from(subEntry.value);
          Deck subDeck =
              await _getOrCreateDeck(isar, subName, parentId: mainDeck.id);

          for (final q in questions) {
            final card = FlashCard()
              ..deckOwnerId = subDeck.id
              ..question = (q['question'] ?? '').toString()
              ..optionA = (q['A'] ?? '').toString()
              ..optionB = (q['B'] ?? '').toString()
              ..optionC = (q['C'] ?? '').toString()
              ..optionD = (q['D'] ?? '').toString()
              ..correctAnswer = Answer.values.firstWhere(
                  (e) => e.name == (q['answer'] ?? 'A'),
                  orElse: () => Answer.A)
              ..explanation = (q['explanation'] ?? '').toString();

            await isar.flashCards.put(card);
          }
        }
      }
    });

    debugPrint('JsonLoader: import selesai.');
  }

  Future<Deck> _getOrCreateDeck(Isar isar, String name,
      {required int parentId}) async {
    final existing =
        await isar.decks.filter().deckNameEqualTo(name).findFirst();
    if (existing != null) return existing;
    final deck = Deck()
      ..deckName = name
      ..parentDeckId = parentId;
    await isar.decks.put(deck);
    return deck;
  }
}
