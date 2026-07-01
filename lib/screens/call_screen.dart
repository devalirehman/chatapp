import 'package:chat_box/widgets/call_Item_widget.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff002D26),

      body: SafeArea(
        child: Column(
          children: [

            /// TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 31,
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  /// Search Button
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xff002D26),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),

                  const Text(
                    "Calls",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// Add Call Button
                  CircleAvatar(
                    radius: 25,
                    backgroundColor:
                    Colors.white.withOpacity(0.1),
                    child: const Icon(
                      Icons.add_call,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            /// WHITE CONTAINER
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),

                child: Column(
                  children: [

                    const SizedBox(height: 18),

                    /// Small Line
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Recent Text
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20),
                      child: Align(
                        alignment:
                        Alignment.centerLeft,
                        child: Text(
                          "Recent",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// LIST
                    Expanded(
                      child: ListView(
                        children: const [

                          CallTile(
                            image:
                            "assets/person1.jpg",
                            name: "Team Align",
                            subtitle:
                            "Today, 09:30 AM",
                            isMissed: false,
                          ),

                          CallTile(
                            image:
                            "assets/person2.jpg",
                            name:
                            "Jhon Abraham",
                            subtitle:
                            "Today, 07:30 AM",
                            isMissed: false,
                          ),

                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                          CallTile(
                            image:
                            "assets/person3.jpg",
                            name:
                            "Sabila Sayma",
                            subtitle:
                            "Yesterday, 07:35 PM",
                            isMissed: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}