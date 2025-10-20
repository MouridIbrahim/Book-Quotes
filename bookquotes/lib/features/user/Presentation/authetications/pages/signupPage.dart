import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> with TickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.65, curve: Curves.easeInOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate responsive dimensions
    final double widgetWidth = min(
      400,
      screenWidth * 0.85,
    );
    
    // Responsive font sizes
    final double titleFontSize = screenWidth < 400 ? 40 : 
                                screenWidth < 600 ? 50 : 60;
    final double subtitleFontSize = screenWidth < 400 ? 16 : 
                                   screenWidth < 600 ? 18 : 20;
    
    // Responsive spacing
    final double verticalSpacing = screenHeight * 0.02;
    final double largeVerticalSpacing = screenHeight * 0.04;
    final double extraLargeVerticalSpacing = screenHeight * 0.06;
    
    // Responsive padding
    final EdgeInsets screenPadding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.05,
      vertical: screenHeight * 0.05,
    );

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF5F5DC), // Light beige color matching the reference
              const Color(0xFFE8E0D5), // Slightly darker beige
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: screenPadding,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight - screenPadding.top - screenPadding.bottom,
                ),
                child: Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo and title section
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.format_quote,
                              size: titleFontSize * 0.8,
                              color: const Color(0xFFD4AF37), // Gold color
                            ),
                          ),
                          SizedBox(height: largeVerticalSpacing),
                          
                          // App title
                          Text(
                            'Register Page',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: verticalSpacing),
                          
                          // Subtitle
                          Text(
                            'Join our community of quote lovers',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF666666),
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: extraLargeVerticalSpacing * 1.5),
                          
                          // Username field
                          _buildModernTextField(
                            controller: usernameController,
                            hintText: 'Username',
                            icon: Icons.person_outline,
                            width: widgetWidth,
                          ),
                          SizedBox(height: verticalSpacing),
                          
                          // Email field
                          _buildModernTextField(
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icons.email_outlined,
                            width: widgetWidth,
                          ),
                          SizedBox(height: verticalSpacing),
                          
                          // Password field
                          _buildModernTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock_outline,
                            isPassword: true,
                            width: widgetWidth,
                          ),
                          SizedBox(height: verticalSpacing),
                          
                          // Terms and conditions
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: (screenWidth - widgetWidth) / 2),
                            child: Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: const Color(0xFFAAAAAA),
                                  ),
                                  child: Checkbox(
                                    value: true,
                                    onChanged: (value) {},
                                    activeColor: const Color(0xFFD4AF37),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'I agree to the Terms of Service and Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: largeVerticalSpacing),
                          
                          // Sign up button
                          _buildModernButton(
                            onPressed: () {},
                            text: 'Sign Up',
                            width: widgetWidth,
                            isPrimary: true,
                          ),
                          SizedBox(height: verticalSpacing),
                          
                          // Log in button
                          _buildModernButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Log In',
                            width: widgetWidth,
                            isPrimary: false,
                          ),
                          SizedBox(height: largeVerticalSpacing),
                          
                          // Social login options
                          Column(
                            children: [
                              Text(
                                'Or sign up with',
                                style: TextStyle(
                                  color: const Color(0xFF666666),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: verticalSpacing),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialButton(
                                    icon: Icons.g_mobiledata,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: verticalSpacing),
                                  _buildSocialButton(
                                    icon: Icons.facebook,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: verticalSpacing),
                                  _buildSocialButton(
                                    icon: Icons.apple,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    required double width,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !isPasswordVisible : false,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFAAAAAA),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color(0xFFAAAAAA),
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildModernButton({
    required VoidCallback onPressed,
    required String text,
    required double width,
    required bool isPrimary,
  }) {
    return Container(
      width: width,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: isPrimary 
                ? const Color(0xFFD4AF37).withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary 
              ? const Color(0xFFD4AF37) // Gold color
              : Colors.white,
          foregroundColor: isPrimary 
              ? Colors.white
              : const Color(0xFF333333),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: const Color(0xFF666666),
          size: 28,
        ),
      ),
    );
  }
}