import 'package:flutter/material.dart';
import 'package:ibree/ui/widgets/decorated_background.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 504,
        child: SingleChildScrollView(
          child: Center(
            child: Text('Notifications Screen'),
          ),
        ),
      ),
    );
  }
}
