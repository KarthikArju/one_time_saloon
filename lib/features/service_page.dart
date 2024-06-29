import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salon/home_subpages/model/get_service_response.dart';
import 'package:salon/utils/api.dart';
import 'package:salon/utils/colors.dart';

import '../widgets/shared_functions.dart';

class ServiceType extends StatefulWidget {
  final String category;
  const ServiceType({super.key, required this.category});

  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  bool isLoading = true;
  GetServiceResponse serviceDetail = GetServiceResponse();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    getServiceDetails();
  }

  getServiceDetails() async {
    var map = {};
    map['servicename'] = widget.category;

    var response = await http.post(
      Uri.parse(APIEndPoints.getService),
      body: map,
    );

    if (response.statusCode == 200) {
      setState(() {
        toastify("Service list fetched successfully");
        serviceDetail = GetServiceResponse.fromJson(jsonDecode(response.body));
        isLoading = false;
      });
      return true;
    } else {
      setState(() {
        toastify("Something went wrong");
        isLoading = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appbackgroundColor,
      body: isLoading
          ? pageLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 52,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const Text(
                      "Service Types",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                serviceDetail.data!.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(left:16.0,right: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: serviceDetail.data!.length,
                          padding: const EdgeInsets.only(bottom: 0),
                          itemBuilder: (c, i) {
                            var details = serviceDetail.data![i];
                            return Container(
                              margin: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Category : ${details.category!}"),
                                    Text(
                                        "Service Name : ${details.servicename!}"),
                                    Text("Price : ${details.price!}")
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                    : const Center(
                        child: Text(
                          "No Data found",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      )
              ],
            ),
    );
  }
}
