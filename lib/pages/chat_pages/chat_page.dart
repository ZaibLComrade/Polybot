import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/providers/chat_provider.dart';
import 'package:polybot/providers/model_provider.dart';
import 'package:polybot/widgets/chat/modal_info_card.dart';
import 'package:polybot/widgets/chat/chat_input.dart';
import 'package:polybot/widgets/chat/chat_messages.dart';
import 'package:polybot/widgets/chat/sidebar.dart';
import 'package:polybot/widgets/common/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  bool _isComposing = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    final chatProvider = context.read<ChatProvider>();
    final modelProvider = context.read<ModelProvider>();

    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    if (modelProvider.selectedModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an AI model first')),
      );
      return;
    }

    chatProvider.sendMessage(text, modelProvider.selectedModel!.modelId);
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
    final chatProvider = context.watch<ChatProvider>();
    final modelProvider = context.watch<ModelProvider>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: isSmallScreen ? const Sidebar() : null,
      body: Row(
        children: [
          if (!isSmallScreen) const SizedBox(width: 300, child: Sidebar()),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(modelProvider.selectedModel?.name ?? 'Select Model'),
                leading: isSmallScreen
                    ? IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      )
                    : null,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.model_training),
                    onPressed: _showModelSelectionModal,
                    tooltip: 'Select AI Model',
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ChatMessages(messages: chatProvider.messages),
                        if (chatProvider.isTyping)
                          const Positioned(
                            left: 16,
                            bottom: 8,
                            child: TypingIndicator(),
                          ),
                      ],
                    ),
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