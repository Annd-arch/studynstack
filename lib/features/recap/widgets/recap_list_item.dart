import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../data/models/recap_summary.dart';
import '../../../utils/constants.dart';

class RecapListItem extends StatelessWidget {
  final RecapDeckSummary summary;

  const RecapListItem({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        summary.deckName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${summary.sessionCount} Sesi Belajar',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${summary.averageScorePercentage}%',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress Bar Rata-rata
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 12.0,
              percent: summary.averageScorePercentage / 100,
              backgroundColor: Colors.grey.shade300,
              progressColor: AppColors.primaryColor,
              barRadius: const Radius.circular(6),
            ),
          ],
        ),
      ),
    );
  }
}
