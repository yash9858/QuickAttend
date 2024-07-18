import 'package:flutter/material.dart';

class SubAdminHome extends StatelessWidget {
  const SubAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: mh * 0.02,right: mh * 0.02, top: mh * 0.04),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Lectures',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add,size: 30,),
                  )
                ],
              ),
              SizedBox(height: mh * 0.01,),
              SizedBox(
                  height: mh * 0.15,
                  child : PageView.builder(
                  itemCount: 4,
                  itemBuilder: (context, int index){
                    return Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: mh * 0.02, vertical: mh * 0.01),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lecture Name',
                              style: TextStyle(
                                  fontSize: mh * 0.02,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                            SizedBox(height: mh * 0.005,),
                            Text(
                              'Time Duration Of Lecture',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.teal,
                                  fontSize: mh * 0.019
                              ),
                            ),
                            SizedBox(height: mh * 0.003,),
                            Text(
                              'Description Of An Lecture',
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
                },
              )),
              SizedBox(height: mh * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Student List',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, int index){
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name Of Student'),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.edit,size: 20,),
                            ),
                          ],
                        ),
                        Text('Class Of Student'),
                        Text('Total Day Attend'),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        elevation: 5.0,
        child: Icon(Icons.add,size: 25,),
      ),
    );
  }
}
