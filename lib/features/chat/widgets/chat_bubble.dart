// lib/features/chat/widgets/chat_bubble.dart
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../data/models/chat_message.dart';
import '../../../data/database/schemas.dart';

// Callback types
typedef OnActionPressed = void Function();
typedef OnDeckTap = void Function(Deck deck);

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final OnActionPressed? onActionPressed;
  final OnDeckTap? onDeckTap;

  const ChatBubble({
    super.key,
    required this.message,
    this.onActionPressed,
    this.onDeckTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final radius = 18.0;

    // Typing indicator
    if (message.type == MessageType.typing && !isUser) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatar(),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Dot(),
                    SizedBox(width: 6),
                    _Dot(delay: 120),
                    SizedBox(width: 6),
                    _Dot(delay: 240),
                    SizedBox(width: 12),
                    Text('Champi mengetik...',
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Action type (render deck buttons when meta contains decks)
    if (message.type == MessageType.action && !isUser) {
      final meta = message.meta;
      final decks = (meta != null && meta['decks'] is List)
          ? List<Deck>.from(meta['decks'])
          : <Deck>[];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _avatar(),
                const SizedBox(width: 10),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: Text(
                      message.message,
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: decks
                  .map((d) => DeckSelector(
                        deck: d,
                        onTap: () => onDeckTap?.call(d),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            // Mulai button (if provided)
            if (onActionPressed != null)
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: onActionPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Mulai',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      );
    }

    // User bubble (right-aligned)
    if (isUser) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Text(
                  message.message,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ],
        ),
      );
    }

    // Normal bot bubble (text)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatar(),
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ],
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        shape: BoxShape.circle,
      ),
      child: const Center(child: Text('🤖', style: TextStyle(fontSize: 18))),
    );
  }
}

/// small animated dot for typing indicator
class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({this.delay = 0});
  @override
  __DotState createState() => __DotState();
}

class __DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _c.drive(Tween(begin: 0.25, end: 1.0)),
      child: Container(
          width: 6,
          height: 6,
          decoration:
              BoxDecoration(color: Colors.black38, shape: BoxShape.circle)),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
}

/// DeckSelector: small button used in action messages
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

    return SizedBox(
      height: 40,
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
