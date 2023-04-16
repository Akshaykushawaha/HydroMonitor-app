import 'dart:async';
import 'dart:convert';
import 'package:event_app/app/configs/colors.dart';
import 'package:event_app/app/resources/constant/named_routes.dart';
import 'package:event_app/bloc/event_cubit.dart';
import 'package:event_app/data/event_model.dart';
import 'package:event_app/ui/pages/API.dart';
import 'package:event_app/ui/widgets/card_menu_homepage.dart';
import 'package:event_app/ui/widgets/custom_app_bar.dart';
import 'package:event_app/ui/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _Homepage1 createState() => _Homepage1();
}

class _Homepage1 extends State<HomePage>{
  var data;
  late Timer timer;
  String output="--:-- --";
  var out;

  @override
  void initState() {
    super.initState();
    addValue(0);
    timer = Timer.periodic(const Duration(seconds: 20), (Timer t) => addValue(1));
  }
  void addValue(o) async {
    String url = "https://hydromonitor.azurewebsites.net/fdata?sensor=no";
    if (o==0) {
      String url = "https://hydromonitor.azurewebsites.net/fdata?sensor=yes";
    }
    data = await Getdata(url);
    setState(() {
      var decoded = jsonDecode(data);
      output = decoded['val'];
      out = decoded;
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      appBar:
      const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      bottomNavigationBar: const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: MyNavigationBar()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSearch(),
              const SizedBox(height: 24),
              Container(
                child:
             Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Status of sensors :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "(Last Updated: at "+output+")",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            BlocProvider(create: (_) =>
            EventCubit()
              ..loadEventData(),
              child: Column(
                children: [
                  BlocBuilder<EventCubit, EventState>(
                    builder: (context, state) {
                      if (state is EventError) {
                        return Center(child: Text(state.message));
                      } else if (state is EventLoaded) {
                        return _listPopularEvent(state.events,out);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
              )
            ],
          ),
        ),
      ),

    );
  }
}



    _buildHeader() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hydroponics Monitoring App",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(children: [
                Image.asset('assets/images/pin_drop.png', width: 20),
                const SizedBox(width: 1),
                const Text(
                  "Home, Pune, India",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://www.clearwaycommunitysolar.com/wp-content/uploads/2019/03/iStock-956366756-1024x683.jpg"),
              ),
            ),
          )
        ],
      ),
    );

    _buildSearch() => Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: const [
           SizedBox(width: 8),
           Text(
            "          Greener Earth, Cleaner Earth!!",
            style: TextStyle(
                color: AppColors.greyTextColor, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );

    _listPopularEvent(List<EventModel> events,out) {
      print(out);
      print("The values received:");
      if (out == null) {
        out = {
          'temp': "--",
          'humidity': "--",
          'light': "--",
          'soil': "--",
          'water': "--",
          'npk': "--",
          'time': "--"
        };
        print("here start");
        print(out);
        print("here end");
      }
      return Container(
        width: double.infinity,
        height: 450,
        padding: const EdgeInsets.only(left: 5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: events.length,
          itemBuilder: (context, index) =>
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(
                      arguments: events[index].toJson(),
                      context,
                      NamedRoutes.detailScreen,
                    ),
                child: CardPopularEvent(
                    title: events[index].title, id: out[events[index].id]),
              ),
        ),
      );
    }

