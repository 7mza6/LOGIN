import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:users/Views/constants.dart';
import 'package:users/Views/theam.dart';

import '../auth/models/userModel.dart';
import 'Responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: kAllPadding8,
              child: Text('Hello, ${CurrentUser.getcurrentUser()?.username}', style: kSheetTitleStyle,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Welcome back to your personalized learning hub.', style: kSheetSubtitleStyle,),
            ),
            Padding(
              padding: kAllPadding8,
              child: Text('Your Progress', style: kCardDataStyle,),
            ),
            SizedBox(
              width: double.infinity,
              child: grid(),
            ),
            Padding(
              padding: kAllPadding8,
              child: Text('Quick Actions', style: kCardDataStyle,),
            ),
          ],
        ),
      ),
    );
  }
}

class grid extends StatelessWidget {
  const grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 200,
        crossAxisCount: Responsive.isMobile(context) ? 1 : Responsive.isTablet(context) ? 2 : 4,
      ),
      itemCount:  4,
      itemBuilder: (context, index) {
       switch (index) {
         case 0:
           return card(title: 'Courses Enrolled',icon: FontAwesomeIcons.book,data: Text('12', style:kCardDataStyle,));
         case 1:
           return card(title: 'Pending Assignments',icon: FontAwesomeIcons.tasks,data: Text('3',style: kCardDataStyle,));
         case 2:
           return card(title: 'Upcoming Quizzes',icon: Icons.calendar_month_outlined ,data: Text('Oct 12',style: kCardDataStyle,));
         case 3:
           return card(title: 'Overall Progress',icon: Icons.speed,data: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('75%',style: kCardDataStyle,),
               Text('75% achieved',style: kSheetSubtitleStyle,),
             ],
           ));
         default:
       }

      },
    );
  }
}

class card extends StatelessWidget {
  final title;
  final icon;
  final Widget data;
  const card({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kAllPadding8,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 0.5,
              offset: Offset(0, 0.5),
            ),
          ],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
          child:Padding(
            padding: kAllPadding8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 0 , vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeMode.light == getThemeMode() ? kAccentColor : kAccentColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(100000),
                    ),
                    height: 40,
                    width: 40,
                    child: Icon(icon,size: 20,
                    color:  ThemeMode.dark== getThemeMode() ? kAccentColor : Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(title,style: kSheetSubtitleStyle),
                ),
                data,
              ],
            ),
          ),
        ),
    );
  }
}