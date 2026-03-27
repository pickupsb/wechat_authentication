
import 'package:wechat_authentication/wechat_authentication_method_channel.dart';

import 'wechat_authentication_platform_interface.dart';

class WechatAuthentication {
  // Future<String?> getPlatformVersion() {
  //   return WechatAuthenticationPlatform.instance.getPlatformVersion();
  // }
  Future<void> init(String appid) {
    return WechatAuthenticationPlatform.instance.init(appid);
  }
  Future<String?> authenticate(String token) {
    return WechatAuthenticationPlatform.instance.authenticate(token);
  }
}
