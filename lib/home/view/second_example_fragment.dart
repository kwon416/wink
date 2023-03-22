import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/custom_widget/space.dart';

class SearchFragment extends StatelessWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      bodyColor: colorScheme.onPrimaryContainer,
      displayColor: colorScheme.onPrimaryContainer,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        elevation: 0.3,
        title: Text('wink list', style: textTheme.titleLarge,),

      ),
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        padding: EdgeInsets.all(16),
        itemBuilder: (_, index) {
          return Container(
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: colorScheme.primaryContainer
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.outlet),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('title'),
                    8.height,
                    Row(
                      children: [
                        Text('subtitle'),
                        8.width,
                        Container(
                          decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.red, boxShape: BoxShape.circle),
                          width: 6,
                          height: 6,
                        ),
                        8.width,
                        Text('when', style: secondaryTextStyle(size: 12)),
                      ],
                    ),
                  ],
                ).expand()
              ],
            ),
          ).paddingOnly(bottom: 16);
        },
      ),

    );
  }
}
