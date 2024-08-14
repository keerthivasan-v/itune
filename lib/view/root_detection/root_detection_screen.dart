import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itune/res/AppContextExtension.dart';
import 'package:itune/view/search/startsearch_page.dart';
import 'package:itune/view/common/text_view.dart';
import 'package:itune/view_model/root_detection_view_model.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootState = ref.watch(rootDetectionProvider);
    final resources = context.resources;

    return Scaffold(
      backgroundColor: resources.color.primaryColor,
      appBar: AppBar(
          backgroundColor: resources.color.primaryColor,
          title: TextWidget(label: 'Root checker example app')),
      body: Center(
        child: rootState.rootedCheck
            ? _buildRootedContent(context)
            : _buildNotRootedContent(context),
      ),
    );
  }

  Widget _buildRootedContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.warning, size: 80, color: Colors.red),
        const SizedBox(height: 20),
        const TextWidget(
            label: 'Access Denied - Root detected',
            fontWeight: FontWeight.bold,
            color: Colors.orange),
        const SizedBox(height: 10),
        TextWidget(
          label: 'This cannot be used on rooted devices.',
          fontWeight: FontWeight.bold,
          fontSize: context.resources.dimension.smallText,
        ),
      ],
    );
  }

  Widget _buildNotRootedContent(BuildContext context) {
    return Container();
  }
}

class RootAPP extends ConsumerStatefulWidget {
  const RootAPP({super.key});

  @override
  _RootAPPState createState() => _RootAPPState();
}

class _RootAPPState extends ConsumerState<RootAPP> {
  @override
  void initState() {
    super.initState();
    ref.read(rootDetectionProvider.notifier).checkRootStatus().then((_) {
      final rootState = ref.read(rootDetectionProvider);
      if (!rootState.rootedCheck) {
        Navigator.of(context).pushReplacementNamed(StartSearchPage.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RootScreen(),
    );
  }
}
