import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wsfty_apk/Screen/login_screen.dart';
import 'package:wsfty_apk/utils/constants.dart';

class INTROScreen extends StatelessWidget {
  const INTROScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages =[
      PageViewModel(

  decoration: PageDecoration(
    pageColor: Colors.grey[200]
  ),
        titleWidget: SafeArea(
          child: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(child: Text('BINT-E-HAWWA',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)),
              ),
              
            ],
          ),
        ),
        bodyWidget: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Padding(
             padding: const EdgeInsets.only(top: 30,bottom: 40),
              child: Container(
                height: 220,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: secondaryColor.withOpacity(0.2),
                ),
                child: Image.asset('assets/bgservive.png',fit: BoxFit.cover,)),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Shake to Send Alert in Background',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Text('- Just shake your phone to trigger an emergency SMS.\n- Automatically sends your location to trusted contacts.\n- Works silently—even when the app is closed.\n- Smart safety that’s always with you, hands-free.'),
            ),
          ],
        )
      ),
      
PageViewModel(

  decoration: PageDecoration(
    pageColor: Colors.grey[200]
  ),
        titleWidget: SafeArea(
          child: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(child: Text('BINT-E-HAWWA',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)),
              ),
              
            ],
          ),
        ),
        bodyWidget: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 40),
              child: Container(
                height: 220,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: secondaryColor.withOpacity(0.2),
                ),
                child: Image.asset('assets/nearby.png')),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Inspiration & Safety Together',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Text('- Read uplifting Islamic articles for daily guidance.\n- Stay informed and spiritually connected.\n- Find nearby safe places with a single tap.\n- Peace for the soul, safety for the journey.'),
            ),
          ],
        )
      ),
      
PageViewModel(

  decoration: PageDecoration(
    pageColor: Colors.grey[200]
  ),
        titleWidget: SafeArea(
          child: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(child: Text('BINT-E-HAWWA',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)),
              ),
              
            ],
          ),
        ),
        bodyWidget: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 40),
              child: Container(
                height: 220,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: secondaryColor.withOpacity(0.2),
                ),
                
                child: Image.asset('assets/emergency.png',fit: BoxFit.cover,)),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Quick SOS Emergency Calls',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Text('- Reach emergency helplines instantly only with one tap.\n- Get help fast when every second matters.\n- Built for urgent situations—no delays.\n- Your safety is just a tap away.'),
            ),
          ],
        )
      ),
      
PageViewModel(

  decoration: PageDecoration(
    pageColor: Colors.grey[200]
  ),
        titleWidget: SafeArea(
          child: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(child: Text('BINT-E-HAWWA',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)),
              ),
              
            ],
          ),
        ),
        bodyWidget: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 40),
              child: Container(
                 height: 220,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: secondaryColor.withOpacity(0.2),
                ),
                child: Image.asset('assets/chating.png')),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Stay Connected with In-App Chat',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Text('- Chat securely with your guardians right within the application.\n- Get instant support in times of need.\n- Easily share updates, concerns, or your location.\n- Your safety circle is always just a message away.'),
            ),
          ],
        )
      ),
      

    ];
    return IntroductionScreen(
      autoScrollDuration: 5000,
      infiniteAutoScroll: true,
      pages: pages,
      globalBackgroundColor: Colors.grey[200],
      dotsDecorator: DotsDecorator(
        activeColor: primaryColor,
      ),
showSkipButton: true,
showBackButton: true,
skip: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    const Text('Skip',style: TextStyle(
      fontSize: 15
    ),),
    SizedBox(width: 10,),
    Icon(Icons.double_arrow_sharp,size: 25,)
  ],
),
back: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Icon(Icons.arrow_back_sharp,size: 25,),
     SizedBox(width: 10,),
    const Text('Back',style: TextStyle(
      fontSize: 15
    ),),
   
    
  ],
),
next: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    const Text('Next',style: TextStyle(
      fontSize: 15
    ),),
    SizedBox(width: 10,),
    Icon(Icons.arrow_forward_sharp,size: 25,)
  ],
),
done: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    const Text('Done',style: TextStyle(
      fontSize: 15
    ),),
    SizedBox(width: 10,),
    Icon(Icons.done,size: 25,)
  ],
),
onDone: (){goto(context, LoginScreen());},
    );
  }
}