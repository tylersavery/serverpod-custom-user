/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'example.dart' as _i2;
import 'user.dart' as _i3;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i4;
export 'example.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Example) {
      return _i2.Example.fromJson(data) as T;
    }
    if (t == _i3.User) {
      return _i3.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Example?>()) {
      return (data != null ? _i2.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.User?>()) {
      return (data != null ? _i3.User.fromJson(data) : null) as T;
    }
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Example) {
      return 'Example';
    }
    if (data is _i3.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i2.Example>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i3.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
