import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:soccer/logic/admob/admob.dart';

class PenaltyScreen extends StatefulWidget {
  final int scene;

  PenaltyScreen({@required this.scene});

  @override
  State<StatefulWidget> createState() {
    return _PenaltyScreenState();
  }
}

class _PenaltyScreenState extends State<PenaltyScreen> {
  UnityWidgetController _unityWidgetController;

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) => this._unityWidgetController = controller;

  void _callUnityFunction(String gameObject, String function,
          [String parameter = '']) =>
      _unityWidgetController.postMessage(gameObject, function, parameter);

  Map _score = {
    'hits': 0,
    'misses': 0,
  };

  final StreamController _scoreController = StreamController.broadcast();

  // Communication from Unity to Flutter
  void _onUnityMessage(msg) {
    final message = msg.toString();

    if (message.contains('loaded'))
      _callUnityFunction(
        'MainCamera',
        'SetMode',
        widget.scene.toString(),
      );

    if (message.contains('hit')) {
      _score['hits'] = _score['hits'] + 1;
      _scoreController.add(_score);
    }

    if (message.contains('miss')) {
      _score['misses'] = _score['misses'] + 1;
      _scoreController.add(_score);
    }
  }

  StreamSubscription _scoreSubscription;

  @override
  void initState() {
    super.initState();
    _scoreSubscription = _scoreController.stream.listen(
      (event) async {
        if ((_score['misses'] + _score['hits']) % 5 == 0)
          await AdMob.showVideo();
      },
    );
  }

  // Communication from Unity when new scene is loaded to Flutter
  void _onUnitySceneLoaded(SceneLoaded sceneInfo) {
    if (sceneInfo.buildIndex == 1 || sceneInfo.buildIndex == 2)
      _scoreController.add(_score);
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
            left: 16,
            right: 16,
            top: MediaQuery.of(context).padding.top + 16,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
              child: StreamBuilder(
                stream: _scoreController.stream,
                builder: (context, score) => score.hasData
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            score.data['hits'].toString(),
                            style: const TextStyle(color: Colors.green),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            score.data['misses'].toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Restart view
    _callUnityFunction('MainCamera', 'ResetGame');
    _unityWidgetController.dispose();
    _scoreSubscription.cancel();
    _scoreController.close();
    super.dispose();
  }
}
