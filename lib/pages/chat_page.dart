import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybot/models/message.dart';
import 'package:polybot/providers/auth_provider.dart';
import 'package:polybot/providers/chat_provider.dart';
import 'package:polybot/providers/model_provider.dart';
import 'package:polybot/widgets/chat/sidebar.dart';
import 'package:polybot/widgets/chat/modal_info_card.dart';
import 'package:polybot/widgets/chat/chat_input.dart';
import 'package:polybot/widgets/chat/chat_messages.dart';
import 'package:polybot/widgets/chat/chat_app_bar.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize chat session and load models
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final authProvider = context.read<AuthProvider>();
      // final chatProvider = context.read<ChatProvider>();
      final modelProvider = context.read<ModelProvider>();

      // if (authProvider.currentUser != null) {
        // Load available models
        modelProvider.loadModels();
        // Load user's chat sessions
        // chatProvider.loadSessions(authProvider.currentUser!.id);
      // }
    });
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    // final authProvider = context.read<AuthProvider>();
    final chatProvider = context.read<ChatProvider>();
    final modelProvider = context.read<ModelProvider>();

    // if (authProvider.currentUser == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please sign in to send messages')),
    //   );
    //   return;
    // }

    if (modelProvider.selectedModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an AI model first')),
      );
      return;
    }

    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    // Send message
    // chatProvider.sendMessage(text, authProvider.currentUser!.id);
  }

  void _showModelSelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ModelInfoCard(),
    );
  }

  Future<void> _startNewChat() async {
    final authProvider = context.read<AuthProvider>();
    final chatProvider = context.read<ChatProvider>();
    final modelProvider = context.read<ModelProvider>();

    // if (authProvider.currentUser == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please sign in to start a chat')),
    //   );
    //   return;
    // }

    if (modelProvider.selectedModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an AI model first')),
      );
      return;
    }

    try {
      await chatProvider.createNewSession(
        authProvider.currentUser!.id,
        modelProvider.selectedModel!.id,
        'New Chat', // You might want to allow users to set this
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating chat: ${e.toString()}')),
      );
    }
  }

  Widget _buildChatContent(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final authProvider = context.watch<AuthProvider>();

    // if (authProvider.currentUser == null) {
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           'Please sign in to start chatting',
    //           style: Theme.of(context).textTheme.headlineSmall,
    //         ),
    //         const SizedBox(height: 16),
    //         ElevatedButton(
    //           onPressed: () => Navigator.pushNamed(context, '/login'),
    //           child: const Text('Sign In'),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    if (chatProvider.currentSession == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start a new chat',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _startNewChat,
              icon: const Icon(Icons.add),
              label: const Text('New Chat'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ChatMessages(messages: chatProvider.messages),
              if (chatProvider.isTyping)
                Positioned(
                  left: 16,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const TypingIndicator(),
                  ),
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
              ),
              body: _buildChatContent(context),
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