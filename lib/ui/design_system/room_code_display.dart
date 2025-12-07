import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Room code display with individual circles for each digit
/// Used in battle room creation/join screens
class RoomCodeDisplay extends StatelessWidget {
  final String roomCode;
  final String label;

  const RoomCodeDisplay({
    required this.roomCode,
    this.label = 'ROOM PIN CODE',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Split room code into individual digits
    final digits = roomCode.split('');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Share this Room Code to Friends and Ask them to join !',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: Colors.grey[500],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: digits.map((digit) => _buildDigitCircle(digit)).toList(),
        ),
      ],
    );
  }

  Widget _buildDigitCircle(String digit) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          digit,
          style: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: klPrimaryTextColor,
          ),
        ),
      ),
    );
  }
}

/// PIN input field with individual circles
class PinInputDisplay extends StatelessWidget {
  final int length;
  final String currentValue;
  final TextEditingController? controller;

  const PinInputDisplay({
    this.length = 6,
    this.currentValue = '',
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _buildPinCircle(
            index < currentValue.length ? currentValue[index] : '',
          ),
        ),
      ),
    );
  }

  Widget _buildPinCircle(String value) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: value.isEmpty ? Colors.grey[300]! : klPrimaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: value.isNotEmpty
            ? Text(
                value,
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: klPrimaryTextColor,
                ),
              )
            : null,
      ),
    );
  }
}
