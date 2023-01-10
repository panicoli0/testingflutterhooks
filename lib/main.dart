import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

// Stream<String> getTime() => Stream.periodic(
//       const Duration(seconds: 1),
//       (_) => DateTime.now().toIso8601String(),
//     );

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    final text = useState('');
    useEffect(
      () {
        _controller.addListener(() {
          text.value = _controller.text;
        });
        return null;
      },
      [_controller],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          Text(
            'You typed: ${text.value}',
          ),
        ],
      ),
    );
  }
}
