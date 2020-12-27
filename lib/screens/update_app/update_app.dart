import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:soccer/global/values.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'You need to update your app to the latest version in order to access the game.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              final String url = io.Platform.isAndroid
                  ? StoreURL.android.label
                  : StoreURL.ios.label;

              if (await canLaunch(url))
                await launch(url);
              else
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      'Could not open app store',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
            },
            child: Text('UPDATE'),
          ),
        ],
      ),
    );
  }
}
