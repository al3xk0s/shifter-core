typedef Disposer = void Function();
typedef Handler<T> = void Function(T value);

abstract class IObservable<T> {
  Disposer addHandler(Handler<T> handler);
  void notify(T value);
  void dispose();
}

class Observable<T> implements IObservable<T> {
  final List<Handler<T>> _handlers = [];

  @override
  Disposer addHandler(Handler<T> handler) {
    _handlers.add(handler);
    return () => _handlers.remove(handler);
  }

  @override
  void dispose() {
    _handlers.clear();
  }

  @override
  void notify(T value) {
    for (var handler in _handlers) {
      handler(value);
    }
  }
}