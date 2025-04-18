import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(this.text, [this.isHuman = true]);

  final text;
  final isHuman;

  @override
  Widget build(BuildContext context) {
    return Align(
            alignment: isHuman ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: isHuman ? Colors.lightBlue : Colors.lightGreen,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            )
          );
  }
}