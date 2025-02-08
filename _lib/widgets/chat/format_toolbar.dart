import 'package:flutter/material.dart';

class FormatToolbar extends StatelessWidget {
  const FormatToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Wrap(
        spacing: 8,
        children: [
          _buildFormatButton(context, Icons.format_bold, 'Bold'),
          _buildFormatButton(context, Icons.format_italic, 'Italic'),
          _buildFormatButton(context, Icons.format_underline, 'Underline'),
          _buildFormatButton(
              context, Icons.format_strikethrough, 'Strikethrough'),
          _buildFormatButton(context, Icons.code, 'Code'),
          _buildFormatButton(context, Icons.link, 'Link'),
          _buildFormatButton(
              context, Icons.format_list_bulleted, 'Bullet List'),
          _buildFormatButton(
              context, Icons.format_list_numbered, 'Numbered List'),
        ],
      ),
    );
  }

  Widget _buildFormatButton(
      BuildContext context, IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {
          // Handle formatting
        },
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
