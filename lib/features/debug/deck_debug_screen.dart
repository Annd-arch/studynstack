// lib/features/debug/deck_debug_screen.dart
import 'package:flutter/material.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';

class DeckDebugScreen extends StatefulWidget {
  final IsarService isarService;
  const DeckDebugScreen({super.key, required this.isarService});

  @override
  State<DeckDebugScreen> createState() => _DeckDebugScreenState();
}

class _DeckDebugScreenState extends State<DeckDebugScreen> {
  bool _loading = true;
  List<Deck> _mainDecks = [];
  Map<int, List<Deck>> _subDecksByParent = {};
  Map<int, int> _cardCountByDeck = {};

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    setState(() => _loading = true);
    try {
      final mains = await widget.isarService.getMainDecks();
      final Map<int, List<Deck>> map = {};
      final Map<int, int> counts = {};

      for (final m in mains) {
        final subs = await widget.isarService.getSubDecks(m.id);
        map[m.id] = subs;

        // count cards for main (sum of sub) and for subs
        int mainTotal = 0;
        for (final s in subs) {
          final cards = await widget.isarService.getCardsForDeck(s.id);
          counts[s.id] = cards.length;
          mainTotal += cards.length;
        }
        counts[m.id] = mainTotal;
      }

      setState(() {
        _mainDecks = mains;
        _subDecksByParent = map;
        _cardCountByDeck = counts;
        _loading = false;
      });
    } catch (e) {
      debugPrint('DEBUG loadAll error: $e');
      setState(() => _loading = false);
    }
  }

  Widget _buildRow(Deck deck, {bool isMain = false}) {
    final count = _cardCountByDeck[deck.id] ?? 0;
    return ListTile(
      title: Text(deck.deckName,
          style: TextStyle(
              fontWeight: isMain ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(isMain
          ? 'Main deck — total cards in subs: $count'
          : 'Sub deck — cards: $count'),
      trailing: Text('id:${deck.id}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEBUG: Decks & Cards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAll,
            tooltip: 'Reload',
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _mainDecks.isEmpty
              ? Center(
                  child: Text('No main decks found. DB might be empty.',
                      style: TextStyle(color: Colors.grey[700])))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _mainDecks.length,
                  itemBuilder: (context, idx) {
                    final main = _mainDecks[idx];
                    final subs = _subDecksByParent[main.id] ?? [];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRow(main, isMain: true),
                            const SizedBox(height: 8),
                            const Text('Sub decks:',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            if (subs.isEmpty)
                              Text('  (tidak ada sub-deck)',
                                  style: TextStyle(color: Colors.grey[600]))
                            else
                              ...subs.map((s) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: _buildRow(s),
                                  )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
