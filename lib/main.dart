import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

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

const _url =
    'https://www.timeoutdubai.com/cloud/timeoutdubai/2022/02/04/Museum-of-the-Future.jpg';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => (NetworkAssetBundle(Uri.parse(_url))
        .load(_url)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data))));

    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Column(
        children: [snapshot.data].compactMap().toList(),
      ),
    );
  }
}
