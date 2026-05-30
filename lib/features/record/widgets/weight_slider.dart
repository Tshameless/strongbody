import 'package:flutter/material.dart';
import 'package:slimup/core/theme/app_colors.dart';

class WeightSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const WeightSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.mintGreen,
            inactiveTrackColor: AppColors.mintGreen.withOpacity(0.15),
            thumbColor: AppColors.bgWhite,
            overlayColor: AppColors.mintGreen.withOpacity(0.12),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 14,
              elevation: 4,
            ),
            trackHeight: 6,
            tickMarkShape: const RoundSliderTickMarkShape(
              tickMarkRadius: 2,
            ),
            activeTickMarkColor: AppColors.mintGreen.withOpacity(0.5),
            inactiveTickMarkColor: AppColors.mintGreen.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: 30,
            max: 200,
            divisions: 1700,
            label: value.toStringAsFixed(1),
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '30 kg',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textDisabled,
                ),
              ),
              Text(
                '200 kg',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textDisabled,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
