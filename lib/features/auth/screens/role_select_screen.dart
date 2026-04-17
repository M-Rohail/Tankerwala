import 'package:flutter/material.dart';
import 'package:tankerwala/core/constants/urdu_poetry.dart';
import 'package:tankerwala/core/theme/app_colors.dart';
import 'package:tankerwala/core/theme/app_text_styles.dart';
import 'package:tankerwala/core/widgets/tw_button.dart';
import 'package:tankerwala/features/auth/models/user_model.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
  });

  final String userName;
  final String userPhone;
  final String userEmail;

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen>
    with SingleTickerProviderStateMixin {
  UserRole? _selectedRole;
  bool _isLoading = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_selectedRole == null) return;
    setState(() => _isLoading = true);

    // TODO: Save user + role to Firestore
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _selectedRole == UserRole.tanker
                ? '🚛 Welcome TankerWala! Registration coming next.'
                : '💧 Welcome! Finding water near you.',
          ),
          backgroundColor: _selectedRole == UserRole.tanker
              ? AppColors.tankerBlue
              : AppColors.customerTeal,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstName = widget.userName.isEmpty
        ? 'دوست'
        : widget.userName.split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SafeArea(
          child: Column(
            children: [
              // Top greeting area
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Decorative top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.water_drop_rounded,
                                  color: AppColors.accentLight, size: 14),
                              const SizedBox(width: 5),
                              Text('TankerWala',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                        Text('مرحلہ ۲/۳',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                            )),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Text(
                      'السلام علیکم،',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.accentLight.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      firstName,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.8,
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    const SizedBox(height: 14),

                    // Urdu poetry
                    Text(
                      UrduPoetry.rolePoem[0],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                    ),
                    Text(
                      UrduPoetry.rolePoem[1],
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.accentLight.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'آپ کا کردار منتخب کریں',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Choose how you want to use TankerWala',
                        style: AppTextStyles.heading2,
                      ),

                      const SizedBox(height: 24),

                      // Customer card
                      _RoleCard(
                        title: 'I need water',
                        titleUrdu: 'مجھے پانی چاہیے',
                        description:
                        'Book a tanker to your home, office or building — anytime.',
                        descUrdu: 'گھر یا دفتر کے لیے پانی بک کریں',
                        icon: Icons.home_rounded,
                        color: AppColors.customerTeal,
                        poetryLine: UrduPoetry.taglines[0],
                        isSelected: _selectedRole == UserRole.customer,
                        onTap: () => setState(
                                () => _selectedRole = UserRole.customer),
                      ),

                      const SizedBox(height: 14),

                      // Tanker card
                      _RoleCard(
                        title: 'I have a tanker',
                        titleUrdu: 'میرے پاس ٹینکر ہے',
                        description:
                        'Register your tanker, set your areas and start earning.',
                        descUrdu: 'ٹینکر رجسٹر کریں اور کمائی شروع کریں',
                        icon: Icons.local_shipping_rounded,
                        color: AppColors.tankerBlue,
                        poetryLine: UrduPoetry.tankerPoem[0],
                        isSelected: _selectedRole == UserRole.tanker,
                        onTap: () =>
                            setState(() => _selectedRole = UserRole.tanker),
                        badge: 'کمائیں',
                      ),

                      const Spacer(),

                      AnimatedOpacity(
                        opacity: _selectedRole != null ? 1.0 : 0.35,
                        duration: const Duration(milliseconds: 250),
                        child: TwButton(
                          label: _selectedRole == UserRole.tanker
                              ? 'Register my tanker — آگے بڑھیں'
                              : _selectedRole == UserRole.customer
                              ? 'Find water near me — آگے بڑھیں'
                              : 'Select a role to continue',
                          onPressed: _selectedRole != null ? _confirm : null,
                          isLoading: _isLoading,
                          color: _selectedRole == UserRole.tanker
                              ? AppColors.tankerBlue
                              : AppColors.customerTeal,
                          icon: Icons.arrow_forward_rounded,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Center(
                        child: Text(
                          'بعد میں سیٹنگز سے تبدیل کیا جا سکتا ہے',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textHint),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.titleUrdu,
    required this.description,
    required this.descUrdu,
    required this.icon,
    required this.color,
    required this.poetryLine,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String titleUrdu;
  final String description;
  final String descUrdu;
  final IconData icon;
  final Color color;
  final String poetryLine;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? color
                : AppColors.border,
            width: isSelected ? 0 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ]
              : [
            BoxShadow(
              color: AppColors.cardShadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon,
                  color: isSelected ? Colors.white : color, size: 30),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.25)
                                : AppColors.success.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            badge!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    titleUrdu,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.75)
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isSelected ? poetryLine : description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.85)
                          : AppColors.textSecondary,
                      fontStyle: isSelected
                          ? FontStyle.italic
                          : FontStyle.normal,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Radio dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.white
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded, color: color, size: 14)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}