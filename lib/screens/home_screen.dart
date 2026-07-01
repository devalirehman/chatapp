import 'package:chat_box/models/stories_sample_model.dart';
import 'package:flutter/material.dart';
import '../widgets/Chat_Tile_Widget.dart';
import '../widgets/story_item_widget.dart';
import 'call_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // ✅ Har tab ki apni screen
  late final List<Widget> _screens = [
    _MessagesBody(),   // index 0 — Message
    const CallScreen(),     // index 1 — Calls
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,

      // ✅ AppBar sirf Messages tab par dikhe
      appBar: selectedIndex == 0
          ? AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.white),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 92),
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: CircleAvatar(
              backgroundImage: NetworkImage(stories[0].avatarUrl),
            ),
          ),
        ],
      )
          : null, // other tabs ka apna AppBar hoga

      // ✅ IndexedStack — tabs ke beech switch hoti hai screen
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF2ECC71),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey[900],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting   ,
        iconSize: 27,
        onTap: (i) => setState(() => selectedIndex = i), // ✅ yeh ab kaam karta hai
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ✅ Messages body alag widget mein nikala — clean code
class _MessagesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 229,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            itemCount: stories.length,
            itemBuilder: (context, index) =>
                StoryItem(story: stories[index]),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(45),
              ),
            ),
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  ChatTile(chat: chats[index]),
              separatorBuilder: (_, __) =>
              const Divider(indent: 76, endIndent: 16, height: 1),
              itemCount: chats.length,
            ),
          ),
        ),
      ],
    );
  }
}