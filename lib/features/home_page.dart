import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon/features/menu_drawer.dart';
import 'package:salon/features/search_saloon.dart';
import 'package:salon/home_subpages/model/saloon_list_response.dart';
import 'package:salon/home_subpages/model/service_list_response.dart';
import 'package:salon/utils/api.dart';
import 'package:salon/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:salon/widgets/home_luxury_item.dart';
import 'package:salon/widgets/home_recommended_item.dart';
import 'package:salon/widgets/home_salon_items.dart';
import 'package:salon/widgets/home_service_items.dart';
import 'package:salon/widgets/shared_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SaloonListResponse saloonLists = SaloonListResponse();
  ServiceListResponse serviceList = ServiceListResponse();
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await getSaloonList().then(
      (value) {
        getServiceList().then((val) {
          setState(() {
            saloonLists = value;
            serviceList = val;
            isLoading = false;
          });
        });
      },
    ).catchError((e) {
      toastify("Something went wrong");
      return e;
    });
  }

  Future<SaloonListResponse> getSaloonList() async {
    var response = await http.post(Uri.parse(APIEndPoints.saloonList));
    print("succc");

    if (response.statusCode == 200) {
      print("succc");
      return SaloonListResponse.fromJson(jsonDecode(response.body));
    } else {
      return saloonLists;
    }
  }

  Future<ServiceListResponse> getServiceList() async {
    var response = await http.post(Uri.parse(APIEndPoints.serviceList));
    print("succc");

    if (response.statusCode == 200) {
      print("succc");
      return ServiceListResponse.fromJson(jsonDecode(response.body));
    } else {
      return serviceList;
    }
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey1,
      drawer: const MenuNavBar(),

      // endDrawer: Drawer(
      //    key: _scaffoldKey2,
      //   child: const FilterNavBar() ,
      // ),

      body: isLoading
          ? pageLoader()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.appbackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRect(
                      child: Container(
                        width: double.infinity,
                        height: 270,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage('assets/onboarding1.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 22),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Open the drawer
                                      _scaffoldKey1.currentState?.openDrawer();
                                    },
                                    child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadiusDirectional.all(
                                                    Radius.circular(50))),
                                        child: const Icon(
                                          Icons.menu_rounded,
                                          size: 26,
                                          color: Colors.white,
                                        )),
                                  ),
                                  GestureDetector(
                                    // onTap: () {
                                    //   showModalBottomSheet(

                                    //       context: context,
                                    //       builder: (BuildContext context) {
                                    //         return const FilerBottomSheet();
                                    //       });
                                    // },
                                    //  onTap: () {
                                    //   // Open the drawer
                                    //   _scaffoldKey2.currentState?.openEndDrawer();
                                    // },
                                    child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadiusDirectional.all(
                                                    Radius.circular(50))),
                                        child: const Icon(
                                          Icons.filter_list_alt,
                                          size: 26,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchSaloon()));
                              },
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 36),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Salon, Services, Barber',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                    Icon(Icons.search,
                                        color: AppColors.appbackgroundColor)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const Barbar(),
                    Salon(
                      saloonList: saloonLists,
                    ),
                    Services(
                      serviceList: serviceList,
                    ),
                    // const RecommenedSection(),
                    const LuxurySection(),
                  ],
                ),
              ),
            ),
    );
  }
}
