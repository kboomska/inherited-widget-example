import 'package:flutter/material.dart';
import 'package:inherited_widget_example/widget/inherited_widget.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// Значение счетчика (а также других полей и методов) доступно для чтения
    /// из модели через BuildContext.
    ///
    /// В данном случае, мы просто обращаемся к значению счетчика методом read,
    /// а не подписываемся на его изменения, т.к. при нажатии на кнопку увеличения
    /// значения счетчика в данном примере вызывается метод setState, который
    /// отвечает за вызов метода build и перерисовку возвращаемых виджетов.
    /// Таким образом, при каждом вызове метода build мы получаем текущее значение
    /// счетчика из модели.
    final counter = CounterModelProvider.read(context)?.model.counter;
    final incrementCounter =
        CounterModelProvider.read(context)?.model.incrementCounter;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
        onPressed: () {
          incrementCounter?.call();
          // Нам все еще требуется обновлять экран для отображения текущего значения
          // счетчика. На данном этапе продолжим использовать метод setState.
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
