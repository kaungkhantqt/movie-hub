import 'package:flutter/material.dart';

class TitleSe extends StatelessWidget {
  TitleSe({super.key, required this.title, required this.width, required this.onPressed});
  final String title;
  final double width;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Color.fromARGB(226, 255, 255, 255),
                    fontSize: 20,
                    fontFamily: "Oswald",
                    letterSpacing: 1.10,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                height: 1,
                width: width,
                color: Colors.red,
              )
            ],
          ),
          TextButton(
              onPressed: onPressed,
              child: const Text(
                "See All..",
                style: TextStyle(color: Colors.grey),
              ))
        ],
      ),
    );
  }
}
