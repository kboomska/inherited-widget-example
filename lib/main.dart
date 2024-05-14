import 'package:flutter/material.dart';
import 'package:inherited_widget_example/widget/inherited_notifier.dart';

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
      home: CounterModelProvider(
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
    /// Значение счетчика (а также других полей и методов) доступно для чтения
    /// из модели через BuildContext.
    ///
    /// В данном случае, нам понадобится метод watch для отслеживания за изменениями
    /// модели. При этом мы корректно обновляем только те виджеты, которые зависят
    /// от модели CounterModel, даже если это StatelessWidget.
    final counter = CounterModelProvider.watch(context)?.counter;
    final incrementCounter =
        CounterModelProvider.read(context)?.incrementCounter;

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
