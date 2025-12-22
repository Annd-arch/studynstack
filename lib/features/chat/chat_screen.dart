// lib/features/chat/chat_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';
import '../../data/database/isar_service.dart';
import '../../data/database/schemas.dart';
import '../../data/models/chat_message.dart';
import '../../utils/constants.dart';
import '../recap/recap_screen.dart';
import '../deck/deck_selected_screen.dart';
import 'widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final IsarService isarService;
  const ChatScreen({super.key, required this.isarService});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> _messages = [];
  final Random _random = Random();
  final List<Deck> _selectedDecks = [];

  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  void _startConversation() {
    setState(() {
      _messages = [
        ChatMessage(
            message: 'Hi champi mau belajar apa hari ini?', isUser: false),
      ];
    });

    // awal: bot mengetik lalu jawab
    Future.delayed(const Duration(milliseconds: 300), () {
      _showBotTypingThenRespond(
          'Yuk, kamu tinggal pilih aja matakuliah mana yang mau kamu mulai dulu!');
    });
  }

  /// untuk respon umum dari bot
  Future<void> _showBotTypingThenRespond(String response,
      {int typingMillis = 900}) async {
    final typingMsg =
        ChatMessage(message: '', isUser: false, type: MessageType.typing);
    setState(() => _messages.add(typingMsg));
    _scrollToBottom();

    await Future.delayed(Duration(milliseconds: typingMillis));

    setState(() {
      final idx = _messages.indexWhere((m) => m.id == typingMsg.id);
      if (idx >= 0) {
        _messages[idx] =
            typingMsg.copyWith(message: response, type: MessageType.text);
      } else {
        _messages.add(ChatMessage(
            message: response, isUser: false, type: MessageType.text));
      }
    });

    _scrollToBottom();
  }

  /// respon bot setelah milih matkul
  void _addBotImmediate(String text) {
    setState(() {
      _messages.add(
          ChatMessage(message: text, isUser: false, type: MessageType.text));
    });
    _scrollToBottom();
  }

  void _addUser(String text) {
    final userMsg =
        ChatMessage(message: text, isUser: true, type: MessageType.text);
    setState(() => _messages.add(userMsg));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 220,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _addUser(text);
    _controller.clear();
    _detectAndAddDeck(text.toLowerCase());
  }

  Future<void> _detectAndAddDeck(String lower) async {
    try {
      final mains = await widget.isarService.getMainDecks();
      Deck? match;

      for (final d in mains) {
        final title = d.deckName.toLowerCase();
        if (lower.contains(title) || title.contains(lower)) {
          match = d;
          break;
        }
      
      }

      if (match != null) {
        final exists = _selectedDecks.any((e) => e.id == match!.id);
        if (!exists) {
        
          setState(() => _selectedDecks.add(match!));

          _addBotImmediate(
              'Baik, fokus di ${match.deckName}. (ditambahkan ke daftar pilihan)');


          final selectedIdsSnapshot = _selectedDecks.map((d) => d.id).toList();

          final startAction = ChatMessage(
            message: 'Mulai sesi belajar: ${match.deckName}',
            isUser: false,
            type: MessageType.action,
            meta: {
              'showStart': true,
      
              'selectedDeckIds': selectedIdsSnapshot,
          
              'triggerDeckId': match.id,
              'triggerDeckName': match.deckName,
            },
          );

   
          Future.delayed(const Duration(milliseconds: 180), () {
            setState(() => _messages.add(startAction));
            _scrollToBottom();
          });
        } else {
          _addBotImmediate('${match.deckName} sudah ada di daftar pilihanmu.');
        }
      } else {
        _processGeneralText(lower);
      }
    } catch (e, st) {
      debugPrint('detect error: $e\n$st');
      _addBotImmediate('Terjadi kesalahan saat mencari mata kuliah.');
    }
  }

  void _processGeneralText(String lower) async {
    if (lower.contains('terima kasih') || lower.contains('makasih')) {
      final responses = [
        'Sama-sama! Selalu senang membantu Anda.',
        'Tentu, itu tugas saya!',
        'Terima kasih kembali, Champ. Mari kita kuasai materi ini.',
      ];
      await _showBotTypingThenRespond(
          responses[_random.nextInt(responses.length)]);
      return;
    }
    if (lower.contains('rekap') || lower.contains('skor')) {
      await _showBotTypingThenRespond(
          'Progres belajar Anda tersimpan! Lihat rekap di pojok kanan atas.');
      return;
    }

    await _showBotTypingThenRespond(
        'Maaf, saya belum mengerti. Ketik nama mata kuliah untuk menambahkannya ke daftar atau buka daftar mata kuliah.');
  }

  void _navigateToRecap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => RecapScreen(isarService: widget.isarService)));
  }


  void _openDeckSelectedScreen({Map<String, dynamic>? actionMeta}) {
    List<int> idsToOpen = [];
    List<Deck> decksToOpen = [];

    if (actionMeta != null && actionMeta['selectedDeckIds'] != null) {
      final list = List.castFrom<dynamic, int>(actionMeta['selectedDeckIds']);
      idsToOpen = List<int>.from(list);
      
      decksToOpen =
          _selectedDecks.where((d) => idsToOpen.contains(d.id)).toList();


      if (decksToOpen.length != idsToOpen.length) {
     
        widget.isarService.getDecksByIds(idsToOpen).then((fetched) {
          final finalDecks = <Deck>[];
          for (final id in idsToOpen) {
            final foundLocal = decksToOpen.firstWhere(
              (d) => d.id == id,
              orElse: () => fetched.firstWhere((fd) => fd.id == id,
                  orElse: () => Deck()
                    ..id = id
                    ..deckName = 'Deck $id'
                    ..parentDeckId = 0),
            );
            finalDecks.add(foundLocal);
          }
          final ids = finalDecks.map((d) => d.id).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DeckSelectedScreen(
                isarService: widget.isarService,
                selectedDeckIds: ids,
                selectedDecksOptional: finalDecks,
              ),
            ),
          );
        }).catchError((e, st) {
          debugPrint('Error fetching decks by ids: $e\n$st');
       
          final ids = _selectedDecks.map((d) => d.id).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DeckSelectedScreen(
                isarService: widget.isarService,
                selectedDeckIds: ids,
                selectedDecksOptional: List.from(_selectedDecks),
              ),
            ),
          );
        });
        return;
      }


      final ids = decksToOpen.map((d) => d.id).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DeckSelectedScreen(
            isarService: widget.isarService,
            selectedDeckIds: ids,
            selectedDecksOptional: List.from(decksToOpen),
          ),
        ),
      );
      return;
    }

 
    if (actionMeta != null && actionMeta['triggerDeckId'] != null) {
      final triggerId = actionMeta['triggerDeckId'] as int;
      final found = _selectedDecks.firstWhere((d) => d.id == triggerId,
          orElse: () => Deck()
            ..id = triggerId
            ..deckName = actionMeta['triggerDeckName'] ?? 'Deck'
            ..parentDeckId = 0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DeckSelectedScreen(
            isarService: widget.isarService,
            selectedDeckIds: [found.id],
            selectedDecksOptional: [found],
          ),
        ),
      );
      return;
    }


    if (_selectedDecks.isEmpty) {
      _addBotImmediate(
          'Belum ada mata kuliah terpilih. Ketik nama mata kuliah terlebih dulu.');
      return;
    }
    final ids = _selectedDecks.map((d) => d.id).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeckSelectedScreen(
          isarService: widget.isarService,
          selectedDeckIds: ids,
          selectedDecksOptional: List.from(_selectedDecks),
        ),
      ),
    );
  }


  void _onDeckTapFromAction(Deck deck) {
    _addUser(deck.deckName);
    _detectAndAddDeck(deck.deckName.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Study N' Stack",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          IconButton(
              onPressed: _navigateToRecap, icon: const Icon(Icons.bar_chart)),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];

                return ChatBubble(
                  message: msg,
                  onActionPressed: msg.type == MessageType.action &&
                          (msg.meta != null &&
                              (msg.meta['showStart'] == true ||
                                  msg.meta['selectedDeckIds'] != null))
                      ? () {
                          
                          final meta = <String, dynamic>{};
                          if (msg.meta != null) {
                            meta.addAll(Map<String, dynamic>.from(msg.meta));
                          }
                          _openDeckSelectedScreen(actionMeta: meta);
                        }
                      : null,
                  onDeckTap: _onDeckTapFromAction,
                );
              },
            ),
          ),

          // Input area
          Container(
            color: AppColors.cardBackground,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _handleSend(),
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan Anda...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _handleSend,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 6)
                        ]),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
