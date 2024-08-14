import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itune/res/AppContextExtension.dart';
import 'package:itune/view/video_page/widget/video_player.dart';
import 'package:itune/view/common/text_view.dart';
import '../../../model/data_model/media_model/media_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatelessWidget {
  final Result media;

  const VideoPage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final resources = context.resources;

    return Scaffold(
      backgroundColor: resources.color.primaryColor,
      appBar: AppBar(
        title: const TextWidget(label: 'Description'),
        backgroundColor: resources.color.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: resources.color.secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Hero(
                      tag: media.trackId!, // Assuming trackId is unique
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          media.artworkUrl100 ?? '',
                          width: 100,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image, size: 50);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            label: media.trackName ?? 'Unknown Track',
                            fontSize: resources.dimension.mediumText,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          TextWidget(
                            label: media.artistName ?? 'Unknown Artist',
                            fontSize: resources.dimension.smallText,
                            color: resources.color.secondaryColor,
                          ),
                          const SizedBox(height: 10),
                          TextWidget(
                            label: media.primaryGenreName ?? 'Unknown Genre',
                            fontSize: resources.dimension.smallText,
                            color: resources.color.highlightColor,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              _launchURL(media.artistViewUrl ?? "");
                            },
                            icon: Icon(
                              CupertinoIcons.globe,
                              color: resources.color.blueColor,
                            ),
                            label: TextWidget(
                              label: "Visit Artist Page",
                              fontSize: resources.dimension.verySmallText,
                              color: resources.color.blueColor,
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              side:
                                  BorderSide(color: resources.color.blueColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextWidget(
              label: "Preview",
              fontSize: resources.dimension.smallText,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: VideoPlayerWidget(
                videoUrl: media.previewUrl ?? '',
              ),
            ),
            const SizedBox(height: 20),
            TextWidget(
              label: "Description",
              fontSize: resources.dimension.smallText,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: media.collectionCensoredName ??
                      '<p>No Description Available</p>',
                  style: {
                    "p": Style(
                      fontSize: FontSize(16.0),
                      color: resources.color.backgroundColor,
                    ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
