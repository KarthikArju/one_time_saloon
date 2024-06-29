import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SalonView extends StatelessWidget {
  const SalonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverAppBar(
              stretch: true,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
              //  iconTheme: IconThemeData(color: AppTheme.whiteBackgroundColor),
              expandedHeight: 220, // Set the height of the header when expanded
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                background: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: <Widget>[
                    // Add the background image
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('assets/onboarding1.png'),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        //color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    width: double.infinity,
                    height: 30,
                  ))),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "TONI&GUY",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.appbackgroundColor,
                          ),
                        ),
                        Text(
                          "KOYEMBEDU",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.appbackgroundColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color.fromRGBO(255, 196, 45, 1),
                              size: 20,
                            ),
                            Text(
                              "4.0",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                //  color: AppColors.appbackgroundColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Color.fromRGBO(85, 216, 90, 1),
                              size: 20,
                            ),
                            Text(
                              "  Verified account",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(85, 216, 90, 1),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  "About Us:",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.appbackgroundColor,
                  ),
                ), Text(
                  "Meanwhile, the India Meteorological Department (IMD) has issued a forecast for Thursday, predicting partly cloudy skies with achance of light rain and thundershowers in the evening. Expect hot nd humid conditions to prevail across the city and suburbs.",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appbackgroundColor,
                  ),
                ),
              ],
            ),
          ))
        ]));
  }
}
