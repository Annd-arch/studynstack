import 'package:flutter/material.dart';
import '../../../data/database/schemas.dart';
import '../../../utils/constants.dart';

class DeckSelector extends StatelessWidget {
  final Deck deck;
  final VoidCallback onTap;

  const DeckSelector({super.key, required this.deck, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color color;
    final name = deck.deckName.toLowerCase();
    if (name.contains("jaringan") || name.contains("sistem")) {
      color = AppColors.secondaryColor;
    } else {
      color = AppColors.primaryColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.08),
          foregroundColor: color,
          side: BorderSide(color: color, width: 1),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(deck.deckName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
