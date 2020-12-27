import 'package:flutter/material.dart';
import 'package:soccer/logic/i18n/locale_controller.dart';

class LanguageButton extends StatelessWidget {
  final Function onTap;

  LanguageButton({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'LANGUAGE',
              style: const TextStyle(fontSize: 10),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 40,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flag, size: 12),
                      Text(' ' + AppLocale.languageCode),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
