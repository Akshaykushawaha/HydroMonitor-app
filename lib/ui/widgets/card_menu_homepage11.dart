/*
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:event_app/app/configs/colors.dart';
import 'package:event_app/data/event_model.dart';
import 'package:flutter/material.dart';

import '../pages/API.dart';

class CardPopularEvent extends StatefulWidget {
  final EventModel eventModel;

  CardPopularEvent({required this.eventModel, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CardPopularEvent1();
}

class CardPopularEvent1 extends State<CardPopularEvent>{
  var data;
  late Timer timer;
  String output="--:-- --";
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => addValue());
  }
  void addValue() async {
    String url = "https://hydromonitor.azurewebsites.net/fdata";
    data = await Getdata(url);
    setState(() {
      var decoded = jsonDecode(data);
      output = decoded['val'];
    }
    );
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 75,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          //_buildCardImage(),
          _buildCardDesc(),
        ],
      ),
    );
  }

  _buildCardDesc() =>
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventModel.title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Image.asset('assets/images/ic_location.png', width: 14),
                      const SizedBox(width: 4),
                      Text(
                        widget.eventModel.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.greyTextColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                ),
                //child: Image.asset(status_confirmaion(), width: 12),
              )
            ],
          ),
        ),
      );

  /*String status_confirmaion() {
    if (eventModel.status=="green") {
      return "assets/images/green.png";
    }
    else if(eventModel.status=="red") {
      return "assets/images/red.png";
    }
    return "assets/images/red.png";
  }*/

}*/