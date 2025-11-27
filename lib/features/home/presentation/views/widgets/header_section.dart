import 'package:find_job/features/profile/presentation/stores/profile_completion_calculator.dart';
import 'package:flutter/material.dart';
import 'greeting_card/animated_title.dart';
import 'greeting_card/profile_strength_card.dart';
import 'greeting_card/mini_stat.dart';

class HeaderSection extends StatelessWidget {
  final int profilePercentage;

  HeaderSection({super.key, required this.profilePercentage});

  @override
  Widget build(BuildContext context) {
    final primary = Colors.indigo.shade600;

    return Stack(
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade600, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),

        Positioned(top: -30, right: -40, child: _blurCircle(120, 0.1)),
        Positioned(bottom: -20, left: -30, child: _blurCircle(100, 0.07)),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello Vishal 👋",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const AnimatedTitle(),
              const SizedBox(height: 10),

              // FIXED
              _HeaderStatsRow(profilePercentage),
            ],
          ),
        ),
      ],
    );
  }

  Widget _blurCircle(double s, double opacity) {
    return Container(
      height: s,
      width: s,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _HeaderStatsRow extends StatelessWidget {
  final int percent;

  const _HeaderStatsRow(this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 8),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            //child: ProfileStrengthCard(progress: percent.toDouble() / 10),
            child: ProfileStrengthCard(progress: .7),
          ),
          const SizedBox(width: 12),
          const Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MiniStat(label: 'Saved', value: '12', icon: Icons.bookmark),
                MiniStat(label: 'Applied', value: '5', icon: Icons.send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
