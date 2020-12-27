import 'package:flutter/material.dart';
import 'package:soccer/screens/home/settings/dialog/settings_dialog.dart';

class SettingsButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsButtonState();
  }
}

class _SettingsButtonState extends State<SettingsButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(() => setState(() {}));
    _rotation = Tween<double>(begin: 0, end: 360).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(_rotation.value / 360),
      child: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () async {
          _animationController.forward();
          await showDialog(
            context: context,
            builder: (context) => SettingsDialog(),
          );
          _animationController.reverse();
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
