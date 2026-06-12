import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class DesktopNavBar extends StatelessWidget {

  final ValueChanged<GlobalKey> onNavTap;
  final Map<String, GlobalKey> keys;


  const DesktopNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      child: Row(
        children: [
          // Logo
          const Text(
            'NazmulDev',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          // Nav links — each calls onNavTap with its specific key
          _NavLink(
            label: 'Hero',
            onTap: () => onNavTap(keys['hero']!),
          ),
          _NavLink(
            label: 'About',
            onTap: () => onNavTap(keys['about']!),
          ),
          _NavLink(
            label: 'Skills',
            onTap: () => onNavTap(keys['skills']!),
          ),
          _NavLink(
            label: 'Projects',
            onTap: () => onNavTap(keys['projects']!),
          ),
          _NavLink(
            label: 'Contact',
            onTap: () => onNavTap(keys['contact']!),
          ),

          const SizedBox(width: 32),

          // Resume button
          OutlinedButton(
            onPressed: () {}, // url_launcher later
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.accent),
              foregroundColor: AppColors.accent,
            ),
            child: const Text('Download Resume'),
          ),
        ],
      ),

    );

  }

}

// Small reusable nav link widget
class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}