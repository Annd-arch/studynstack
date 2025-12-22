import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';
import '../score/score_screen.dart';

class DeckScreen extends StatefulWidget {
  final IsarService isarService;
  final int deckId;
  final String deckName;
  // ⭐ BARU: Batasan pengulangan. Sesuaikan nilai ini.
  final int MAX_ATTEMPTS = 3; 

  const DeckScreen({
    super.key,
    required this.isarService,
    required this.deckId,
    required this.deckName,
  });

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  List<FlashCard> _cards = [];
  int _currentCardIndex = 0;
  int _correctCount = 0;
  bool _isAnswered = false;
  String? _selectedOption;
  String _correctAnswerOption = '';
  // ⭐ BARU: Untuk status apakah deck bisa diakses
  bool _isDeckLocked = false; 

  final List<FlashCard> _incorrectCards = [];

  @override
  void initState() {
    super.initState();
    // ⭐ Panggil pengecekan batasan sebelum memuat kartu
    _checkAttempts(); 
  }

  // ⭐ BARU: Fungsi untuk mengecek jumlah sesi yang sudah dilakukan
  Future<void> _checkAttempts() async {
    final currentAttempts = 
        await widget.isarService.getStudySessionCount(widget.deckName);

    if (currentAttempts >= widget.MAX_ATTEMPTS) {
      setState(() {
        _isDeckLocked = true;
      });
      // Tampilkan notifikasi (atau modal) bahwa batas sudah tercapai
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Batas pengulangan (${widget.MAX_ATTEMPTS}x) untuk ${widget.deckName} telah tercapai.'),
          backgroundColor: AppColors.wrong,
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      _loadCards();
    }
  }

  Future<void> _loadCards() async {
    final cards = await widget.isarService.getCardsForDeck(widget.deckId);
    setState(() {
      // ⭐ FITUR 2: ACAK URUTAN SOAL
      cards.shuffle(); 
      _cards = cards;
      if (cards.isNotEmpty) {
        _correctAnswerOption = cards[0].correctAnswer.name;
      }
    });
  }

  void _processAnswer(String selectedOption) {
    if (_isAnswered || _cards.isEmpty) return;

    final currentCard = _cards[_currentCardIndex];
    _correctAnswerOption = currentCard.correctAnswer.name;
    _selectedOption = selectedOption;
    _isAnswered = true;

    if (selectedOption == _correctAnswerOption) {
      _correctCount++;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jawaban Anda Benar!'),
          backgroundColor: AppColors.correct,
          duration: Duration(milliseconds: 900),
        ),
      );
    } else {
      _incorrectCards.add(currentCard);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jawaban Anda Salah!'),
          backgroundColor: AppColors.wrong,
          duration: Duration(milliseconds: 900),
        ),
      );
    }

    setState(() {});
  }

  void _nextCard() {
    if (_currentCardIndex < _cards.length - 1) {
      setState(() {
        _currentCardIndex++;
        _isAnswered = false;
        _selectedOption = null;
        _correctAnswerOption = _cards[_currentCardIndex].correctAnswer.name;
      });
    } else {
      _finishSession();
    }
  }

  void _finishSession() {
    final totalCards = _cards.length;
    final finalScorePercentage =
        (totalCards > 0) ? (_correctCount * 100 ~/ totalCards) : 0;

    widget.isarService.saveSession(
      StudySession()
        ..deckName = widget.deckName
        ..scorePercentage = finalScorePercentage
        ..sessionDate = DateTime.now(),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
            scorePercentage: finalScorePercentage, deckName: widget.deckName),
      ),
    );
  }

  Widget _buildOptionButton(
      String optionLetter, String optionText, String optionName) {
    final isCorrect = _isAnswered && (optionName == _correctAnswerOption);
    final isWronglySelected =
        _isAnswered && (optionName == _selectedOption) && !isCorrect;

    Color buttonColor;
    Color textColor;
    BorderSide side;

    if (_isAnswered) {
      if (isCorrect) {
        buttonColor = AppColors.correct;
        textColor = Colors.white;
        side = BorderSide.none;
      } else if (isWronglySelected) {
        buttonColor = AppColors.wrong;
        textColor = Colors.white;
        side = BorderSide.none;
      } else {
        buttonColor = AppColors.cardBackground;
        textColor = AppColors.primaryColor;
        side = BorderSide.none;
      }
    } else {
      buttonColor = AppColors.cardBackground;
      textColor = AppColors.primaryColor;
      side = BorderSide(color: AppColors.primaryColor, width: 1);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: OutlinedButton(
        onPressed: _isAnswered ? null : () => _processAnswer(optionName),
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          side: side,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('$optionLetter. $optionText',
              style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _buildExplanationArea(FlashCard card) {
    // ⭐ PERBAIKAN BUG: Mengambil penjelasan dari data kartu
    final explanationText = card.explanation ?? 'Penjelasan belum tersedia untuk soal ini.'; 

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _selectedOption == _correctAnswerOption
             ? AppColors.correct.withOpacity(0.12)
             : AppColors.wrong.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _selectedOption == _correctAnswerOption
              ? AppColors.correct.withOpacity(0.2)
              : AppColors.wrong.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jawaban: $_correctAnswerOption',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _selectedOption == _correctAnswerOption
                      ? AppColors.correct
                      : AppColors.wrong)),
          const SizedBox(height: 8),
          Text('Penjelasan: $explanationText',
              style: TextStyle(color: Colors.grey[800])),
        ],
      ),
    );
  }

  // feedback bot
  Widget _buildBotFeedbackBubble(bool isCorrect) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.correct
            : const Color(0xFFF4C7C7), 
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Text('🤖', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isCorrect
                  ? 'Sip, jangan lupa Dicatat yaa!'
                  : 'Yahh, gapapa dehh, catat jawabannya dan dipahami yaa!',
              style: TextStyle(
                  color: isCorrect ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ⭐ Tampilkan layar kunci jika batas tercapai
    if (_isDeckLocked) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.deckName),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_clock, size: 80, color: AppColors.wrong),
                const SizedBox(height: 20),
                Text(
                  'Batas Pengulangan Tercapai',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Anda telah menyelesaikan sesi ini ${widget.MAX_ATTEMPTS} kali. Silakan coba materi lain atau ulangi besok.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.deckName),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentCard = _cards[_currentCardIndex];
    final totalCards = _cards.length;
    // Perhitungan progress
    final successPercentage = (totalCards > 0 && _isAnswered)
        ? (_correctCount * 100 ~/ totalCards)
        : ((_currentCardIndex * 100) ~/ totalCards);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 64.0,
              lineWidth: 10.0,
              percent: (totalCards > 0)
                  ? (_correctCount / totalCards).clamp(0.0, 1.0)
                  : 0.0,
              center: Text('${successPercentage.toString()}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              progressColor: AppColors.correct,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Text(currentCard.question,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // options
            _buildOptionButton('A', currentCard.optionA, Answer.A.name),
            _buildOptionButton('B', currentCard.optionB, Answer.B.name),
            _buildOptionButton('C', currentCard.optionC, Answer.C.name),
            _buildOptionButton('D', currentCard.optionD, Answer.D.name),

            
            if (_isAnswered) ...[
              _buildExplanationArea(currentCard),
              _buildBotFeedbackBubble(_selectedOption == _correctAnswerOption),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextCard,
                  child: Text(_currentCardIndex == _cards.length - 1
                      ? 'Selesai Sesi'
                      : 'Lanjut'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}