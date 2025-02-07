import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({super.key});

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool _isNow = true;

  void _toggle(bool state) {
    setState(() {
      _isNow = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LiteRollingSwitch(
      value: _isNow,
      textOn: " Ir Agora",
      textOff: " Ir Outro dia",
      colorOn: Colors.red[800]!,
      colorOff: Colors.red[800]!,
      iconOn: Icons.calendar_today,
      iconOff: Icons.flash_on,
      textSize: 20,
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (state) => _toggle(state),
      onTap: () => _toggle(true),
      onDoubleTap: () => _toggle(true),
      onSwipe: () => _toggle(true),
      width: 200,
      textOnColor: Colors.white,
      textOffColor: Colors.white,
    );
  }
}
