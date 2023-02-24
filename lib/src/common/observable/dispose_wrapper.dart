import 'package:dart_shifter_core/src/common/observable/observable.dart';

class DisposeWrapper {
  final Set<Disposer> _disposers = {};

  void addDisposer(Disposer disposer) {
    _disposers.add(disposer);
  }

  void addAll(Iterable<Disposer> disposers) => _disposers.addAll(disposers);

  void dispose() {
    for (var dispose in _disposers) {
      dispose();
    }
    _disposers.clear();
  }
}