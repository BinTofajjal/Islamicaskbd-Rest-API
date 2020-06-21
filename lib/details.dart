import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';


// ignore: must_be_immutable
class Details extends StatelessWidget {

  wp.Post post;
  Details(this.post);


  getPostImage(wp.Post post){
    if(post.featuredMedia == null){
      return SizedBox(
        height: 5.0,
      );
    }
    return Image.network(post.featuredMedia.sourceUrl);
  }


  lunchUrl(String link) async{
    if(await canLaunch(link)){
      await launch(link);
    }else{
      throw 'can\'t find anything from $link, Can you please turn on Data';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 4.0,
        title: Image.asset('images/logo-iask.png'),
        backgroundColor: Color(0xFFf6f8fc),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFf6f8fc),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title.rendered.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[600],
                    fontFamily: 'TatsamBengaliRndBold',
                  ),
                ),

//                 Text(
//                   post.author.name.toString(),
//                  textAlign: TextAlign.left,
//                  style: TextStyle(
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.black,
//                    fontFamily: 'TatsamBengaliRndLight',
//                  ),
//                ),
//
//                SizedBox(
//                  height: 10.0,
//                ),
//
//                Text('প্রশ্নোত্তরটি যোগ করেছেন:',
//                  style: TextStyle(
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.black,
//                    fontFamily: 'TatsamBengaliRndLight',
//                  ),
//                ),
//                SizedBox(
//                  width: 10.0,
//                ),
//                 Text(
//                   post.date.replaceAll('T', ' '),
//                  textAlign: TextAlign.left,
//                  style: TextStyle(
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.normal,
//                    color: Colors.black,
//                    fontFamily: 'TatsamBengaliRndLight',
//                  ),
//                ),

                SizedBox(
                  height: 10.0,
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: getPostImage(post),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Html(
                  data: post.content.rendered,
                  onLinkTap: (String url){
                    launch(url);
                  },
                ),



              ],
            ),
          ),

        ),
      ),

    );
  }
}
