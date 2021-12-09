import 'dart:async';

class MessageManager {

  // 流控制器
  StreamController _streamController;
  StreamController get streamController => _streamController;

  MessageManager._({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);
  MessageManager._customController(StreamController controller)
      : _streamController = controller;

  static MessageManager? _instance;
  /// 单利初始化消息管理器
  /// @param controller 自定义控制器，设置之后sync便不再生效
  /// @param sync 是否同步，为true则为同步，为false则为异步
  static MessageManager getInstance({bool sync = false,StreamController? controller}){
    if(_instance != null){
      return _instance!!;
    }

    if(controller != null){
      _instance = MessageManager._customController(controller);
      return _instance!!;
    }

    _instance = MessageManager._(sync: sync);
    return _instance!!;
  }

  // 获取到流
  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  // 发送消息
  void sendMessage(event) {
    streamController.add(event);
  }

  // 销毁
  void destroy() {
    _streamController.close();
    _instance = null;
  }
}
