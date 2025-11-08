import 'package:flutter/material.dart';
import '../models/chat_conversation.dart';
import '../models/chat_message.dart';
import '../widgets/conversation_tile.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // Mock data for demonstration
  final List<ChatConversation> _conversations = [
    ChatConversation(
      id: '1',
      name: 'Sarah Wilson',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      lastMessage: 'Hey! How are you doing?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      isOnline: true,
      messages: [
        ChatMessage(
          id: '1',
          text: 'Hi there!',
          isMe: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        ChatMessage(
          id: '2',
          text: 'Hello! How can I help you?',
          isMe: true,
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        ),
        ChatMessage(
          id: '3',
          text: 'Hey! How are you doing?',
          isMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
    ),
    ChatConversation(
      id: '2',
      name: 'Mike Johnson',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      lastMessage: 'Thanks for your help!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
      isOnline: false,
      messages: [
        ChatMessage(
          id: '1',
          text: 'Can you help me with something?',
          isMe: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        ChatMessage(
          id: '2',
          text: 'Sure! What do you need?',
          isMe: true,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        ChatMessage(
          id: '3',
          text: 'Thanks for your help!',
          isMe: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ],
    ),
    ChatConversation(
      id: '3',
      name: 'Emily Chen',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      lastMessage: 'See you tomorrow!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 0,
      isOnline: true,
      messages: [
        ChatMessage(
          id: '1',
          text: 'See you tomorrow!',
          isMe: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ],
    ),
    ChatConversation(
      id: '4',
      name: 'David Brown',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      lastMessage: 'Got it, thanks!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
      messages: [
        ChatMessage(
          id: '1',
          text: 'Got it, thanks!',
          isMe: false,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
    ),
  ];

  void _openChat(ChatConversation conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(conversation: conversation),
      ),
    ).then((newMessage) {
      if (newMessage != null && newMessage is ChatMessage) {
        setState(() {
          final index = _conversations.indexWhere((c) => c.id == conversation.id);
          if (index != -1) {
            _conversations[index].messages.add(newMessage);
            _conversations[index] = _conversations[index].copyWith(
              lastMessage: newMessage.text,
              lastMessageTime: newMessage.timestamp,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality can be added here
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // More options can be added here
            },
          ),
        ],
      ),
      body: _conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 100,
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No conversations yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start a new chat to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conversation = _conversations[index];
                return ConversationTile(
                  conversation: conversation,
                  onTap: () => _openChat(conversation),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // New chat functionality can be added here
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}