import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wechat_authentication_method_channel.dart';

abstract class WechatAuthenticationPlatform extends PlatformInterface {
  /// Constructs a WechatAuthenticationPlatform.
  WechatAuthenticationPlatform() : super(token: _token);

  static final Object _token = Object();

  static WechatAuthenticationPlatform _instance = MethodChannelWechatAuthentication();

  /// The default instance of [WechatAuthenticationPlatform] to use.
  ///
  /// Defaults to [MethodChannelWechatAuthentication].
  static WechatAuthenticationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WechatAuthenticationPlatform] when
  /// they register themselves.
  static set instance(WechatAuthenticationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> init(String appid) async {
    await instance.init(appid);
  }

  Future<String?> authenticate(String token) async {
    String? result = await instance.authenticate(token);
    return result;
  }

}
