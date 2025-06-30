import 'package:flutter/material.dart';

class MainCard extends StatefulWidget {
  final String tag;
  final String title;
  final List<String> tasks;

  const MainCard({super.key, required this.tag, required this.title, required this.tasks});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "• ${widget.tag}",
                style: TextStyle(color: Colors.grey[500]),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: widget.tasks.take(3).map((task) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    if (widget.tag != "Personal")
                      Text("• ", style: TextStyle(color: Colors.grey[300])),
                    Expanded(
                      child: Text(
                        task,
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          )
        ],
      ),
    );
  }
}