import 'package:app/views/screens/content.screen.dart';
import 'package:app/views/screens/search.screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:app/views/widgets/button.widget.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomeContentWidgetState();
}

class HomeContentWidgetState extends State<HomeContentWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.95,
              height: size.height * 0.05,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: const Color.fromRGBO(189, 189, 189, 1),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "검색어를 입력해주세요",
                          style: TextStyle(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                        Iconify(
                          MaterialSymbols.search,
                          color: Color.fromRGBO(189, 189, 189, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.025),
                child: const Text(
                  "패션 Top 5",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height:
                  size.height * 0.25, // Adjust height as needed for your items
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // 5 dummy items
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => {
                      // Handle item tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContentScreen(currentIndex: index),
                        ),
                      ),
                    },
                    child: Container(
                      width: size.width * 0.55, // Adjust width as needed
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 10,
                            child: Container(
                              width: size.width * 0.3,
                              height: size.height * 0.12,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image(
                                image: AssetImage(
                                  "assets/images/vintage$index.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 70,
                            right: 15,
                            child: Container(
                              width: size.width * 0.3,
                              height: size.height * 0.12,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image(
                                image: AssetImage(
                                  "assets/images/vintage${index + 1}.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.025),
                child: const Text(
                  "요즘 가장 핫한 🔥",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height:
                  size.height * 0.2, // Adjust height as needed for your items
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // 5 dummy items
                itemBuilder: (context, index) {
                  final List<Map<String, String>> dummyData = [
                    {
                      "image": "assets/images/labubu.png",
                      "title": "라부부(LABUBU)",
                    },
                    {
                      "image": "assets/images/cryingbaby.png",
                      "title": "크라잉 베이비(Crying Baby)",
                    },
                    {"image": "assets/images/kpop.png", "title": "케이팝 데몬 헌터즈"},
                    {"image": "assets/images/food1.png", "title": "맛있는 음식 4"},
                    {"image": "assets/images/food2.png", "title": "맛있는 음식 5"},
                  ];
                  return Container(
                    width: size.width * 0.35, // Adjust width as needed
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Dummy background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          dummyData[index]["image"]!,
                          width: size.width * 0.35,
                          height: size.height * 0.15,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          dummyData[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.025),
                    child: const Text(
                      "제트의 추천",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: size.width * 0.05,
                  children: [
                    Image(
                      image: AssetImage("assets/images/z_character.png"),
                      width: size.width * 0.25,
                    ),
                    Text(
                      "\"유저님이 좋아하실만한 트렌드를 \n 가지고 왔어요!\"",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height:
                      size.height *
                      0.2, // Adjust height as needed for your items
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // 5 dummy items
                    itemBuilder: (context, index) {
                      final List<Map<String, String>> dummyData = [
                        {
                          "image": "assets/images/food1.png",
                          "title": "메가 팥빙 젤라또",
                        },
                        {
                          "image": "assets/images/food2.png",
                          "title": "과일 먹은 마시멜로우",
                        },
                        {"image": "assets/images/food3.png", "title": "쫀득쿠기"},
                        {
                          "image": "assets/images/vintage3.png",
                          "title": "빈티지 패션 4",
                        },
                        {
                          "image": "assets/images/vintage0.png",
                          "title": "빈티지 패션 5",
                        },
                      ];
                      return Container(
                        width: size.width * 0.35, // Adjust width as needed
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Dummy background color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              dummyData[index]["image"]!,
                              width: size.width * 0.35,
                              height: size.height * 0.15,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              dummyData[index]["title"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.025),
                    child: const Text(
                      "퀴즈타임!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: size.width * 0.05,
                  children: [
                    Image(
                      image: AssetImage("assets/images/y_character.png"),
                      width: size.width * 0.25,
                    ),
                    Column(
                      children: [
                        Text(
                          "날카로운 이빨과 쫑긋한 귀를 \n 가진 인형의 이름은?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.01),
                        ColoredTextButton(
                          pressHandler: () {
                            // Handle button press
                          },
                          text: "라부부",
                          color: Colors.black,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.grey,
                          width: size.width * 0.6,
                          height: size.height * 0.05,
                        ),
                        SizedBox(height: size.height * 0.01),
                        ColoredTextButton(
                          pressHandler: () {
                            // Handle button press
                          },
                          text: "크라잉 베이비",
                          color: Colors.black,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.grey,
                          width: size.width * 0.6,
                          height: size.height * 0.05,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
