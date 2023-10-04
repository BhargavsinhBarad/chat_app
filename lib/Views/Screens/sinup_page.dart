import 'package:flutter/material.dart';

class sinup_page extends StatefulWidget {
  const sinup_page({super.key});

  @override
  State<sinup_page> createState() => _sinup_pageState();
}

class _sinup_pageState extends State<sinup_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sinup Page"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
