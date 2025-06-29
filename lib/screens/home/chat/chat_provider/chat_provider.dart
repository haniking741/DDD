// providers/chat_provider.dart
import 'package:dawini/screens/home/chat/chat_provider/chat_modal.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final List<Chat> _chats = [
    Chat(
        name: 'Carla Schoen',
        message: 'Perfect, will check it',
        time: '09:34 PM',
        image: 'assets/icons/doctor.png',
        isOnline: true),
    Chat(
        name: 'Mrs. Sheila Lemke',
        message: 'Thanks',
        time: '09:34 PM',
        image: 'assets/icons/doctor.png'),
    Chat(
        name: 'Deanna Botsford V',
        message: 'Welcome!',
        time: '09:34 PM',
        image: 'assets/icons/doctor.png'),
    Chat(
        name: 'Mr. Katie Bergnaum',
        message: 'Good Morning!',
        time: '09:34 PM',
        image: 'assets/icons/doctor.png',
        isOnline: true),
    Chat(
        name: 'Armando Ferry',
        message: 'Can I check that?',
        time: '09:34 PM',
        image: 'assets/icons/doctor.png'),
    Chat(
        name: 'Annette Fritsch',
        message: 'Thanks!',
        time: '09:34 PM',
        image: 'assets/icons/doctor.png'),
  ];

  List<Chat> get chats => _chats;
}
