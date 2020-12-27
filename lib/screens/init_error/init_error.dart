import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InitErrorScreen extends StatelessWidget {
  final String errorMessage;

  InitErrorScreen({@required this.errorMessage});

  static final String url = 'mailto:coorangar.sup@gmail.com'
      '?subject=App issue';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headline5,
            ),
          ),
          GestureDetector(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Get in touch',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            onTap: () async {
              if (await canLaunch(url)) await launch(url);
            },
          ),
        ],
      ),
    );
  }
}
