import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class URLButton extends StatelessWidget {
  final String label, url;

  URLButton({@required this.label, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
      onTap: () async {
        if (await canLaunch(url))
          await launch(url);
        else
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error')),
          );
      },
    );
  }
}
