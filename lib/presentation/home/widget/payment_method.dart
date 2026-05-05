import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketing_app/core/core.dart';

class PaymentMethodButton extends StatelessWidget {
  // Tentuin ada apa aja di widget nya
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  const PaymentMethodButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Kalo gesture ngga ada efek yang muncul pas di tap
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: isActive
                  ? ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                  : null,
            ),
            SpaceHeight(10),
            Text(
              label,
              style: TextStyle( 
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
