import 'package:flutter/material.dart';
import 'package:pjsk_sticker/pages/sticker.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});
  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StickerPage(),
    );
  }
}
