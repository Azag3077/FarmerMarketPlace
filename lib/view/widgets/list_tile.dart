import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.onTap,
    this.leadingIconData,
    required this.title,
  }) : super(key: key);
  final VoidCallback? onTap;
  final IconData? leadingIconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leadingIconData == null
          ? null
          : Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                leadingIconData!,
                color: Colors.grey.shade600,
                size: 20.0,
              ),
            ),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 6.0,
      ),
    );
  }
}
