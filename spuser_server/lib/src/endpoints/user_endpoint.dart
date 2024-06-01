import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:spuser_server/src/generated/user.dart';

class UserEndpoint extends Endpoint {
  Future<User?> me(Session session) async {
    return await _getAuthenticationUser(session);
  }

  Future<User?> updateBio(Session session, String bio) async {
    final user = await _getAuthenticationUser(session);

    if (user != null) {
      final u = user.copyWith(bio: bio);
      await User.db.updateRow(session, u);
      return u;
    }

    return null;
  }
}

Future<User?> _getAuthenticationUser(Session session) async {
  final authenticationInfo = await session.authenticated;

  if (authenticationInfo != null) {
    final user = await User.db.findFirstRow(
      session,
      where: (row) => row.userInfoId.equals(authenticationInfo.userId),
      include: User.include(
        userInfo: UserInfo.include(),
      ),
    );
    return user;
  }

  return null;
}
