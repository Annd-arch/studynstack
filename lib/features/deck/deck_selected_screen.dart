// lib/features/deck/deck_selected_screen.dart
import 'package:flutter/material.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';
import '../recap/recap_screen.dart';
import 'sub_deck_selection_screen.dart';

class DeckSelectedScreen extends StatefulWidget {
  final IsarService isarService;
  final List<int> selectedDeckIds;
  final List<Deck>? selectedDecksOptional;

  const DeckSelectedScreen({
    super.key,
    required this.isarService,
    required this.selectedDeckIds,
    this.selectedDecksOptional,
  });

  @override
  State<DeckSelectedScreen> createState() => _DeckSelectedScreenState();
}

class _DeckSelectedScreenState extends State<DeckSelectedScreen> {
  List<Deck> _decks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedDecks();
  }

  Future<void> _loadSelectedDecks() async {
    setState(() => _isLoading = true);

    
    if (widget.selectedDecksOptional != null &&
        widget.selectedDecksOptional!.isNotEmpty) {
      _decks = widget.selectedDecksOptional!;
      setState(() => _isLoading = false);
      return;
    }


    try {
      _decks = await widget.isarService.getDecksByIds(widget.selectedDeckIds);
    } catch (e) {
      debugPrint('Error loading selected decks: $e');
      _decks = [];
    }
    setState(() => _isLoading = false);
  }

  void _openRecap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RecapScreen(isarService: widget.isarService)));
  }

  void _gantiMatakuliah() {
    Navigator.pop(context);
  }

  void _openSubDeck(Deck deck) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SubDeckSelectionScreen(
                isarService: widget.isarService, mainDeck: deck)));
  }


  Widget _buildBotBubble() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: const [
          Text('🤖', style: TextStyle(fontSize: 22)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Yuk, kamu tinggal pilih aja matakuliah mana yang mau kamu mulai dulu!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeDeckCard(Deck deck, int index) {
    final bool isPrimary = index % 2 == 0;
    final Color base =
        isPrimary ? AppColors.primaryColor : AppColors.secondaryColor;
    final Color light = base.withOpacity(0.95);
    final Color dark = base.withOpacity(0.65);

    return InkWell(
      onTap: () => _openSubDeck(deck),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 110,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [light, dark]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 6))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Row(
            children: [
              // Text area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(deck.deckName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    FutureBuilder<List>(
                      future: widget.isarService.getCardsForDeck(deck.id),
                      builder: (c, snap) {
                        final cnt = snap.hasData ? snap.data!.length : 0;
                        return Text('$cnt Cards',
                            style: TextStyle(color: Colors.white70));
                      },
                    ),
                  ],
                ),
              ),

           
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: base, width: 3),
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(Icons.play_arrow_rounded, color: base, size: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildFooterIcons() {
    return SafeArea(
      top: false,
      child: Container(
        height: 120,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti Matkul
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _gantiMatakuliah,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 6))
                      ],
                    ),
                    child: Center(
                        child: Icon(Icons.swap_horiz,
                            color: AppColors.primaryColor, size: 34)),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Ganti Mata Kuliah',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12))
              ],
            ),

            const SizedBox(width: 26),

            // Progress
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _openRecap,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 6))
                      ],
                    ),
                    child: Center(
                        child: Icon(Icons.bar_chart,
                            color: AppColors.primaryColor, size: 34)),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Progress',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: const Text("Study N' Stack"),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            // bot bubble
            _buildBotBubble(),
            const SizedBox(height: 18),

            // content area
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _decks.isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada mata kuliah terpilih. Kembali ke chat dan pilih mata kuliah dulu.',
                            style: TextStyle(color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 28),
                          itemCount: _decks.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 18),
                          itemBuilder: (context, index) {
                            return _buildLargeDeckCard(_decks[index], index);
                          },
                        ),
            ),
         
            _buildFooterIcons(),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
