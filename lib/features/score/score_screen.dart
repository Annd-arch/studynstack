// lib/features/score/score_screen.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../utils/constants.dart';

class ScoreScreen extends StatelessWidget {
  final int scorePercentage;
  final String deckName;

  const ScoreScreen(
      {super.key, required this.scorePercentage, required this.deckName});

  // Hitung berapa bintang yang terisi (20% per bintang)
  int _filledStars(int percent) {
    final val = (percent / 20).round();
    if (val < 1) return 1;
    if (val > 5) return 5;
    return val;
  }

  // Pesan berdasarkan threshold (sesuai mockup)
  String _getMessage(int percent) {
    if (percent >= 60) {
      return 'Ini menunjukkan bahwa Anda tidak hanya hafal, tetapi juga benar-benar memahami sebagian besar materi ini. Kerja bagus, Terus pertahankan!';
    } else {
      return 'Kerja bagus telah mencoba! Setiap kesalahan adalah kesempatan baru untuk belajar. Ulangi materi dan fokus pada bagian yang kurang dipahami.';
    }
  }

  // Judul ringkasan singkat (opsional)
  String _getTitle(int percent) {
    if (percent >= 60) return 'Hasil Akhir (≥ 60%)';
    return 'Hasil Akhir (< 60%)';
  }

  @override
  Widget build(BuildContext context) {
    final filled = _filledStars(scorePercentage);
    final message = _getMessage(scorePercentage);
    final title = _getTitle(scorePercentage);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title:
            Text(deckName, style: const TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
          child: Column(
            children: [
              // Percentage circle
              CircularPercentIndicator(
                radius: 72.0,
                lineWidth: 12.0,
                percent: (scorePercentage / 100).clamp(0.0, 1.0),
                center: Text(
                  '$scorePercentage%',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                progressColor: AppColors.primaryColor,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
              ),

              const SizedBox(height: 20),

              // Stars row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final idx = i + 1;
                  final filledStar = idx <= filled;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Icon(
                      Icons.star,
                      size: 34,
                      color: filledStar ? Colors.black87 : Colors.black12,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 18),

              // Explanatory card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 10),
                      Text(message,
                          style: const TextStyle(fontSize: 14, height: 1.4)),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Lanjut ke Menu
              GestureDetector(
                onTap: () {
                  // Kembali ke layar pertama (root)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text(
                  'Lanjut ke Menu',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black87,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
