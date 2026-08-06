import 'package:flutter/material.dart';
import '../../models/team.dart';

class EngineerScreen extends StatefulWidget {
  final Team team;

  const EngineerScreen({super.key, required this.team});

  @override
  State<EngineerScreen> createState() => _EngineerScreenState();
}

class _EngineerScreenState extends State<EngineerScreen> {
  final TextEditingController controller = TextEditingController();

  final List<_ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "AI RACE ENGINEER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.team.name,
                    style: TextStyle(
                      color: widget.team.tileColor,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Suggested Questions",
                    style: TextStyle(color: Colors.white54, letterSpacing: 2),
                  ),

                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: [
                      _promptChip("When should Norris pit?"),

                      _promptChip("Will rain affect strategy?"),

                      _promptChip("Compare Norris and Piastri"),

                      _promptChip("Who has better pace?"),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white12, height: 1),

            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        "Ask your race engineer anything.",
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),

                      itemCount: messages.length,

                      itemBuilder: (context, index) {
                        final message = messages[index];

                        return Align(
                          alignment: message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,

                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),

                            padding: const EdgeInsets.all(14),

                            constraints: const BoxConstraints(maxWidth: 320),

                            decoration: BoxDecoration(
                              color: message.isUser
                                  ? widget.team.tileColor
                                  : const Color(0xFF151515),

                              borderRadius: BorderRadius.circular(18),
                            ),

                            child: Text(
                              message.text,
                              style: TextStyle(
                                color: message.isUser
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white12)),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,

                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        hintText: "Ask your engineer...",
                        hintStyle: const TextStyle(color: Colors.white38),

                        filled: true,

                        fillColor: const Color(0xFF151515),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  IconButton(
                    onPressed: _sendMessage,

                    icon: Icon(
                      Icons.send_rounded,
                      color: widget.team.tileColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _promptChip(String text) {
    return InkWell(
      onTap: () {
        controller.text = text;
        _sendMessage();
      },

      borderRadius: BorderRadius.circular(24),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        decoration: BoxDecoration(
          color: const Color(0xFF151515),

          borderRadius: BorderRadius.circular(24),

          border: Border.all(
            color: widget.team.tileColor.withValues(alpha: 0.25),
          ),
        ),

        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  void _sendMessage() {
    if (controller.text.trim().isEmpty) {
      return;
    }

    final question = controller.text.trim();

    setState(() {
      messages.add(_ChatMessage(text: question, isUser: true));

      messages.add(_ChatMessage(text: _mockResponse(question), isUser: false));
    });

    controller.clear();
  }

  String _mockResponse(String question) {
    final q = question.toLowerCase();

    if (q.contains("pit")) {
      return "Current tyre degradation suggests pitting around Lap 30.";
    }

    if (q.contains("rain")) {
      return "Weather models indicate low rain probability in the next 20 laps.";
    }

    if (q.contains("compare")) {
      return "Norris currently holds stronger race pace while Piastri has better tyre preservation.";
    }

    return "Based on current race conditions, strategy remains optimal.";
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}
