import 'dart:async';
import 'package:polybot/helper/database_helper.dart';

class SyncService {
  final DatabaseHelper _db = DatabaseHelper();
  Timer? _syncTimer;

  void startSync({Duration interval = const Duration(minutes: 5)}) {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(interval, (timer) => _syncData());
  }

  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  Future<void> _syncData() async {
    try {
      final pendingMessages = await _db.getPendingSync();
      
      for (var message in pendingMessages) {
        // Here you would implement the actual sync to your central database
        // For now, we'll just mark it as synced
        await _db.markAsSynced(message['id']);
      }
    } catch (e) {
      print('Sync failed: $e');
    }
  }
}