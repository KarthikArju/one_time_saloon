import 'package:flutter/material.dart';
import 'package:salon/features/service_page.dart';
import 'package:salon/home_subpages/model/service_list_response.dart';

import 'package:salon/home_subpages/service_viewall.dart';
import 'package:salon/widgets/home_items_list.dart';

class Services extends StatelessWidget {
  final ServiceListResponse serviceList;
  const Services({super.key, required this.serviceList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // color: const Color.fromARGB(255, 217, 217, 217),
      // margin: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select a Service',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ServiceViewAllPage(serviceList: serviceList)),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          serviceList.data!.serviceName!.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: ListView.builder(
                      itemCount: serviceList.data!.serviceName!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var details = serviceList.data!.serviceName![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ServiceType(
                                          category: details.category!,
                                        )));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                  child: ClipRect(
                                    // borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(340, 180)),

                                    child: Container(
                                      height: 70,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: ExactAssetImage(index < 10
                                                ? serviceListItem[index]
                                                    .imageUrl
                                                : serviceListItem[9].imageUrl),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${details.category!}\n${details.servicename!}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
