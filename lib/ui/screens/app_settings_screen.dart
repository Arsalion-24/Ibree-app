import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibree/core/utils/theme/app_colors.dart';
import 'package:ibree/core/widgets/decorated_background.dart';
import 'package:ibree/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:ibree/features/settings/presentation/bloc/settings_event.dart';
import 'package:ibree/features/settings/presentation/bloc/settings_state.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.primary,
      ),
      body: DecoratedBackground(
        shapesCount: 15,
        shapesSeed: 765,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Settings',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    // Add your settings widgets here
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
