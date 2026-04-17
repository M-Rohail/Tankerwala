import 'package:flutter/material.dart';
import 'package:tankerwala/core/constants/urdu_poetry.dart';
import 'package:tankerwala/core/theme/app_colors.dart';
import 'package:tankerwala/core/theme/app_text_styles.dart';
import 'package:tankerwala/core/widgets/tw_button.dart';
import 'package:tankerwala/core/widgets/tw_header.dart';
import 'package:tankerwala/core/widgets/tw_text_field.dart';
import 'package:tankerwala/features/auth/validators/auth_validators.dart';
import 'package:tankerwala/features/auth/screens/role_select_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
        begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // TODO: Replace with Firebase Auth
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RoleSelectScreen(
            userName: _emailController.text.split('@').first,
            userPhone: '',
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
            title: 'خوش آمدید',
            titleUrdu: 'Welcome back',
            poetryLine: UrduPoetry.signInPoem[0],
            poetryTranslation: UrduPoetry.signInPoem[1],
          ),

          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section label
                        _SectionLabel(
                            icon: Icons.login_rounded,
                            text: 'Sign in to your account'),

                        const SizedBox(height: 20),

                        TwTextField(
                          label: 'Email address',
                          urduLabel: 'ای میل',
                          hint: 'you@example.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: AppColors.textSecondary,
                              size: 20),
                          validator: AuthValidators.validateEmail,
                        ),

                        const SizedBox(height: 16),

                        TwTextField(
                          label: 'Password',
                          urduLabel: 'پاس ورڈ',
                          hint: 'Enter your password',
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.textSecondary,
                              size: 20),
                          validator: AuthValidators.validatePassword,
                          onFieldSubmitted: (_) => _signIn(),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(10, 36)),
                            child: const Text('Forgot password?'),
                          ),
                        ),

                        const SizedBox(height: 4),

                        TwButton(
                          label: 'Sign in — داخل ہوں',
                          onPressed: _signIn,
                          isLoading: _isLoading,
                          icon: Icons.arrow_forward_rounded,
                        ),

                        const SizedBox(height: 20),

                        _OrDivider(),

                        const SizedBox(height: 20),

                        TwButton(
                          label: 'Continue with Google',
                          onPressed: () {},
                          outlined: true,
                          icon: Icons.g_mobiledata_rounded,
                          color: AppColors.primary,
                        ),

                        const SizedBox(height: 28),

                        _UrduTaglineCard(),

                        const SizedBox(height: 20),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: AppTextStyles.bodyMedium),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignUpScreen()),
                                ),
                                child: const Text('Sign up'),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryLight),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
              letterSpacing: 0.3,
            )),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider(color: AppColors.border)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text('یا / or',
            style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textHint, fontWeight: FontWeight.w500)),
      ),
      const Expanded(child: Divider(color: AppColors.border)),
    ]);
  }
}

class _UrduTaglineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.10), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded,
              color: AppColors.accent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(UrduPoetry.taglines[2],
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    )),
                const SizedBox(height: 2),
                const Text('Water to your doorstep',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}