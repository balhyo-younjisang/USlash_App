import 'package:app/views/widgets/button.widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final List<Map<String, String>> contentData = [];

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _fetchContentData();
  }

  Future<void> _fetchContentData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/content'));
      if (response.statusCode == 200) {
        setState(() {
          contentData = List<Map<String, String>>.from(json.decode(response.body));
        });
      } else {
        print('Failed to load content data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching content data: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePodcastPlayback() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('audios/podcast.mp3'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        centerTitle: false,
        toolbarHeight: 60.0,
        title: Text('빈티지 패션', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: AssetImage("assets/images/z_character.png"),
                  width: size.width * 0.25,
                ),
                Column(
                  children: [
                    Text(
                      "\"70~90년대 스타일을 \n 현재적으로 재해석한 패션이예요!\"",
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: size.width * 0.8,
              child: Column(
                children: [
                  ColoredTextButton(
                    pressHandler: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.7,
                            minChildSize: 0.3,
                            maxChildSize: 0.9,
                            expand: false,
                            builder: (_, controller) {
                              return Container(
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  controller: controller,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 40,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "밴쿠버의 패션 애호가들에게 기쁜 소식이 있습니다! 바로 노스밴 빈티지숍이 새롭게 문을 열면서 많은 이들의 관심을 받고 있는데요. 이곳은 이름 그대로 ‘옷장 속 숨은 보물’ 같은 곳으로, 오랫동안 손이 닿지 않았던 빈티지 아이템들이 가득 전시되어 있어 누구든 특별한 발견을 할 수 있습니다.\n\n이 빈티지숍은 개성 넘치는 스타일을 좋아하는 사람들에게 딱 맞는 장소입니다. 다양한 시대별 의상과 액세서리들이 정성스럽게 정리되어 있어, 어떤 옷이든 자신만의 독특한 스타일을 연출할 수 있답니다. 특히, 이곳은 지역 주민들뿐만 아니라, 유럽이나 아시아에서 온 관광객들도 찾아오는 인기 명소로 자리매김하고 있는데요. 매번 방문할 때마다 새로운 보물을 찾아낼 수 있어, 반복 방문하는 흥미도 높아지고 있습니다.\n\n밴쿠버의 패션 신에 새 바람을 불어넣고 있는 노스밴 빈티지숍은 지역 사회와도 활발히 소통하며, 친근하고 따뜻한 분위기를 자아내고 있습니다. 누구든 부담 없이 방문해 자신의 개성을 표현하는 데 큰 도움을 받을 수 있는 이곳! 앞으로도 더 많은 ‘옷장 속 숨은 보물’들이 발굴될 기대가 모아지고 있습니다. 패션으로 자신만의 이야기를 만들어 보고 싶다면, 이 멋진 빈티지숍을 꼭 한 번 들러보세요.",
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    text: "아티클 읽기",
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(86, 127, 244, 1),
                  ),
                  SizedBox(height: 10),
                  ColoredTextButton(
                    pressHandler: _togglePodcastPlayback,
                    text: _isPlaying ? "팟캐스트 일시정지" : "팟캐스트 듣기",
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(86, 127, 244, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            // Content Cards
            contentData.isEmpty
                ? Center(child: Text('데이터가 없습니다.'))
                : Column(
                    children: contentData.map((data) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["title"]!,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Image(
                          image: AssetImage(data["image"]!),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          data["hashtags"]!,
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                        SizedBox(height: 5.0),
                        data["instagramLink"] != null
                            ? InkWell(
                                onTap: () {
                                  launchUrl(Uri.parse(data["instagramLink"]!));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 16.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "인스타그램 바로가기",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
