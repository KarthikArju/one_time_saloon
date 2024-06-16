import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salon/utils/api.dart';
import 'package:salon/widgets/shared_functions.dart';
import '../utils/colors.dart';

class SearchSaloon extends StatefulWidget {
  const SearchSaloon({super.key});

  @override
  State<SearchSaloon> createState() => _SearchSaloonState();
}

class _SearchSaloonState extends State<SearchSaloon> {
  List searchList = [];
  bool isLoading = false;
  void searchForSaloon(String value) async {
    setState(() {
      isLoading=true;
      searchList.clear();
    });
    var request = {"salonname": value};
    var res = await http.post(
      Uri.parse(APIEndPoints.searchSaloon),
      body: request,
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['status'] == 'success') {
       if(jsonDecode(res.body)["data"]!=null && jsonDecode(res.body)["data"]!=[]){
         setState(() {
          searchList = jsonDecode(res.body)["data"];
          isLoading = false;
        });
       }
       else{
         setState(() {
          searchList.clear();
          isLoading=false;
        });
       }
      } else {
        setState(() {
          searchList.clear();
          isLoading=false;
        });
      }
    } else {
      toastify("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 36),
            child: TextField(
              onChanged:(v){
                searchForSaloon(v);
              },
              decoration: const InputDecoration(
                hintText: "Search for saloon,services and barber",
                border: InputBorder.none
              ),
            ),
          ),
        isLoading ? pageLoader() :  searchList.isNotEmpty? ListView.builder(
            itemCount: searchList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (c,i){
                     return Container(
                      margin: const EdgeInsets.only(top: 12,left: 12,right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(searchList[i]["name"],style: 
                            const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(searchList[i]["address"])
                          ],
                        ),
                      ),
                     );
          }) :  const Padding(
            padding: EdgeInsets.only(top:38.0),
            child: Center(
              child: Text("No results found",style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
