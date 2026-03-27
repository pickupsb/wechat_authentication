import 'package:flutter_test/flutter_test.dart';
import 'package:wechat_authentication/wechat_authentication.dart';
import 'package:wechat_authentication/wechat_authentication_platform_interface.dart';
import 'package:wechat_authentication/wechat_authentication_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWechatAuthenticationPlatform
    with MockPlatformInterfaceMixin
    implements WechatAuthenticationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WechatAuthenticationPlatform initialPlatform = WechatAuthenticationPlatform.instance;

  test('$MethodChannelWechatAuthentication is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWechatAuthentication>());
  });

  test('getPlatformVersion', () async {
    WechatAuthentication wechatAuthenticationPlugin = WechatAuthentication();
    MockWechatAuthenticationPlatform fakePlatform = MockWechatAuthenticationPlatform();
    WechatAuthenticationPlatform.instance = fakePlatform;

    expect(await wechatAuthenticationPlugin.getPlatformVersion(), '42');
  });
}
