import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {

  var Name = ['Check In', 'Check Out', 'Percentage', 'Total Days'];
  var iconName = [Icons.login, Icons.logout, Icons.percent, Icons.calendar_month_rounded];
  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
      body : SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mh * 0.02, vertical: mh * 0.022),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: mh * 0.035,
                        ),
                        SizedBox(width: mh * 0.012,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name Of Organization',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: mh * 0.017
                              ),
                            ),
                            Text(
                              'Yash Mistry',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: mh * 0.021
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.notifications_active_outlined,size: mh * 0.035,),
                    )
                  ],
                ),
                SizedBox(height: mh * 0.03,),
                Row(
                  children: [
                    Text(
                      "Today's Attendence",
                      style: TextStyle(
                        fontSize: mh * 0.03,
                      ),
                    )
                  ],
                ),
                SizedBox(height:  mh * 0.02,),
                GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: mh * 0.028,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, int index){
                      return Card(
                          shadowColor: Colors.grey,
                          semanticContainer: true,
                          margin: EdgeInsets.only(bottom: mh * 0.05),
                          elevation: 5.0,
                          child: Padding(
                            padding: EdgeInsets.only(left :mh * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   Expanded(
                                     child:  Text(
                                       Name[index],
                                       style: TextStyle(
                                           fontSize: mh * 0.022,
                                           fontWeight: FontWeight.w600
                                       ),
                                     ),
                                   ),
                                    IconButton(
                                      icon: Icon(iconName[index], size: mh * 0.03,),
                                      onPressed: (){},
                                    )
                                  ],
                                ),
                                SizedBox(height: mh * 0.01,),
                                Expanded(
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: mh * 0.019,
                                        color: Colors.grey.shade700
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      );
                    }
                ),
                Row(
                  children: [
                    Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: mh * 0.035,
                      ),
                    )
                  ],
                ),
                SizedBox(height: mh * 0.02,),
                SizedBox(
                  height: mh * 0.13,
                  child: PageView.builder(
                     itemCount: 4,
                     itemBuilder:(context, int index){
                       return Card(
                         elevation: 5.0,
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: mh * 0.02, vertical: mh * 0.01),
                           child:  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 'Heading',
                                 style: TextStyle(
                                   fontSize: mh * 0.02,
                                   fontWeight: FontWeight.w800
                                 ),
                               ),
                               SizedBox(height: mh * 0.005,),
                               Text(
                                 'Time Duration Of Event',
                                 style: TextStyle(
                                   fontWeight: FontWeight.w700,
                                   color: Colors.teal,
                                   fontSize: mh * 0.019
                                 ),
                               ),
                               SizedBox(height: mh * 0.003,),
                               Text(
                                 'Description Of An Events',
                                 style: TextStyle(
                                   fontWeight: FontWeight.w600,
                                   fontSize: mh * 0.018,
                                   color: Colors.grey
                                 ),
                               ),
                             ],
                           ),
                         )
                       );
                     }
                 ),
                ),
                SizedBox(height: mh * 0.02,),
                Row(
                  children: [
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontSize: mh * 0.035,
                      ),
                    )
                  ],
                ),
                SizedBox(height: mh * 0.02,),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, int index){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: mh * 0.01),
                        child: ListTile(
                          onTap: (){},
                          style: ListTileStyle.list,
                          tileColor: Colors.teal[100],
                        )
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


