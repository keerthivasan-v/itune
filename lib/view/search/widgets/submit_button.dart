import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itune/res/Resources.dart';
import 'package:itune/view/shared/text_view.dart';
import 'package:itune/view_model/search_view_model.dart';

import '../../../view_model/query_view_model.dart';
import '../../search_result/search_result_screen.dart';

class SubmitButton extends ConsumerWidget {
  final Resources resources;

  const SubmitButton({super.key, required this.resources});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchViewModel = ref.watch(searchViewModelProvider.notifier);
    final searchState = ref.watch(searchViewModelProvider);
    final query = ref.watch(queryProvider);

    return SizedBox(
      width: double.maxFinite,
      height: resources.dimension.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: resources.color.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: searchState.loading
            ? null
            : () => _handleSubmit(ref, searchViewModel, query, context),
        child: searchState.loading
            ? _buildLoadingIndicator()
            : const MyTextView(
                label: "Submit",
                fontWeight: FontWeight.bold,
              ),
      ),
    );
  }

  void _handleSubmit(WidgetRef ref, MediaSearchNotifier searchViewModel,
      String query, BuildContext context) {
    if (query.trim().isNotEmpty) {
      searchViewModel.fetchMedia(query).then(
        (value) {
          Navigator.of(context).pushNamed(SearchResultScreen.id);
        },
      );
    } else {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a search query',
            style: TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.redAccent, // Background color
          behavior:
              SnackBarBehavior.floating, // Optional: make the SnackBar float
        ),
      );
    }
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 24.0,
      height: 24.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
