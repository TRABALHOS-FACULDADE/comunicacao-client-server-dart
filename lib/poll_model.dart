import 'session.dart';

class Poll {
  final List<Session> sessions;

  Poll({required this.sessions});

  Session? getSessionByRoomName(String roomName) {
    try {
      return sessions.firstWhere(
        (session) => session.name.toLowerCase() == roomName.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
