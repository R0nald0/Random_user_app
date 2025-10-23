import 'package:flutter/material.dart';
import 'package:random_user_bus_2_teste/app/core/ui/theme/app_theme.dart';

class ExpandableItem extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ValueNotifier<bool> _isExpandedNotifier;

   ExpandableItem({
    super.key,
    required this.title,
    required this.children,
    
  }) : _isExpandedNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isExpandedNotifier,
        builder: (context, isExpanded, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTheme.theme.textTheme.displayLarge,
                    ),
                  ),
                  IconButton(
                    icon: AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: isExpanded ? 0.5 : 0.0, 
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                    onPressed: () {
                      _isExpandedNotifier.value = !isExpanded;
                    },
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: children),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          );
        },
      ),
    );
  }
}
