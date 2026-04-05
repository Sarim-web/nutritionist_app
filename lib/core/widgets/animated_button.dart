import 'package:flutter/material.dart';

/// A wrapper for FilledButton that adds scale and opacity animation feedback
class AnimatedFilledButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget? icon;
  final Widget label;
  final Size? minimumSize;
  final BorderRadius borderRadius;
  final bool enabled;

  const AnimatedFilledButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.minimumSize,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.enabled = true,
  });

  @override
  State<AnimatedFilledButton> createState() => _AnimatedFilledButtonState();
}

class _AnimatedFilledButtonState extends State<AnimatedFilledButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    if (widget.enabled) {
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: FilledButton.icon(
          onPressed: widget.enabled ? _handlePressed : null,
          icon: widget.icon ?? const SizedBox.shrink(),
          label: widget.label,
          style: FilledButton.styleFrom(
            minimumSize: widget.minimumSize,
            shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

/// A wrapper for ElevatedButton that adds scale and opacity animation feedback
class AnimatedElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Size? minimumSize;
  final BorderRadius borderRadius;
  final bool enabled;

  const AnimatedElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.minimumSize,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.enabled = true,
  });

  @override
  State<AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    if (widget.enabled) {
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ElevatedButton(
          onPressed: widget.enabled ? _handlePressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: widget.minimumSize,
            shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// A wrapper for IconButton that adds scale animation feedback
class AnimatedIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String? tooltip;
  final bool enabled;

  const AnimatedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.enabled = true,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    if (widget.enabled) {
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        onPressed: widget.enabled ? _handlePressed : null,
        icon: widget.icon,
        tooltip: widget.tooltip,
      ),
    );
  }
}
