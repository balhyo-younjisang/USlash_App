import 'package:app/views/screens/home.screen.dart';
import 'package:app/views/widgets/button.widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<StatefulWidget> createState() => InterestScreenState();
}

class InterestScreenState extends State<InterestScreen>
    with SingleTickerProviderStateMixin {
  final List<String> interestCategories = [
    '밈',
    '유행어',
    '챌린지',
    '패션',
    '인물',
    '춤',
    "AI",
    '노래',
    '여행',
    '메이크업',
    '인형',
    '음식',
  ];
  final Set<String> _selectedInterests = {};

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // 캐릭터의 중심점 계산
    double characterCenterX = size.width * 0.5;
    double characterCenterY = size.height * 0.1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 애니메이션 영역
            SizedBox(
              height: size.height * 0.2,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 메인 캐릭터 (중앙에 배치)
                    Positioned(
                      left:
                          characterCenterX -
                          (size.width * 0.1), // 캐릭터 너비의 절반만큼 왼쪽으로
                      top:
                          characterCenterY -
                          (size.width * 0.1), // 캐릭터 높이의 절반만큼 위로
                      child: Image(
                        image: AssetImage("assets/images/y_character.png"),
                        width: size.width * 0.2,
                      ),
                    ),
                    // 첫 번째 물음표 (오른쪽 위)
                    AnimatedBuilder(
                      animation: _animation,
                      child: Image(
                        image: AssetImage("assets/images/question_mark.png"),
                        width: size.width * 0.03,
                      ),
                      builder: (context, child) {
                        double radius = 60 + (_animation.value * 10);
                        double angle = -math.pi / 4; // -45도
                        return Positioned(
                          top:
                              characterCenterY +
                              math.sin(angle) * radius -
                              (size.width * 0.015),
                          left:
                              characterCenterX +
                              math.cos(angle) * radius -
                              (size.width * 0.015),
                          child: Transform.rotate(
                            angle: _animation.value * 0.5,
                            child: child,
                          ),
                        );
                      },
                    ),
                    // 두 번째 물음표 (왼쪽 위)
                    AnimatedBuilder(
                      animation: _animation,
                      child: Image(
                        image: AssetImage("assets/images/question_mark.png"),
                        width: size.width * 0.03,
                      ),
                      builder: (context, child) {
                        double radius = 70 + (_animation.value * -8);
                        double angle = -3 * math.pi / 4; // -135도
                        return Positioned(
                          top:
                              characterCenterY +
                              math.sin(angle) * radius -
                              (size.width * 0.015),
                          left:
                              characterCenterX +
                              math.cos(angle) * radius -
                              (size.width * 0.015),
                          child: Transform.rotate(
                            angle: -_animation.value * 0.7,
                            child: child,
                          ),
                        );
                      },
                    ),
                    // 세 번째 물음표 (오른쪽 아래)
                    AnimatedBuilder(
                      animation: _animation,
                      child: Image(
                        image: AssetImage("assets/images/question_mark.png"),
                        width: size.width * 0.03,
                      ),
                      builder: (context, child) {
                        double radius = 55 + (_animation.value * 12);
                        double angle = math.pi / 3; // 60도
                        return Positioned(
                          top:
                              characterCenterY +
                              math.sin(angle) * radius -
                              (size.width * 0.015),
                          left:
                              characterCenterX +
                              math.cos(angle) * radius +
                              (size.width * 0.015),
                          child: Transform.rotate(
                            angle: _animation.value * 0.3,
                            child: child,
                          ),
                        );
                      },
                    ),
                    // 네 번째 물음표 (왼쪽 아래)
                    AnimatedBuilder(
                      animation: _animation,
                      child: Image(
                        image: AssetImage("assets/images/question_mark.png"),
                        width: size.width * 0.03,
                      ),
                      builder: (context, child) {
                        double radius = 65 + (_animation.value * 6);
                        double angle = 5 * math.pi / 6; // 150도
                        return Positioned(
                          top:
                              characterCenterY +
                              math.sin(angle) * radius -
                              (size.width * 0.015) +
                              (_animation.value * -8),
                          left:
                              characterCenterX +
                              math.cos(angle) * radius -
                              (size.width * 0.03),
                          child: Transform.rotate(
                            angle: -_animation.value * 0.4,
                            child: child,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '당신이 알고싶은 트렌드는 \n 무엇인가요?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            // 나머지 콘텐츠 영역
            SizedBox(
              height: size.height * 0.55,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1,
                          ),
                      itemCount: interestCategories.length,
                      itemBuilder: (context, index) {
                        final String interest = interestCategories[index];
                        final bool isSelected = _selectedInterests.contains(
                          interest,
                        );
                        return _InterestButton(
                          text: interest,
                          isSelected: isSelected,
                          selectedColor: const Color.fromRGBO(86, 167, 244, 1),
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                _selectedInterests.remove(interest);
                              } else {
                                _selectedInterests.add(interest);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.8,
              child: ColoredTextButton(
                pressHandler: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                text: "다음 단계로",
                color: Colors.white,
                backgroundColor: Color.fromRGBO(86, 167, 244, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InterestButton extends StatelessWidget {
  const _InterestButton({
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    required this.selectedColor,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 3,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(40, 40), // 크기 조절
          backgroundColor: isSelected ? selectedColor : Colors.white, // 예시 색상
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: 12, // 그림자 효과
          shadowColor: Colors.black.withValues(alpha: 0.4), // 그림자 색상
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
