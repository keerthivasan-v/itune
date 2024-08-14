import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itune/model/data_model/media_model/media_model.dart';
import 'package:itune/res/AppContextExtension.dart';
import 'package:itune/view/video_page/video_page.dart';
import 'package:itune/view/common/text_view.dart';
import 'package:itune/view_model/search_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String id = "home_page";
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resources = context.resources;

    return Scaffold(
      backgroundColor: resources.color.primaryColor,
      appBar: AppBar(
        backgroundColor: resources.color.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.resources.color.secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const TextWidget(label: 'iTunes Search'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          tabs: [
            _buildTabItem(context, 'Grid view', _activeTabIndex == 0),
            _buildTabItem(context, 'List view', _activeTabIndex == 1),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final searchState = ref.watch(searchViewModelProvider);

                return searchState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : searchState.mediaList.when(
                        data: (mediaList) {
                          return TabBarView(
                            controller: _tabController,
                            children: [
                              _buildMediaGridView(
                                mediaList,
                              ),
                              _buildMediaListView(mediaList),
                            ],
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) =>
                            Center(child: Text('Error: $error')),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String label, bool isSelected) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? context.resources.color.tabBarColor
              : context.resources.color.transparentColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        alignment: Alignment.center,
        child: TextWidget(
          label: label,
          fontSize: context.resources.dimension.smallText,
        ),
      ),
    );
  }

  Widget _buildMediaGridView(
    List mediaList,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
      ),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final media = mediaList[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPage(media: media),
              ),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    media.artworkUrl100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                          child: Icon(Icons.broken_image, size: 50));
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.0, 0.7],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Text(
                      media.trackName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMediaListView(
    List mediaList,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final media = mediaList[index];

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                media.artworkUrl60,
                fit: BoxFit.cover,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 40);
                },
              ),
            ),
            title: Text(
              media.trackName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(media.artistName),
            trailing:
                Icon(Icons.play_arrow, color: Theme.of(context).primaryColor),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPage(media: media),
                ),
              );
              // Implement your onTap logic here
            },
          ),
        );
      },
    );
  }
}
