import 'package:flutter/material.dart';
import 'package:flutter_terminchi/models/data_model.dart';

class TerminSubScreen extends StatelessWidget {
  final DataModel data;
  const TerminSubScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, backgroundColor: Colors.yellow),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(data.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
