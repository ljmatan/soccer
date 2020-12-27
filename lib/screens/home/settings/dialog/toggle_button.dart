import 'package:flutter/material.dart';
import 'package:soccer/logic/cache/prefs.dart';

class ToggleButton extends StatefulWidget {
  final String label, value;
  final Function(bool) onTap;

  ToggleButton({
    @required this.label,
    @required this.onTap,
    @required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _ToggleButtonState();
  }
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _active;

  @override
  void initState() {
    super.initState();
    _active = Prefs.instance.getBool(widget.value) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              widget.label,
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
                  child: Text(
                    _active ? 'on' : 'off',
                    style:
                        TextStyle(color: _active ? Colors.blue : Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
        widget.onTap(_active);
        setState(() => _active = !_active);
        await Prefs.instance.setBool(widget.value, _active);
      },
    );
  }
}
