import 'package:flutter/material.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';
import 'deck_screen.dart';

class SubDeckSelectionScreen extends StatelessWidget {
  final IsarService isarService;
  final Deck mainDeck;

  const SubDeckSelectionScreen(
      {super.key, required this.isarService, required this.mainDeck});

  void _startDeckSession(BuildContext context, Deck subDeck) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DeckScreen(
                isarService: isarService,
                deckId: subDeck.id,
                deckName: subDeck.deckName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(mainDeck.deckName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Deck>>(
        future: isarService.getSubDecks(mainDeck.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          final subDecks = snapshot.data ?? [];
          if (subDecks.isEmpty) {
            return Center(
                child: Text('Tidak ada Sub-Materi untuk ${mainDeck.deckName}'));
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                // small bot bubble
                Row(children: [
                  const Text('🤖', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 6)
                          ]),
                      child: Text('Pilih materi yang ingin kamu mulai ya!',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView.separated(
                    itemCount: subDecks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, i) {
                      final s = subDecks[i];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 6,
                        child: InkWell(
                          onTap: () => _startDeckSession(context, s),
                          borderRadius: BorderRadius.circular(14),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(s.deckName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        const SizedBox(height: 6),
                                        FutureBuilder<List>(
                                          future:
                                              isarService.getCardsForDeck(s.id),
                                          builder: (c, snap) {
                                            final count = snap.hasData
                                                ? snap.data!.length
                                                : 0;
                                            return Text('$count Cards',
                                                style: TextStyle(
                                                    color: Colors.grey[600]));
                                          },
                                        ),
                                      ]),
                                ),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: AppColors.cardBackground,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Icon(Icons.play_circle_outline,
                                      color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
