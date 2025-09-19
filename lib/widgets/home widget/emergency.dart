import 'package:flutter/material.dart';
import 'package:wsfty_apk/widgets/home%20widget/Emergencies/ambulance.dart';
import 'package:wsfty_apk/widgets/home%20widget/Emergencies/army.dart';
import 'package:wsfty_apk/widgets/home%20widget/Emergencies/Cyber.dart';
import 'package:wsfty_apk/widgets/home%20widget/Emergencies/mhremergency.dart';
import 'package:wsfty_apk/widgets/home%20widget/Emergencies/police.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 184,
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          CyberEmergency(),
          ArmyEmergency(),
          MHREmergency(),
        
        ],
      ),
    );
  }
}