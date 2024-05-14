import 'package:flutter/material.dart';
import 'package:inherited_widget_example/widget/counter_scope.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// Экземпляр модели счетчика.
  final _model = CounterModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      // Внедряем в Дерево зависимость от модели CounterModel.
      home: CounterScope(
        model: _model,
        child: const MyHomePage(title: 'Inherited Widget Example'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения счетчика.
    final counter = CounterScope.of(context).counter;

    // Однократно читаем значения счетчика при вызове build метода.
    // final counter = CounterScope.of(context, listen: false).counter;

    final incrementCounter = CounterScope.of(context, listen: false).incrementCounter;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
