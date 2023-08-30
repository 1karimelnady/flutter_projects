import 'package:flutter/material.dart';

class MessngerScreen extends StatelessWidget {
  const MessngerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("data:image/png;base64,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"),),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  size: 20.0,
                  color: Colors.white,
                ),
              )
          ),
          IconButton(
              onPressed: (){},
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  size: 20.0,
                  color: Colors.white,
                ),
              )
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.search
                        ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Search'
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>storybuilde(),
                    separatorBuilder: (context,index)=>SizedBox(width: 5.0),
                    itemCount:20
                ),
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context,index)=>chatbuild(),
                  separatorBuilder: (context,index)=>SizedBox(height: 20.0),
                  itemCount:20
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget storybuilde()=>Row(
    children: [
      Container(
        width: 97.0,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage("data:image/png;base64,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"),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      bottom: 3.0,
                      end: 3.0
                  ),
                  child: CircleAvatar(
                    radius: 6.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Karim Elnady',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
  Widget chatbuild()=> Row(
    children:
    [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage("data:image/png;base64,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"),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: 3.0,
                end: 3.0
            ),
            child: CircleAvatar(
              radius: 6.0,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(
            'Karim Elnady',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding:EdgeInsetsDirectional.symmetric(vertical: 5.0),
            child: Row(
              children:
              [
                Text(
                  'hello my name is karim',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 5.0),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Text(
                    '02:00 pm'
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );

}
