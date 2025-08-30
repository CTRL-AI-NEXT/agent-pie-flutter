import 'dart:ui';

import 'package:agent_pie/core/utils/logger_util.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import '../environment_setup/environment.dart';
import '../storage/preference_storage.dart';
import '../utils/app_utils.dart';

class SocketService {
  static socket_io.Socket? socket;

  static bool get isConnected => socket != null && socket!.connected;

  static Future<void> connectSocket({VoidCallback? onConnect}) async {
    if (isConnected == false) {
      await AppUtils.validateAuthTokenExpiry();

      // Socket Options
      Map<String, dynamic> option = {
        // Required Headers for Backend
        "extraHeaders": {
          // 'App-Environment': Environment.config.environment,
          // 'deviceid': AppUtils.deviceID.toString(),
          'Authorization': PreferenceStorage.getAuthAccessToken(),
        },
        'transports': ['websocket'],
        'forceNew': true
      };

      socket = socket_io.io(Environment.config.socketURL, option);

      socket?.connect();

      socket?.onConnect((_) {
        logger.w('==> Socket Connected <==');
        onConnect?.call();
      });
      socket?.onDisconnect((_) => logger.w('==> Socket Disconnected <=='));
      socket?.onConnectError((err) => logger.w("==> onConnectError <==\n$err"));
      socket?.onError((err) => logger.w("==> onError <==\n$err"));
    }
  }

  static void disconnectSocket() => socket?.dispose();

  static void off(String event) {
    if (isListening(event)) {
      socket!.off(event);
    }
  }

  static void offAll(List<String> eventsToDetach) {
    for (var event in eventsToDetach) {
      socket!.off(event);
    }
  }

  static bool isListening(String eventName) =>
      isConnected && socket!.hasListeners(eventName);
}


/// [Socket] Event
class SocketEvent {
  // static const initiateChat = "initiateChat";
  // static const roomCreated = "roomCreated";
  //
  // static const getUserProfile = "getUserProfile";
  // static const receivedUserProfile = "receivedUserProfile";
  // static const updateUserOnlineStatus = "updateUserOnlineStatus";
  //
  // static const updateAllMessageAsSeen = "updateAllMessageAsSeen";
  //
  // static const receivedSendMessageResponse = "receivedSendMessageResponse";
  // static const getContactsList = "getContactsList";
  // static const receiveContactsList = "receiveContactsList";
  // static const contactListUpdate = "contactListUpdate";
  //
  // static const getRoomMessages = "getRoomMessages";
  // static const receivedRoomMessges = "receivedRoomMessages";
  //
  // static const receivedImage = "receivedImage";
  // static const receivedMessage = "receivedMessage";
  // static const lastMessageUpdateOnList = "lastMessageUpdateOnList";
  //
  // static const readMessageResponse = "readMessageResponse";
  // static const receivedImageResponse = "receivedImageResponse";
  //
  // static const clearChat = "clearChat";
  // static const clearChatSuccess = "clearChatSuccess";
  //
  // static const readMessage = "readMessage";
  // static const sendImage = "sendImage";
  // static const sendMessage = "sendMessage";
  //
  // static const blockUser = "blockUser";
  // static const unblockUser = "unblockUser";
  // static const blockedUserSuccess = "blockedUserSuccess";
  // static const unblockedUserSuccess = "unblockedUserSuccess";
  // static const unblockedError = "unblockedError";
  //
  // static const updateAllSeenMessage = "updateAllSeenMessage";
  // static const updateAllMessageAsReceived = "updateAllMessageAsReceived";
}
