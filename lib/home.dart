import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'details.dart';


class Home extends StatelessWidget {

  wp.WordPress WordPress =  wp.WordPress(
      baseUrl: 'https://islamicaskbd.com/'
  );

  fetchPosts(){
    Future <List<wp.Post>> posts = WordPress.fetchPosts(postParams: wp.ParamsPostList(
      context: wp.WordPressContext.view,
      pageNum: 1,
      perPage: 20,
    ),
      fetchAuthor: true,
      fetchCategories: true,
      fetchFeaturedMedia: true,
    );
    return posts;
  }

  getPostImage(wp.Post post){
    if(post.featuredMedia == null){
      return SizedBox();
    }
    return Image.network(post.featuredMedia.sourceUrl);
  }


  lunchUrl(String link) async{
    if(await canLaunch(link)){
      await launch(link);
    }else{
      throw 'can\'t find anything, Can you please turn on Data';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo-iask.png'),
        backgroundColor: Color(0xFFf6f8fc),
        elevation: 4.0,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFf6f8fc),
      body: Container(
        child: FutureBuilder(
          future: fetchPosts(),
          builder: (BuildContext context , AsyncSnapshot<List<wp.Post>> snapshot) {
            if(snapshot.connectionState == ConnectionState.none) {
              return Container();
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(itemCount: snapshot.data.length, itemBuilder: (context,index){
              wp.Post post = snapshot.data[index];
              return InkWell(
                enableFeedback: false,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Details(post),
                  ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 10.0),
                                      child: Container(

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      post.title.rendered,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.teal[600],
                                                        fontFamily: 'TatsamBengaliRndBold',

                                                      ),
                                                    ),



                                                    Html(
                                                      data: post.excerpt.rendered,
                                                      onLinkTap: (String url){
                                                        launch(url);
                                                      },
                                                    ),




                                                    SizedBox(
                                                      height: 25.0,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
//                                                      CircleAvatar(
//                                                        backgroundImage: NetworkImage(
//                                                            'https://image.shutterstock.com/image-photo/photo-owl-macro-photography-high-260nw-1178957458.jpg'),
//                                                      ),
                                                        Text('প্রশ্নোত্তরটি যোগ করেছেন:',
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                            fontFamily: 'TatsamBengaliRndLight',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              post.author.name,
                                                              textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.teal,
                                                                fontFamily: 'TatsamBengaliRndLight',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            );
          },
        ),
      ),
    );
  }
}
