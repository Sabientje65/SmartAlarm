
import 'package:smart_alarm/core/notification_service.dart';
import 'package:workmanager/workmanager.dart';

// class BackgroundJob {
//
//   String name = '';
//   final Future<bool> Function() _predicate;
//
//   BackgroundJob(
//     this.name,
//     this._predicate
//   );
//
// }

/// Class used for scheduling background work, single purpose interface for creating anonymous/named tasks
class BackgroundWorker {
  BackgroundWorker._internal();
  static final BackgroundWorker _instance = BackgroundWorker._internal();
  factory BackgroundWorker() => _instance;

  // static final BackgroundWorker _instance = BackgroundWorker._interal();

  initialize() => Workmanager().initialize( _callbackDispatcher, isInDebugMode: true );

  displayTestNotification() {
    NotificationService().show("FromTask", "Displayed");
  }

  // runAnonymousTaskOnce() {
  //   Workmanager().registerOneOffTask(uniqueName, taskName)
  // }

  // final List<BackgroundHandler> _handlers = [];
  //
  // /// Register a handler for a named task
  // registerHandler(BackgroundHandler handler) => _handlers.add(handler);

}

@pragma("vm:entry-point") // used from native code, prevent compiler from optimizing etc
void _callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("Calling task (start): $taskName");

    try {

    } catch(e) {
      print("Failed (crash): $e");
    }

    print("Calling task (end): $taskName");

    return true;
  });
}