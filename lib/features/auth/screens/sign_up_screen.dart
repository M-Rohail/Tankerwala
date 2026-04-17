import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tankerwala/core/constants/urdu_poetry.dart';
import 'package:tankerwala/core/theme/app_colors.dart';
import 'package:tankerwala/core/theme/app_text_styles.dart';
import 'package:tankerwala/core/widgets/tw_button.dart';
import 'package:tankerwala/core/widgets/tw_header.dart';
import 'package:tankerwala/core/widgets/tw_text_field.dart';
import 'package:tankerwala/features/auth/validators/auth_validators.dart';
import 'role_select_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  bool _agreedToTerms = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
        begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('شرائط سے اتفاق کریں — Please agree to the Terms'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    setState(() => _isLoading = true);

    // TODO: Firebase Auth createUserWithEmailAndPassword
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RoleSelectScreen(
            userName: _nameController.text.trim(),
            userPhone: _phoneController.text.trim(),
            userEmail: _emailController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          TwHeader(
            title: 'نیا اکاؤنٹ',
            titleUrdu: 'Create your account',
            poetryLine: UrduPoetry.signUpPoem[0],
            poetryTranslation: UrduPoetry.signUpPoem[1],
            height: 230,
            showBackButton: true,
          ),

          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress steps
                        _StepIndicator(current: 1, total: 3,
                            labels: const ['Account', 'Role', 'Profile']),

                        const SizedBox(height: 22),

                        TwTextField(
                          label: 'Full name',
                          urduLabel: 'پورا نام',
                          hint: 'Muhammad Ali',
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.badge_outlined,
                              color: AppColors.textSecondary, size: 20),
                          validator: AuthValidators.validateName,
                        ),

                        const SizedBox(height: 14),

                        TwTextField(
                          label: 'Phone number',
                          urduLabel: 'موبائل',
                          hint: '03XX-XXXXXXX',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[\d\-]')),
                            LengthLimitingTextInputFormatter(12),
                          ],
                          prefixIcon: const Icon(Icons.phone_outlined,
                              color: AppColors.textSecondary, size: 20),
                          validator: AuthValidators.validatePhone,
                        ),

                        const SizedBox(height: 14),

                        TwTextField(
                          label: 'Email address',
                          urduLabel: 'ای میل',
                          hint: 'you@example.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.email_outlined,
                              color: AppColors.textSecondary, size: 20),
                          validator: AuthValidators.validateEmail,
                        ),

                        const SizedBox(height: 14),

                        TwTextField(
                          label: 'Password',
                          urduLabel: 'پاس ورڈ',
                          hint: 'Min 8 chars + a number',
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.lock_outline_rounded,
                              color: AppColors.textSecondary, size: 20),
                          validator: AuthValidators.validatePassword,
                        ),

                        const SizedBox(height: 14),

                        TwTextField(
                          label: 'Confirm password',
                          urduLabel: 'تصدیق',
                          hint: 'Repeat your password',
                          controller: _confirmController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(Icons.lock_outline_rounded,
                              color: AppColors.textSecondary, size: 20),
                          validator: (v) =>
                              AuthValidators.validateConfirmPassword(
                                  v, _passwordController.text),
                          onFieldSubmitted: (_) => _signUp(),
                        ),

                        const SizedBox(height: 20),

                        // Terms checkbox
                        GestureDetector(
                          onTap: () => setState(
                                  () => _agreedToTerms = !_agreedToTerms),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _agreedToTerms
                                  ? AppColors.primary.withValues(alpha: 0.05)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _agreedToTerms
                                    ? AppColors.primary.withValues(alpha: 0.3)
                                    : AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: _agreedToTerms
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: _agreedToTerms
                                          ? AppColors.primary
                                          : AppColors.border,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: _agreedToTerms
                                      ? const Icon(Icons.check_rounded,
                                      color: Colors.white, size: 14)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: AppTextStyles.bodySmall,
                                      children: [
                                        const TextSpan(
                                            text:
                                            'میں شرائط سے متفق ہوں — I agree to the '),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: AppColors.primaryLight,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: AppColors.primaryLight,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        TwButton(
                          label: 'Create account — اگلا قدم',
                          onPressed: _signUp,
                          isLoading: _isLoading,
                          icon: Icons.arrow_forward_rounded,
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account? ',
                                  style: AppTextStyles.bodyMedium),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Sign in'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator(
      {required this.current, required this.total, required this.labels});
  final int current;
  final int total;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final done = i < current;
        final active = i == current - 1;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 4,
                      decoration: BoxDecoration(
                        color: done || active
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: active
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: active
                            ? AppColors.primary
                            : AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              if (i < total - 1) const SizedBox(width: 6),
            ],
          ),
        );
      }),
    );
  }
}