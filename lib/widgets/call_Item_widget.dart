import 'package:flutter/material.dart';

class CallTile extends StatelessWidget {
  final String image;
  final String name;
  final String subtitle;
  final bool isMissed;

  const CallTile({
    super.key,
    required this.image,
    required this.name,
    required this.subtitle,
    required this.isMissed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 35,
        backgroundImage:
        AssetImage(image),
      ),

      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Row(
        children: [

          Icon(
            Icons.call_received,
            color: isMissed
                ? Colors.red
                : Colors.green,
            size: 18,
          ),

          const SizedBox(width: 5),

          Text(subtitle),
        ],
      ),

      trailing: SizedBox(
        width: 60,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: const [

            Icon(Icons.call_outlined,
                color: Colors.grey),

            Icon(Icons.videocam_outlined,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }
}