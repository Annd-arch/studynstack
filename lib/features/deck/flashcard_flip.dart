// lib/features/deck/flashcard_flip.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/database/schemas.dart'; // FlashCard model from your schemas
import '../../utils/constants.dart';

typedef OnNextCard = void Function();
typedef OnAnswer = void Function(bool isCorrect);

class FlashcardFlip extends StatefulWidget {
  final FlashCard card;
  final OnNextCard? onNext;
  final OnAnswer? onAnswer;
  final bool
      showExplanationButtonOnly; // if true, only show "Berikutnya" on back

  const FlashcardFlip({
    super.key,
    required this.card,
    this.onNext,
    this.onAnswer,
    this.showExplanationButtonOnly = false,
  });

  @override
  State<FlashcardFlip> createState() => _FlashcardFlipState();
}

class _FlashcardFlipState extends State<FlashcardFlip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _isFront = true; // if showing question
  bool _answered = false;
  String? _selectedOption; // 'A'|'B'|'C'|'D'
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _anim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeInOutBack,
    ));
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isFront = false;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _isFront = true;
          // reset if you want to show front again
        });
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onOptionTap(String label) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedOption = label;
      _isCorrect = (widget.card.correctAnswer.name == label);
    });

    // callback to outer (optional)
    widget.onAnswer?.call(_isCorrect);

    // start flip immediately (no typing)
    _ctrl.forward();
  }

  void _onNextPressed() {
    // flip back then call onNext (optional)
    if (!_isFront) {
      // animate back to front quickly then call onNext
      _ctrl.reverse().whenComplete(() {
        // reset state for next card (parent likely swaps card anyway)
        widget.onNext?.call();
        setState(() {
          _answered = false;
          _selectedOption = null;
          _isCorrect = false;
        });
      });
    } else {
      widget.onNext?.call();
    }
  }

  Widget _buildFront(BuildContext context) {
    final card = widget.card;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question text
            Text(
              card.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            // Options
            _optionButton('A', card.optionA),
            const SizedBox(height: 10),
            _optionButton('B', card.optionB),
            const SizedBox(height: 10),
            _optionButton('C', card.optionC),
            const SizedBox(height: 10),
            _optionButton('D', card.optionD),
            const SizedBox(height: 12),
            if (_answered)
              Text(
                _isCorrect ? 'Jawaban benar!' : 'Jawaban salah.',
                style: TextStyle(
                  color: _isCorrect ? AppColors.correct : AppColors.wrong,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _optionButton(String label, String text) {
    final bool disabled = _answered;
    final bool selected = _selectedOption == label;
    final showCorrectHighlight = !_isFront &&
        widget.card.correctAnswer.name == label; // on back show correct

    Color bgColor() {
      if (_isFront) {
        if (disabled && selected) {
          return _isCorrect
              ? AppColors.correct.withOpacity(0.9)
              : AppColors.wrong.withOpacity(0.85);
        }
        return Colors.grey.shade100;
      } else {
        // back side isn't interactive; highlight correct
        if (showCorrectHighlight) return AppColors.correct.withOpacity(0.95);
        if (disabled && selected) return AppColors.wrong.withOpacity(0.85);
        return Colors.grey.shade100;
      }
    }

    Color textColor() {
      if ((_isFront && disabled && selected) ||
          (!_isFront && showCorrectHighlight)) {
        return Colors.white;
      }
      return AppColors.onBackground;
    }

    return GestureDetector(
      onTap: disabled ? null : () => _onOptionTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: selected
                  ? (_isCorrect ? AppColors.correct : AppColors.wrong)
                  : Colors.white,
              child: Text(label,
                  style: TextStyle(
                      color: selected ? Colors.white : AppColors.onBackground)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text, style: TextStyle(color: textColor())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    final explanation = widget.card.explanation ?? '';
    final hasExplanation = explanation.trim().isNotEmpty;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title: Correct / Wrong
            Row(
              children: [
                Icon(_isCorrect ? Icons.check_circle : Icons.error,
                    color: _isCorrect ? AppColors.correct : AppColors.wrong),
                const SizedBox(width: 8),
                Text(
                  _isCorrect ? 'Jawaban Benar' : 'Jawaban Salah',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? AppColors.correct : AppColors.wrong),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Show correct answer label
            Text(
              'Jawaban benar: ${widget.card.correctAnswer.name}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            // Explanation content (or fallback)
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  hasExplanation
                      ? explanation
                      : 'Penjelasan belum tersedia untuk soal ini.',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Berikutnya',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: min(420, size.height * 0.6),
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, child) {
          // progress from 0..1
          final value = _anim.value;
          // angle goes 0..pi
          final angle = value * pi;
          final isFrontVisible = angle <= pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(angle),
            child: isFrontVisible
                ? _buildFront(context)
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateY(pi), // flip content so text reads correctly
                    child: _buildBack(context),
                  ),
          );
        },
      ),
    );
  }
}
