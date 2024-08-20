import 'package:diggify/design/components/components.dart';
import 'package:diggify/design/sizes.dart';

class ListenLaterItemTile extends StatelessWidget {
  const ListenLaterItemTile({
    super.key,
    required this.thumbnail,
    required this.title,
    this.description,
    this.onPressed,
  });

  factory ListenLaterItemTile.track({
    Key? key,
    required Uri thumbnail,
    required String title,
    required String albumTitle,
    required String artistName,
    VoidCallback? onPressed,
  }) {
    return ListenLaterItemTile(
      key: key,
      thumbnail: thumbnail,
      title: title,
      description: '$albumTitle • $artistName',
      onPressed: onPressed,
    );
  }

  factory ListenLaterItemTile.album({
    Key? key,
    required Uri thumbnail,
    required String title,
    required String artistName,
    required int releaseYear,
    VoidCallback? onPressed,
  }) {
    return ListenLaterItemTile(
      key: key,
      thumbnail: thumbnail,
      title: title,
      description: '$releaseYear • $artistName',
      onPressed: onPressed,
    );
  }

  factory ListenLaterItemTile.artist({
    Key? key,
    required Uri thumbnail,
    required String name,
    VoidCallback? onPressed,
  }) {
    return ListenLaterItemTile(
      key: key,
      thumbnail: thumbnail,
      title: name,
      onPressed: onPressed,
    );
  }

  final Uri thumbnail;
  final String title;
  final String? description;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            mediumSpaceSize,
            smallSpaceSize,
            tinySpaceSize,
            smallSpaceSize,
          ),
          child: Row(
            children: [
              SizedBox(
                height: mediumSize,
                child: Thumbnail(
                  src: NetworkImage(thumbnail.toString()),
                  shape: ThumbnailShape.square,
                ),
              ),
              Spacer.medium,
              switch (description) {
                null => Expanded(child: TitleMedium(title)),
                final description => Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleMedium(title),
                        TitleSmall(description),
                      ],
                    ),
                  ),
              },
              Spacer.small,
              PopupMenuButton(itemBuilder: itemBuilder),
            ],
          ),
        ),
      ),
    );
  }
}
