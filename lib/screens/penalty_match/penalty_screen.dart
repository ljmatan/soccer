import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class PenaltyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PenaltyScreenState();
  }
}

class _PenaltyScreenState extends State<PenaltyScreen> {
  UnityWidgetController _unityWidgetController;

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) => this._unityWidgetController = controller;

  // Communication from Unity to Flutter
  void _onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Communication from Unity when new scene is loaded to Flutter
  void _onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UnityWidget(
            onUnityCreated: _onUnityCreated,
            onUnityMessage: _onUnityMessage,
            onUnitySceneLoaded: _onUnitySceneLoaded,
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).padding.top,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
