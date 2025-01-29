import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {

  TabNavigator(this._initPage){
    _navigationStack.add(_initPage);
  }

  late final TabItem _initPage;
  final List<TabItem> _navigationStack = [];

  TabItem get currentPage => _navigationStack.last;

  void push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }
  void pop() {
    if (_navigationStack.length > 1) {
      _navigationStack.removeLast();
      notifyListeners();
    }
  }

  void popToRoot() {
    _navigationStack..clear()..add(_initPage);
    notifyListeners();
  }

  void popTo(TabItem page) {
   _navigationStack.remove(page);
    notifyListeners();
  }

  void popUntil(TabItem? page){
    if(page == null){
      popToRoot();
    } else {
      while(_navigationStack.last != page){
        pop();
      }
    }
  }
  void pushAndRemoveUntil(TabItem page){
    popToRoot();
    push(page);
  }

}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {

  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }) : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
    ?.navigator;
  }

}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();
  final String id;
  final Widget child;

  @override
  List<Object> get props {
    return [id];
  }
}
