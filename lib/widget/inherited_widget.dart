import 'package:flutter/material.dart';

/// Модель для хранения значения счетчика и операций над ним.
class CounterModel {
  int counter = 0;

  void incrementCounter() {
    counter++;
  }
}

/// [CounterModelProvider] представляет собой класс-поставщик (модели), который,
/// благодаря наследованию от InheritedWidget, позволяет внедрять зависимость
/// от модели [CounterModel] в Дерево Виджетов и через BuildContext обращаться
/// к данной модели используя методы [dependOnInheritedWidgetOfExactType] и
/// [getElementForInheritedWidgetOfExactType].
class CounterModelProvider extends InheritedWidget {
  /// Модель счетчика.
  final CounterModel model;

  const CounterModelProvider({
    super.key,
    required this.model,
    // Дочерний виджет вокруг которого "оборачивается" CounterModelProvider.
    required super.child,
  });

  /// Метод [watch] благодаря использованию [dependOnInheritedWidgetOfExactType]
  /// возвращает из контекста ближайший по дереву экземпляр класса-поставщика [CounterModelProvider].
  /// Помимо прочего, метод [dependOnInheritedWidgetOfExactType] позволяет следить за
  /// изменениями в отслеживаемом виджете.
  static CounterModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterModelProvider>();
  }

  /// Метод [read] благодаря использованию [getElementForInheritedWidgetOfExactType]
  /// возвращает из контекста ближайший по дереву экземпляр класса-поставщика [CounterModelProvider].
  static CounterModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<CounterModelProvider>()
        ?.widget;
    return widget is CounterModelProvider ? widget : null;
  }

  /// Метод [updateShouldNotify] определяет условия для оповещения зависимых от него виджетов
  /// об изменениях в отслеживаемом виджете.
  @override
  bool updateShouldNotify(CounterModelProvider oldWidget) {
    return oldWidget.model.counter != model.counter;
  }
}
