package com.pickupsb.wechat_authentication;

import android.content.Context;

import androidx.annotation.NonNull;

import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** WechatAuthenticationPlugin */
public class WechatAuthenticationPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wechat_authentication");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("init")){
      String id = call.argument["appid"];
      WXAPIFactory.createWXAPI(context, id, true);
    } else if(call.method.equals("authenticate")){
      String token = call.argument["token"];
      startRealNameAuth(token,result);
    }else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
  private void startRealNameAuth(String token,Result result) {
    WXRealNameAuthManager manager = WXRealNameAuthManager.getInstance();
    manager.setDebugMode(true); // 测试环境开启
    WXRealNameAuthReq req = new WXRealNameAuthReq.Builder()
            .setScene(WXRealNameAuthReq.SCENE_FINANCE) // 金融场景
            .setBizToken(token) // 后端获取的令牌
            .build();
    manager.sendReq(req, new WXRealNameAuthCallback() {
      @Override
      public void onAuthSuccess(WXRealNameAuthResult result) {
        // 认证成功，result包含加密的实名信息
        String encryptedData = result.getEncryptedData();
        String iv = result.getIv();
        // 需传至后端解密
        result.success(iv);
      }
      @Override
      public void onAuthFail(int errorCode, String errorMsg) {
        // 错误处理：1001-参数错误，1002-用户取消，1003-网络错误
        result.success("");
      }
    });
  }
}
