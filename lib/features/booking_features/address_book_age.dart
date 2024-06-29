import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salon/features/booking_features/add_address_book_details.dart';
import 'package:salon/features/booking_features/service_booking_page.dart';
import 'package:salon/features/booking_features/show_success_page.dart';
import 'package:salon/home_subpages/model/AddressModel.dart';

import 'package:salon/utils/colors.dart';
import 'package:salon/widgets/home_items_list.dart';
import 'package:http/http.dart' as http;
import '../../utils/api.dart';
import '../../widgets/shared_functions.dart';

class AddressBookPage extends StatefulWidget {
  const AddressBookPage({super.key});

  @override
  State<AddressBookPage> createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage> {
  bool isChecked = false;
  bool isLoading = false;
  int selectedIndex=0;
  @override
  void initState() {
    super.initState();
    getAddress();
  }

  AddressModel addressList = AddressModel();
  getAddress() async {
    var response = await http.post(Uri.parse(APIEndPoints.address));
    print("succc");

    if (response.statusCode == 200) {
      isLoading = true;
      print("succc");
      addressList = AddressModel.fromJson(jsonDecode(response.body));
      setState(() {});
    } else {
      isLoading = true;
      setState(() {});
      addressList = AddressModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbackgroundColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Address Book',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAdressPage()));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: !isLoading
          ? pageLoader()
          : Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 8),
        child: ListView.builder(
          itemCount: addressList.data!.salonName!.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addressList.data!.salonName![index].fname!,
                        style: const TextStyle(
                          color: AppColors.appbackgroundColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                       selectedIndex==index? Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ),
                          Text(
                            ' Default',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ): Row(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            color: AppColors.appbackgroundColor,
                            size: 20,
                          ),
                          Text(
                            ' Default',
                            style: TextStyle(
                              color: AppColors.appbackgroundColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomPaint(
                    painter: LinePainter(),
                    size: const Size(500, 0.10),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    constraints:
                        const BoxConstraints.tightFor(width: double.infinity),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        Text(
                          addressList.data!.salonName![index].payAddress!,
                          style: const TextStyle(
                            color: AppColors.appbackgroundColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(','),
                        Text(
                          addressList.data!.salonName![index].payCity!,
                          style: const TextStyle(
                            color: AppColors.appbackgroundColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(','),
                        Text(
                          addressList.data!.salonName![index].payState!,
                          style: const TextStyle(
                            color: AppColors.appbackgroundColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(','),
                        Text(
                          addressList.data!.salonName![index].payPincode!,
                          style: const TextStyle(
                            color: AppColors.appbackgroundColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 0.7, // Scale the checkbox size
                        child: Checkbox(
                          visualDensity: VisualDensity.compact,
                          side: const BorderSide(
                              color: AppColors.appbackgroundColor),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          value: selectedIndex==index,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                              selectedIndex=index;
                            });
                          },
                          activeColor: AppColors.appbackgroundColor,
                          checkColor: Colors.white,
                        ),
                      ),
                      const Text(
                        'Use as the payment address',
                        style: TextStyle(
                          color: AppColors.appbackgroundColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShowSuccessPage(),
              ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.appbackgroundColor
      ..strokeWidth = 0.66;

    final starPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(starPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
