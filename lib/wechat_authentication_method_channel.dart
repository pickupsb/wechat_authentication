import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wechat_authentication_platform_interface.dart';

/// An implementation of [WechatAuthenticationPlatform] that uses method channels.
class MethodChannelWechatAuthentication extends WechatAuthenticationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wechat_authentication');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<void> init(String appid) async {
    await methodChannel.invokeMethod<void>('init',{"appid":appid});
  }

  Future<String?> authenticate(String token) async {
    String? result = await methodChannel.invokeMethod<String>('authenticate',{"token":token});
    return result;
  }

}
