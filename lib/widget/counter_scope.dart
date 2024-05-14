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

/// Контроллер, который определяет операции над счетчиком.
abstract interface class CounterScopeController {
  /// Значение счетчика.
  int get counter;

  /// Метод увеличения значения счетчика на единицу.
  void incrementCounter();
}

/// Scope виджет ответственный за обработку действий связанных со счетчиком.
class CounterScope extends StatefulWidget {
  const CounterScope({
    super.key,
    required this.model,
    required this.child,
  });

  /// Дочерний виджет.
  final Widget child;

  /// Модель счетчика.
  final CounterModel model;

  /// Находим [CounterScopeController] в ближайшем [CounterScope].
  static CounterScopeController of(BuildContext context, {bool listen = true}) =>
      _InheritedCounterScope.of<_InheritedCounterScope>(context, listen: listen).controller;

  @override
  State<CounterScope> createState() => _CounterScopeState();
}

class _CounterScopeState extends State<CounterScope> implements CounterScopeController {
  @override
  int get counter => widget.model.counter;

  @override
  void incrementCounter() => widget.model.incrementCounter();

  @override
  Widget build(BuildContext context) {
    return _InheritedCounterScope(
      controller: this,
      model: widget.model,
      child: widget.child,
    );
  }
}

/// [_InheritedCounterScope] представляет собой класс-поставщик, который,
/// благодаря наследованию от InheritedWidget, позволяет внедрять зависимость
/// от модели [CounterModel] в Дерево Виджетов и через BuildContext обращаться
/// к данной модели используя методы [dependOnInheritedWidgetOfExactType] и
/// [getElementForInheritedWidgetOfExactType].
class _InheritedCounterScope extends InheritedNotifier {
  const _InheritedCounterScope({
    required this.controller,
    // Модель используется для слежения за обновлениями в блоке инициализации.
    required CounterModel model,
    required super.child,
  }) : super(notifier: model);

  /// Контроллер, который определяет операции над счетчиком.
  ///
  /// Доступен для вызова через BuildContext.
  final CounterScopeController controller;

  static _InheritedCounterScope? maybeOf<_InheritedCounterScope extends InheritedNotifier>(BuildContext context, {bool listen = true}) => listen
              ? context.dependOnInheritedWidgetOfExactType<_InheritedCounterScope>()
              : context.getInheritedWidgetOfExactType<_InheritedCounterScope>();

  static _InheritedCounterScope of<_InheritedCounterScope extends InheritedNotifier>(BuildContext context, {bool listen = true}) =>
          maybeOf<_InheritedCounterScope>(context, listen: listen) ??
          (throw ArgumentError(
            'Out of scope, not found inherited widget '
                'a $_InheritedCounterScope of the exact type',
            'out_of_scope',
          ));
}
