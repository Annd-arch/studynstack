// lib/features/deck/sub_deck_selection_screen.dart
import 'package:flutter/material.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';
import '../deck/deck_screen.dart';

class SubDeckSelectionScreen extends StatefulWidget {
  final IsarService isarService;
  final Deck mainDeck;

  const SubDeckSelectionScreen({
    Key? key,
    required this.isarService,
    required this.mainDeck,
  }) : super(key: key);

  @override
  State<SubDeckSelectionScreen> createState() => _SubDeckSelectionScreenState();
}

class _SubDeckSelectionScreenState extends State<SubDeckSelectionScreen> {
  bool _isLoading = true;
  List<Deck> _subDecks = [];

  @override
  void initState() {
    super.initState();
    _loadSubDecks();
  }

  Future<void> _loadSubDecks() async {
    setState(() => _isLoading = true);
    try {
      final subs = await widget.isarService.getSubDecks(widget.mainDeck.id);
      setState(() {
        _subDecks = subs;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading sub decks: $e');
      setState(() {
        _subDecks = [];
        _isLoading = false;
      });
    }
  }

  void _openDeck(Deck deck) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeckScreen(
          isarService: widget.isarService,
          deckId: deck.id,
          deckName: deck.deckName,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: const [
          Text('🤖', style: TextStyle(fontSize: 22)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Pilih materi yang ingin kamu mulai ya!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubDeckItem(BuildContext context, Deck deck) {
    return InkWell(
      onTap: () => _openDeck(deck),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 92,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(0, 6))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // left: text (title + subtitle) - flexible
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title - allow 2 lines, ellipsis if too long
                    Text(
                      deck.deckName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    FutureBuilder<List>(
                      future: widget.isarService.getCardsForDeck(deck.id),
                      builder: (c, snap) {
                        final count = snap.hasData ? snap.data!.length : 0;
                        return Text('$count Cards',
                            style: TextStyle(color: Colors.grey[700]));
                      },
                    ),
                  ],
                ),
              ),

              // right: fixed-size circle play button (doesn't push text)
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow_rounded,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.mainDeck.deckName),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 18),
                  Expanded(
                    child: _subDecks.isEmpty
                        ? Center(
                            child: Text(
                                'Tidak ada sub-materi untuk ${widget.mainDeck.deckName}',
                                style: TextStyle(color: Colors.grey[700])))
                        : ListView.separated(
                            itemCount: _subDecks.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, idx) {
                              final d = _subDecks[idx];
                              return _buildSubDeckItem(context, d);
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
