import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itune/res/AppContextExtension.dart';
import 'package:itune/view/home_page/home_page.dart';
import 'package:itune/view_model/search_view_model.dart';

import '../../../view_model/query_view_model.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: "video");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchViewModel = ref.watch(searchViewModelProvider.notifier);

    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        onChanged: (value) {
          ref.read(queryProvider.notifier).state = value;
        },
        style: TextStyle(color: context.resources.color.secondaryColor),
        decoration: InputDecoration(
          hintText: 'Search...',
          filled: true,
          fillColor: Color.fromARGB(115, 112, 110, 110),
          hintStyle: TextStyle(
            color: context.resources.color.secondaryColor,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                searchViewModel.fetchMedia(_controller.text).then(
                  (value) {
                    Navigator.of(context).pushNamed(HomePage.id);
                  },
                );
              },
              icon: const Icon(Icons.search)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (query) {
          if (_formKey.currentState?.validate() ?? false) {
            searchViewModel.fetchMedia(query).then(
              (value) {
                Navigator.of(context).pushNamed(HomePage.id);
              },
            );
          }
        },
      ),
    );
  }
}
