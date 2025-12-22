// lib/features/recap/progress_screen.dart
import 'package:flutter/material.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../utils/constants.dart';

class ProgressScreen extends StatefulWidget {
  final IsarService isarService;
  const ProgressScreen({super.key, required this.isarService});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _loading = true;
  Map<String, List<StudySession>> _grouped = {};
  List<String> _deckNames = [];
  String? _selectedDeck;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final sessions = await widget.isarService.getAllSessions();
    sessions.sort((a, b) => a.sessionDate.compareTo(b.sessionDate));

    final Map<String, List<StudySession>> grouped = {};
    for (var s in sessions) {
      grouped.putIfAbsent(s.deckName, () => []);
      grouped[s.deckName]!.add(s);
    }

    setState(() {
      _grouped = grouped;
      _deckNames = grouped.keys.toList();
      _selectedDeck = _deckNames.isNotEmpty ? _deckNames.first : null;
      _loading = false;
    });
  }

  String _shortDate(DateTime dt) =>
      '${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final sessions =
        _selectedDeck != null ? (_grouped[_selectedDeck] ?? []) : [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Progress Belajar"),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bot bubble
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Row(
                      children: [
                        Text("🤖", style: TextStyle(fontSize: 22)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Berikut perkembangan nilai kamu berdasarkan mata kuliah.",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Dropdown
                  Row(
                    children: [
                      const Text(
                        "Mata Kuliah:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedDeck,
                          items: _deckNames
                              .map((name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedDeck = v),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Chart Box
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 260,
                      child: sessions.isEmpty
                          ? Center(
                              child: Text(
                                "Belum ada sesi untuk $_selectedDeck",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: CustomPaint(
                                    size: Size.infinite,
                                    painter: _SimpleLinePainter(
                                      values: sessions
                                          .map<double>((s) =>
                                              s.scorePercentage.toDouble())
                                          .toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 26,
                                  child: Row(
                                    children: sessions
                                        .map(
                                          (s) => Expanded(
                                            child: Center(
                                              child: Text(
                                                _shortDate(s.sessionDate),
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text("Riwayat Sesi",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  // Session list
                  Expanded(
                    child: sessions.isEmpty
                        ? Center(
                            child: Text('Tidak ada riwayat.',
                                style: TextStyle(color: Colors.grey[700])),
                          )
                        : ListView.separated(
                            itemCount: sessions.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 10),
                            itemBuilder: (context, i) {
                              final s = sessions[i];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  child: Text(
                                    '${s.scorePercentage}%',
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                                title: Text(
                                    '${_shortDate(s.sessionDate)}  •  ${s.scorePercentage}%'),
                                subtitle: Text(
                                  s.deckName,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

// CHART progress

class _SimpleLinePainter extends CustomPainter {
  final List<double> values; 

  _SimpleLinePainter({required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final leftPad = 30.0;
    final rightPad = 10.0;
    final topPad = 10.0;
    final bottomPad = 20.0;

    final chartW = size.width - leftPad - rightPad;
    final chartH = size.height - topPad - bottomPad;

   
    final guidePaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = topPad + chartH * (i / 4);
      canvas.drawLine(
          Offset(leftPad, y), Offset(leftPad + chartW, y), guidePaint);
    }

    if (values.isEmpty) return;

    final dotPaint = Paint()..color = AppColors.primaryColor;
    final linePaint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    final step = values.length == 1 ? chartW / 2 : chartW / (values.length - 1);

    for (int i = 0; i < values.length; i++) {
      final x = leftPad + (step * i);
      final normalized = (100 - values[i]) / 100.0;
      final y = topPad + chartH * normalized;

      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);

      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }

    canvas.drawPath(path, linePaint);

    // Draw left labels
    final textStyle = const TextStyle(fontSize: 10, color: Colors.black54);

    for (int i = 0; i <= 4; i++) {
      final val = 100 - (i * 25);
      final y = topPad + chartH * (i / 4);
      final tp = TextPainter(
          text: TextSpan(text: '$val', style: textStyle),
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(4, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _SimpleLinePainter old) => old.values != values;
}
