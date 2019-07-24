import 'dart:async';
class NumberCreater {
  var _count = 1;

  void setCount(int count){
    this._count = count;
    _controller.sink.add(count);
  }

  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;
}
