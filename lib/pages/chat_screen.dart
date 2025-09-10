// lib/pages/chat_screen.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessage {
  final String role; // "user" or "bot"
  final String text;
  final DateTime time;

  ChatMessage({required this.role, required this.text, DateTime? time})
    : time = time ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'role': role,
    'text': text,
    'time': time.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    role: json['role'] as String,
    text: json['text'] as String,
    time: DateTime.parse(json['time'] as String),
  );
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _loading = false;

  static const String _prefsKey = 'chat_messages_v1';

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      try {
        final List<dynamic> list = jsonDecode(raw);
        setState(() {
          _messages.addAll(list.map((e) => ChatMessage.fromJson(e)));
        });
      } catch (e) {
        // ignore malformed data
      }
    }
    // Scroll to bottom when loaded
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_messages.map((m) => m.toJson()).toList());
    await prefs.setString(_prefsKey, raw);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(role: 'user', text: text));
      _controller.clear();
      _loading = true;
    });
    _saveMessages();
    _scrollToBottom();

    // Save message to server here if you want (optional)
    // _sendToServer(text);

    // Get a bot reply (simple rule-based)
    final reply = _getBotReply(text);
    // simulate typing delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatMessage(role: 'bot', text: reply));
        _loading = false;
      });
      _saveMessages();
      _scrollToBottom();
    });
  }

  String _getBotReply(String message) {
    final msg = message.toLowerCase();
    if (msg.contains('hi') || msg.contains('hello') || msg.contains('hey')) {
      return 'Hi 👋! Welcome to Food Deli — how can I help you today?';
    }
    if (msg.contains('order') && msg.contains('status')) {
      return 'To check order status, open Orders tab → tap your order. Want me to open Orders for you?';
    }
    if (msg.contains('payment') || msg.contains('pay')) {
      return 'We accept Airtel Money, Mpamba and cards. Need help with a payment now?';
    }
    if (msg.contains('menu') || msg.contains('food') || msg.contains('items')) {
      return 'You can browse the menu on the Home tab. Would you like today\'s popular items?';
    }
    if (msg.contains('promo') || msg.contains('offer')) {
      return 'Today\'s offer: 10% off on selected restaurants 🤑. Check the Offers section!';
    }
    if (msg.contains('support') || msg.contains('help')) {
      return 'I can connect you to support. Type "human" to request a support agent.';
    }
    if (msg.contains('human') || msg.contains('agent')) {
      // Here you could forward to real support (email/DB/agent)
      return 'Okay — I will notify support. They will contact you soon.';
    }
    // fallback
    return 'Sorry, I didn’t quite get that. Try: "order status", "payment", or "menu".';
  }

  // OPTIONAL: Send user message to your server or Supabase for logs / human support.
  // Keep API keys and sensitive logic on server-side — do not embed API keys in the app.
  // Example placeholder (uncomment and implement your HTTP/Supabase call):
  //
  // Future<void> _sendToServer(String userText) async {
  //   // Example: send to your REST endpoint:
  //   // final response = await http.post(Uri.parse('https://yourserver.com/api/messages'),
  //   //   headers: {'Content-Type': 'application/json'},
  //   //   body: jsonEncode({'userId': 'user-123', 'text': userText}),
  //   // );
  //   // handle response...
  // }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildBubble(ChatMessage m) {
    final isUser = m.role == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isUser ? Colors.black : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(isUser ? 14 : 2),
            bottomRight: Radius.circular(isUser ? 2 : 14),
          ),
        ),
        child: Text(
          m.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Chat'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildBubble(msg);
              },
            ),
          ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('...typing', style: TextStyle(color: Colors.grey)),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
