import 'package:flutter/material.dart';

class CircularIconBtn extends StatelessWidget {
  const CircularIconBtn({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          ClipOval(
            child: Material(
              color: Colors.blue, // button color
              child: InkWell(
                splashColor: Colors.white, // splash color
                onTap: onTap,
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: Icon(icon, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}