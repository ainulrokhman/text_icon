import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Medsos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.9;
    var width = MediaQuery.of(context).size.width * 0.9;
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Kunjungi Kami",
            style: TextStyle(
              color: Colors.green[600],
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            height: height * 0.85,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/launcher.jpg")),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Denature Indonesia",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "PT Denature Indonesia Group",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(50, 176, 211, 159),
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          child: _buildMedsos(
                            title: "Facebook Page",
                            name: "De Nature Indonesia",
                            image: "facebook.jpg",
                            url: "https://facebook.com/cv.denatureindonesia",
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: _buildMedsos(
                            title: "Instagram",
                            name: "Review Denature",
                            image: "instagram.jpg",
                            url: "https://instagram.com/reviewdenature.id",
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: _buildMedsos(
                            title: "Youtube Channel",
                            name: "Review Denature",
                            image: "youtube.jpg",
                            url:
                                "https://youtube.com/channel/UCOyJ_zJOSU8X8Xg9YhweFgA",
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: _buildMedsos(
                            title: "Website",
                            name: "Denature Indonesia",
                            image: "web.jpg",
                            url: "http://www.denatureindonesia.com",
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildMedsos({
    @required String title,
    @required String name,
    @required String url,
    @required String image,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
          ),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    child: Text(title),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: FlatButton(
              onPressed: () {
                launchWhatsApp(url: url);
              },
              color: Colors.transparent,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage("images/$image"))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchWhatsApp({
    @required String url,
  }) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
