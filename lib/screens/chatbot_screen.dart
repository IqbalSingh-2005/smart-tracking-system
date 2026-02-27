import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<_Msg> _messages = [
    _Msg("Hi! I'm your Smart Transport assistant. How can I help you today?", false),
  ];
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();

  static const _quickReplies = [
    'Track Bus', 'ETA Time', 'Nearby Bus', 'Routes',
    'Schedule', 'Book Ticket', 'My Tickets', 'Ticket Price',
    'Seat Availability', 'Travel History', 'Complaint', 'Lost Item',
    'SOS Help', 'Safety Tips', 'Bus Stops', 'Help Guide',
  ];

  String _botReply(String text) {
    final t = text.toLowerCase();
    if (t.contains('track') || t.contains('location')) {
      return 'You can track your bus in real-time on the Track Bus screen. The bus icon shows the live position.';
    } else if (t.contains('eta') || t.contains('time')) {
      return 'ETA depends on live traffic. Check the Track Bus screen for estimated arrival.';
    } else if (t.contains('ticket')) {
      return 'You can book tickets from the Tickets section. Existing tickets are under My Tickets.';
    } else if (t.contains('route')) {
      return 'All available routes can be found in the Routes section with stop-by-stop details.';
    } else if (t.contains('schedule')) {
      return 'Bus schedules are available in the Schedule section with departure and arrival times.';
    } else if (t.contains('sos') || t.contains('help') || t.contains('emergency')) {
      return '🚨 For emergencies, use the red SOS button on the main screen to alert authorities.';
    } else if (t.contains('complaint') || t.contains('lost')) {
      return 'Please contact support at support@smarttransport.in or call 1800-XXX-XXXX.';
    } else {
      return "I'm here to help! You can ask me about bus tracking, tickets, routes, schedules, or emergencies.";
    }
  }

  void _send([String? preset]) {
    final text = preset ?? _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(text, true));
      _messages.add(_Msg(_botReply(text), false));
    });
    _ctrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white24,
              child: Icon(Icons.smart_toy_rounded, size: 18),
            ),
            SizedBox(width: 8),
            Text('Help Bot'),
          ],
        ),
      ),
      body: Column(
        children: [
          /// Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return Align(
                  alignment: m.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: m.isUser
                          ? scheme.primary
                          : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(m.isUser ? 16 : 4),
                        bottomRight: Radius.circular(m.isUser ? 4 : 16),
                      ),
                    ),
                    child: Text(
                      m.text,
                      style: TextStyle(
                        color: m.isUser ? Colors.white : null,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Quick replies
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _quickReplies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) => ActionChip(
                label: Text(_quickReplies[i],
                    style: const TextStyle(fontSize: 12)),
                onPressed: () => _send(_quickReplies[i]),
              ),
            ),
          ),
          const SizedBox(height: 8),

          /// Input
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Ask anything…',
                      filled: true,
                      fillColor: scheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: scheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: _send,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Msg {
  final String text;
  final bool isUser;
  const _Msg(this.text, this.isUser);
}
