import 'dart:async';
import 'dart:convert';

import 'package:event_app/app/configs/colors.dart';
import 'package:event_app/app/resources/constant/named_routes.dart';
import 'package:event_app/data/event_model.dart';
import 'package:event_app/ui/widgets/circle_button.dart';
import 'package:event_app/ui/widgets/custom_app_bar.dart';
import 'package:event_app/ui/widgets/stack_participant.dart';
import 'package:flutter/material.dart';

import 'API.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  DetailPage1 createState() => DetailPage1();
}

class DetailPage1 extends State<DetailPage> {
  var data;
  late Timer timer;
  var output;
  String out = "--";
  @override
  void initState() {
    super.initState();
    addValue();
    timer = Timer.periodic(const Duration(seconds: 500000), (Timer t) => addValue());
  }

  void addValue() async {
    String url = "http://192.168.1.7:5000/fdata";
    data = await Getdata(url);
    setState(() {
      var decoded = jsonDecode(data);
      output = decoded;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> eventData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final EventModel eventModel = EventModel.fromJson(eventData);
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  children: [
                    _buildAppBar(context),
                    const SizedBox(height: 24),
                    _buildCardImage(eventModel),
                    const SizedBox(height: 16),
                    _buildDescription(eventModel, out, output),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomBar(context, eventModel),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, EventModel eventModel) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
        decoration: const BoxDecoration(color: AppColors.whiteColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sensor Status:",
                  style:
                      TextStyle(fontSize: 12, color: AppColors.greyTextColor),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Text(
                      "Working fine",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                NamedRoutes.ticketScreen,
                arguments: eventModel.toJson(),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  maximumSize: const Size(200, 150)),
              child: const Text(
                "See record",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardImage(EventModel eventModel) => Stack(
        children: [
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16)),
          ),
          Container(
            width: double.infinity,
            height: 310,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  eventModel.image,
                ),
              ),
            ),
          ),
          Positioned(
            right: 22,
            top: 22,
            child: Container(
              height: 65,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    eventModel.date.split(" ")[0],
                  ),
                  Text(
                    eventModel.date.split(" ")[1],
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget _buildAppBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            icon: 'assets/images/ic_arrow_left.png',
            onTap: () => Navigator.pop(context),
          ),
          const Text(
            "Detail",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          CircleButton(
            icon: 'assets/images/ic_dots.png',
            onTap: () {},
          )
        ],
      );
}

_buildDescription(EventModel eventModel, out, output) {
  if (output == null) {
    out = "--";
  } else {
    out = output[eventModel.id];
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventModel.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_location.png',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      out,
                      style: const TextStyle(color: AppColors.greyTextColor),
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 65,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Live",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: eventModel.description,
                    style: const TextStyle(
                      color: AppColors.greyTextColor,
                      fontSize: 12,
                      height: 1.75,
                    ),
                  ),
                ),

              const SizedBox(height: 25),
              Image.network("https://purehydroponics.com/wp-content/uploads/2016/08/Temperature-Vs-DO-Levels.gif"),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    ),
  );
}
