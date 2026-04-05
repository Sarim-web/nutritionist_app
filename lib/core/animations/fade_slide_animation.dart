import 'package:flutter/material.dart';

/// Animated card with fade-in and slide-up animation
class AnimatedFadeSlideCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int delayMultiplier;

  const AnimatedFadeSlideCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delayMultiplier = 0,
  });

  @override
  State<AnimatedFadeSlideCard> createState() => _AnimatedFadeSlideCardState();
}

class _AnimatedFadeSlideCardState extends State<AnimatedFadeSlideCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Delay before animation
    Future.delayed(
      Duration(milliseconds: widget.delayMultiplier * 100),
      () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Animated scale button with ripple effect
class AnimatedScaleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;

  const AnimatedScaleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onPressed() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _onPressed,
        child: widget.child,
      ),
    );
  }
}

/// Progress animation for calorie tracking
class AnimatedCalorieProgress extends StatefulWidget {
  final double value;
  final double maxValue;
  final Duration duration;
  final Color color;

  const AnimatedCalorieProgress({
    super.key,
    required this.value,
    required this.maxValue,
    this.duration = const Duration(milliseconds: 800),
    required this.color,
  });

  @override
  State<AnimatedCalorieProgress> createState() =>
      _AnimatedCalorieProgressState();
}

class _AnimatedCalorieProgressState extends State<AnimatedCalorieProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: (widget.value / widget.maxValue).clamp(0.0, 1.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCalorieProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: (widget.value / widget.maxValue).clamp(0.0, 1.0),
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LinearProgressIndicator(
          minHeight: 12,
          value: _animation.value,
          borderRadius: BorderRadius.circular(6),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(widget.color),
        );
      },
    );
  }
}
