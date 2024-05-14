import 'package:flutter/material.dart';

/// Модель для хранения значения счетчика и операций над ним.
class CounterModel extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    // Метод notifyListeners оповещает слушателей об изменениях в модели.
    notifyListeners();
  }
}

/// [CounterModelProvider] представляет собой класс-поставщик (модели), который,
/// благодаря наследованию от InheritedWidget, позволяет внедрять зависимость
/// от модели [CounterModel] в Дерево Виджетов и через BuildContext обращаться
/// к данной модели используя методы [dependOnInheritedWidgetOfExactType] и
/// [getElementForInheritedWidgetOfExactType].
class CounterModelProvider extends InheritedNotifier<CounterModel> {
  /// Модель счетчика.
  final CounterModel model;

  const CounterModelProvider({
    super.key,
    required this.model,
    // Дочерний виджет вокруг которого "оборачивается" CounterModelProvider.
    required super.child,
    // Для InheritedNotifier необходимо передать модель, за обновлениями которой
    // требуется следить.
  }) : super(notifier: model);

  /// Метод [watch] благодаря использованию [dependOnInheritedWidgetOfExactType]
  /// возвращает из контекста ближайший по дереву экземпляр [CounterModel].
  /// Помимо прочего, метод [dependOnInheritedWidgetOfExactType] позволяет следить за
  /// изменениями в отслеживаемом виджете.
  static CounterModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterModelProvider>()
        ?.model;
  }

  /// Метод [read] благодаря использованию [getElementForInheritedWidgetOfExactType]
  /// возвращает из контекста ближайший по дереву экземпляр [CounterModel].
  static CounterModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<CounterModelProvider>()
        ?.widget;
    return widget is CounterModelProvider ? widget.model : null;
  }
}
