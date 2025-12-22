// lib/features/recap/recap_screen.dart
import 'package:flutter/material.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';
import 'progress_screen.dart';

class RecapScreen extends StatefulWidget {
  final IsarService isarService;
  const RecapScreen({super.key, required this.isarService});

  @override
  State<RecapScreen> createState() => _RecapScreenState();
}

class _RecapScreenState extends State<RecapScreen> {
  bool _loading = true;
  Map<String, double> _averages = {}; // deckName -> average %
  List<String> _deckNames = [];

  @override
  void initState() {
    super.initState();
    _loadAverages();
  }

  Future<void> _loadAverages() async {
    setState(() => _loading = true);
    try {
      final sessions = await widget.isarService.getAllSessions();
      final Map<String, List<int>> agg = {};
      for (final s in sessions) {
        agg.putIfAbsent(s.deckName, () => []);
        agg[s.deckName]!.add(s.scorePercentage);
      }
      final Map<String, double> avg = {};
      agg.forEach((k, v) {
        final sum = v.fold<int>(0, (p, e) => p + e);
        avg[k] = v.isNotEmpty ? (sum / v.length) : 0.0;
      });

      setState(() {
        _averages = avg;
        _deckNames = avg.keys.toList();
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error load averages: $e');
      setState(() => _loading = false);
    }
  }

  void _openProgress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ProgressScreen(isarService: widget.isarService)),
    ).then((_) => _loadAverages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Rekap Belajar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bot message
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: const Row(
                      children: [
                        Text('🤖', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(
                                'Ringkasan rata-rata skor per mata kuliah. Tekan "Lihat Grafik" untuk detail.')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // No data
                  if (_averages.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                                'Belum ada sesi belajar yang tersimpan.'),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: _openProgress,
                              icon: const Icon(Icons.show_chart),
                              label: const Text('Lihat Grafik'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    // list averages
                    Expanded(
                      child: ListView.separated(
                        itemCount: _deckNames.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final name = _deckNames[i];
                          final percent = _averages[name] ?? 0.0;
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              title: Text(name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: LinearProgressIndicator(
                                        value: (percent / 100).clamp(0.0, 1.0),
                                        minHeight: 10,
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor: AlwaysStoppedAnimation(
                                            AppColors.primaryColor),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text('${percent.toStringAsFixed(0)}%',
                                        style: const TextStyle(
                                            color: Colors.black54)),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.show_chart),
                                onPressed: _openProgress,
                                tooltip: 'Lihat Grafik',
                              ),
                              onTap: _openProgress,
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _openProgress,
                      icon: const Icon(Icons.show_chart),
                      label: const Text('Lihat Grafik Progres'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
