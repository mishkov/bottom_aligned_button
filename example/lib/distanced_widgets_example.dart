import 'package:bottom_aligned_button/bottom_aligned_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bottom Aligned Button',
      home: MyHomePage(title: 'Bottom Aligned Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> inputs = [];
  final input = const TextField(
    decoration: InputDecoration(
      label: Text('Name / email / phone / password'),
    ),
  );

  @override
  void initState() {
    super.initState();

    inputs.addAll([input, input, input]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 70,
        ),
        child: DistancedWidgets(
          top: ListView.builder(
            shrinkWrap: true,
            itemCount: inputs.length,
            itemBuilder: (context, index) {
              return inputs[index];
            },
          ),
          bottom: ElevatedButton(
            onPressed: () {
              final messenger = ScaffoldMessenger.of(context);

              const message = SnackBar(
                content: Text('You are signed in!!!'),
              );
              messenger.removeCurrentSnackBar();
              messenger.showSnackBar(message);
            },
            child: const Text('Sign In'),
          ),
          onBottomHide: () {},
          onBottomShow: () {},
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                inputs.removeAt(inputs.length - 1);
              });
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                inputs.add(input);
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
