import 'package:flutter/material.dart';
import '../models/stories_data_model.dart';

class StoryItem extends StatelessWidget {
  final StoryModel story;

  const StoryItem({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stack: avatar + optional "+" badge for "My status"
          Stack(
            children: [
              // ── CircleAvatar (story ring border) ──
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: story.isMe ? Colors.grey : const Color(0xFF2ECC71),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(story.avatarUrl),
                ),
              ),
              // "+" icon for My Status
              if (story.isMe)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2ECC71),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          // ── Text label below avatar ──
          Text(
            story.name,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
