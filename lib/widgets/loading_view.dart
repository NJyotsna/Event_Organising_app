import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LoadingView extends StatelessWidget {
  final String message;
  const LoadingView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: AppColors.maroon,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
