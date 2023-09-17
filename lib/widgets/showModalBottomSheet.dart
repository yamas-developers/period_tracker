import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'custom_app_button.dart';
class ShowModalBottomSheet extends StatefulWidget {

  const ShowModalBottomSheet({Key? key,}) : super(key: key);

  @override
  State<ShowModalBottomSheet> createState() => _ShowModalBottomSheetState();
}

class _ShowModalBottomSheetState extends State<ShowModalBottomSheet> {
  String? type;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final Map<String, dynamic>? data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (data != null) {
      type=data["type"];
    }
  }
  @override
  Widget build(BuildContext context) {
    print("MA: SMBS=>type$type");
    int selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: accentColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.clear_rounded,
            color: ovulationColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Padding(
              padding: EdgeInsets.only(top: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/temp/female_taking_picture.png",
                    fit: BoxFit.cover,
                    height: 150,width: 150,
                  )
                ],
              )
          ),
          const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "We're twisting, we're turning, we're\n"
                        "about to launch a new feature😎",
                    style: TextStyle(
                        fontSize: 19,
                        color: fontColor,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Find out how beneficial it'll be for you",
                    style: TextStyle(
                      fontSize: 15,
                      color: fontColor.withOpacity(0.5),
                    ),
                  )
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(5, (index) {
                    return GestureDetector(
                      onTap: (){
                        // setState(() {
                        //   selectedIndex=index;
                        // });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          height: 42,
                          width: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: fontLightColor.withOpacity(0.06),
                              border: selectedIndex==index?Border.all(
                                color: accentColor,
                                width: 2,
                              ):null
                          ),
                          child: Text(
                            index.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: fontColor.withOpacity(0.5),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              )
          ),
          selectedIndex!=null?
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(top:20),
              child: CustomAppButton(
                onTap: (){},
                height: 40,
                fontSize: 15,
                image: "",
                color: bgColor,
                title: "RATE",
              ),
            ),
          ):Padding(
            padding: const EdgeInsets.only(top:20),
            child: CustomAppButton(
              onTap: (){},
              height: 40,
              fontSize: 15,
              image: "",
              // color: bgColor.withOpacity(0.5),
              title: "RATE",
            ),
          ),
        ],
      ),
    );
  }
}
