import 'package:flutter/material.dart';
import '../models/message.dart';
import '../widgets/chat/sidebar.dart';
import '../widgets/chat/modal_info_card.dart';
import '../widgets/chat/chat_input.dart';
import '../widgets/chat/chat_messages.dart';
import '../widgets/chat/chat_app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final _textController = TextEditingController();
  bool _isComposing = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
      _textController.clear();
      _isComposing = false;
    });

    // Simulate bot response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(Message(
          text: "I'm an AI assistant. How can I help you today?",
          isUser: false,
        ));
      });
    });
  }

  void _showModelSelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ModelInfoCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isSmallScreen ? const Sidebar() : null,
      body: Row(
        children: [
          if (!isSmallScreen)
            const SizedBox(
              width: 300,
              child: Sidebar(),
            ),
          Expanded(
            child: Scaffold(
              appBar: ChatAppBar(
                isSmallScreen: isSmallScreen,
                onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
                onModelSelect: _showModelSelectionModal,
                onProfilePressed: () => Navigator.pushNamed(context, '/profile'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ChatMessages(messages: _messages),
                  ),
                  ChatInput(
                    controller: _textController,
                    isComposing: _isComposing,
                    onSubmitted: _handleSubmitted,
                    onChanged: (text) {
                      setState(() {
                        _isComposing = text.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}