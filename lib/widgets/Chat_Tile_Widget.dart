
import 'package:flutter/material.dart';
import '../models/stories_data_model.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      // ── leading: Stack for online dot ──
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(chat.avatarUrl),
          ),
          if (chat.isOnline)
            Positioned(
              bottom: 3, right: 3,
              child: Container(
                width: 12, height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),

      // ── title ──
      title: Text(
        chat.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),

      // ── subtitle (message preview) ──
      subtitle: Text(
        chat.message,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      // ── trailing: Column with time + unread badge ──
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.time,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
          const SizedBox(height: 4),
          if (chat.unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xFF2ECC71),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${chat.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
