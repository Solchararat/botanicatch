import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';

class BotanicatchLoading extends StatefulWidget {
  final VoidCallback? onComplete;
  final int? duration;
  final String initialMessage;

  const BotanicatchLoading({
    super.key,
    this.onComplete,
    this.duration,
    this.initialMessage = "Identifying plant species...",
  });

  @override
  State<BotanicatchLoading> createState() => _BotanicatchLoadingState();
}

class _BotanicatchLoadingState extends State<BotanicatchLoading>
    with TickerProviderStateMixin {
  late AnimationController _leafController;
  late AnimationController _searchController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  final List<String> _messages = [
    "Identifying plant species...",
    "Analyzing leaf patterns...",
    "Checking database...",
    "Almost there...",
  ];

  late String _currentMessage;
  final ValueNotifier<double> _progress = ValueNotifier<double>(0);
  Timer? _messageTimer;
  Timer? _progressTimer;
  Timer? _completionTimer;

  @override
  void initState() {
    super.initState();
    _currentMessage = widget.initialMessage;

    _leafController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _progressAnimation =
        Tween<double>(begin: 0, end: 1).animate(_progressController);
    _progressController.forward();

    if (widget.duration != null) {
      _setupProgressTimer();
      _setupMessageTimer();
      _setupCompletionTimer();
    } else {
      _setupOnlyMessageTimer();
    }
  }

  void _setupProgressTimer() {
    final duration = widget.duration!;
    _progressTimer = Timer.periodic(
      Duration(milliseconds: duration ~/ 100),
      (timer) {
        final newProgress = _progress.value + 0.01;
        _progress.value = newProgress <= 1.0 ? newProgress : 1.0;
      },
    );
  }

  void _setupMessageTimer() {
    final duration = widget.duration!;
    _messageTimer = Timer.periodic(
      Duration(milliseconds: duration ~/ 4),
      (timer) {
        _updateRandomMessage();
      },
    );
  }

  void _setupOnlyMessageTimer() {
    _messageTimer = Timer.periodic(
      const Duration(milliseconds: 2500),
      (timer) {
        _updateRandomMessage();
      },
    );
  }

  void _updateRandomMessage() {
    if (mounted) {
      setState(() {
        if (widget.initialMessage != _currentMessage &&
            !_messages.contains(widget.initialMessage)) {
          _currentMessage = widget.initialMessage;
        } else {
          final randomIndex = Random().nextInt(_messages.length);
          _currentMessage = _messages[randomIndex];
        }
      });
    }
  }

  void _setupCompletionTimer() {
    _completionTimer = Timer(
      Duration(milliseconds: widget.duration!),
      () {
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      },
    );
  }

  @override
  void didUpdateWidget(BotanicatchLoading oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialMessage != oldWidget.initialMessage) {
      setState(() {
        _currentMessage = widget.initialMessage;
      });
    }
  }

  @override
  void dispose() {
    _leafController.dispose();
    _searchController.dispose();
    _progressController.dispose();
    _progress.dispose();
    _messageTimer?.cancel();
    _progressTimer?.cancel();
    _completionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade900.withValues(alpha: 0.9),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotationTransition(
                      turns: _leafController,
                      child: const Icon(
                        Icons.eco,
                        size: 48,
                        color: kGreenColor300,
                      ),
                    ),
                    RotationTransition(
                      turns: Tween<double>(begin: 0, end: -1)
                          .animate(_searchController),
                      child: const Icon(
                        Icons.search,
                        size: 48,
                        color: kGreenColor100,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "BOTANICATCH",
                style: kSmallTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ValueListenableBuilder<double>(
                  valueListenable: _progress,
                  builder: (context, progress, _) {
                    return widget.duration == null
                        ? const LinearProgressIndicator(
                            backgroundColor: Colors.green,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kGreenColor300),
                            minHeight: 8,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.green.shade900,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  kGreenColor300),
                              minHeight: 8,
                            ),
                          );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _currentMessage,
                  key: ValueKey<String>(_currentMessage),
                  style: TextStyle(
                    color: Colors.green.shade100,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => _AnimatedDot(
                    delay: index * 0.1,
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

class _AnimatedDot extends StatefulWidget {
  final double delay;

  const _AnimatedDot({
    required this.delay,
  });

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(_controller);

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) {
        _controller.repeat(period: const Duration(milliseconds: 2500));
      }
    });
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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          height: 6 * _animation.value,
          width: 6 * _animation.value,
          decoration: const BoxDecoration(
            color: kGreenColor300,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
