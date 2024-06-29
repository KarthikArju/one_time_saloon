// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salon/home_subpages/model/saloon_detail_response.dart';
import 'package:salon/home_subpages/model/saloon_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:salon/home_subpages/salon_viewall.dart';
import 'package:salon/utils/colors.dart';
import 'package:salon/widgets/home_items_list.dart';
import 'package:salon/widgets/shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api.dart';

class Salon extends StatefulWidget {
  final SaloonListResponse saloonList;

  const Salon({super.key, required this.saloonList});

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> {
  SaloonDetailResponse saloonDetail = SaloonDetailResponse();
  bool isLoading = false;
  bool bookSaloonLoader = false;
  Future getSaloonDetail(id) async {
    setState(() {
      isLoading = true;
      showSaloonDetail(true);
    });
    var map = {};
    map['salonid'] = id;

    var response = await http.post(
      Uri.parse(APIEndPoints.saloonDetail),
      body: map,
    );

    if (response.statusCode == 200) {
      setState(() {
        saloonDetail = SaloonDetailResponse.fromJson(jsonDecode(response.body));
        debugPrint("the saloon detail : ${saloonDetail}");
        Navigator.pop(context);
        showSaloonDetail(false);
        isLoading = false;
      });
      return true;
    } else {
      setState(() {
        isLoading = false;
      });
      return false;
    }
  }

  Future bookSaloon() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    setState(() {
      bookSaloonLoader = true;
    });
    var map = {};
    map['email'] = prefs.getString("Email");

    var response = await http.post(
      Uri.parse(APIEndPoints.bookSaloon),
      body: map,
    );

    if (response.statusCode == 200) {
      setState(() {
        toastify("Saloon booked successfully");
        bookSaloonLoader = false;
        Navigator.pop(context);
      });
      return true;
    } else {
      setState(() {
        toastify("Something went wrong");
        bookSaloonLoader = false;
        Navigator.pop(context);
      });
      return false;
    }
  }

  showSaloonDetail(bool status) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return status == false
            ? SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "${saloonDetail.data![0].name}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("Saloon Id : ${saloonDetail.data![0].saloonid!}"),
                      Text("Email : ${saloonDetail.data![0].email}"),
                      Text("Phone : ${saloonDetail.data![0].phone}"),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            bookSaloon();
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.appbackgroundColor),
                            child: bookSaloonLoader
                                ? pageLoader()
                                : const Center(
                                    child: Text(
                                      "Book",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : appLoader();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: const Color.fromARGB(255, 217, 217, 217),
      // margin: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select a Salon',
                style: TextStyle(
                    color: AppColors.appbackgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SalonViewAllPage(
                              saloonList: widget.saloonList,
                            )),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                      color: AppColors.appbackgroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(salonListItem.length, (index) {
                var saloon = widget.saloonList.data!.salonName![index];
                return GestureDetector(
                  onTap: () {
                    getSaloonDetail(saloon.saloonid);
                  },
                  child: Container(
                    width: 150,
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  height: 90,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                  child: ClipRect(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: ExactAssetImage(index < 6
                                                ? salonListItem[index].imageUrl
                                                : salonListItem[
                                                        salonListItem.length -
                                                            1]
                                                    .imageUrl),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  saloon.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: AppColors.appbackgroundColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
