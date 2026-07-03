import 'package:flutter/material.dart';
import 'package:mynotes/constants/app_brand.dart';
import 'package:mynotes/theme/app_theme.dart';
import 'package:mynotes/widgets/mindpad_icon.dart';

class AuthScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Widget> children;

  const AuthScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.background, Color(0xFF1B1225), Color(0xFF102520)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const MindPadIcon(size: 76),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppBrand.name,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: colorScheme.tertiary,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                title,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: AppTheme.primary, width: 4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          subtitle,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppTheme.mutedInk,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppTheme.surface.withAlpha(190),
                        border: const Border(
                          top: BorderSide(color: AppTheme.border),
                          bottom: BorderSide(color: AppTheme.border),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary.withAlpha(32),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    icon,
                                    color: colorScheme.primary,
                                    size: 21,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    title,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: children,
                            ),
                            const SizedBox(height: 2),
                            const Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ColoredBox(
                                    color: AppTheme.primary,
                                    child: SizedBox(height: 3),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ColoredBox(
                                    color: AppTheme.accent,
                                    child: SizedBox(height: 3),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: ColoredBox(
                                    color: AppTheme.secondary,
                                    child: SizedBox(height: 3),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ColoredBox(
                                    color: AppTheme.plum,
                                    child: SizedBox(height: 3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
