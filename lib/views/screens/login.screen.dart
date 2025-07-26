import 'package:app/views/screens/home.screen.dart';
import 'package:app/views/screens/register.screen.dart';
import 'package:app/views/widgets/button.widget.dart';
import 'package:app/views/widgets/input.widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _yJumpAnimation;
  late Animation<double> _zJumpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    )..repeat();

    _yJumpAnimation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: -20.0),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: -20.0, end: 0.0),
            weight: 1,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          ),
        );

    _zJumpAnimation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: -20.0),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: -20.0, end: 0.0),
            weight: 1,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: size.height * 0.45,
          width: size.width * 0.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "yozm에\n오신 것을 환영합니다",
                    style: TextStyle(
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _yJumpAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _yJumpAnimation.value),
                        child: Image(
                          image: AssetImage("assets/images/y_character.png"),
                          width: size.width * 0.13,
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _zJumpAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _zJumpAnimation.value),
                        child: Image(
                          image: AssetImage("assets/images/z_character.png"),
                          width: size.width * 0.12,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              Column(
                spacing: 10,
                children: [
                  InputWidget(
                    controller: _idController,
                    labelText: "아이디를 입력해주세요",
                    isObsecure: false,
                  ),

                  InputWidget(
                    controller: _passwordController,
                    labelText: "비밀번호를 입력해주세요",
                    isObsecure: true,
                  ),

                  ColoredTextButton(
                    pressHandler: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    text: "로그인",
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(86, 127, 244, 1),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  InkWell(onTap: () {}, child: Text("아이디 찾기")),
                  Container(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    width: 1,
                    height: 10,
                  ),
                  InkWell(onTap: () {}, child: Text("비밀번호 찾기")),
                  Container(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    width: 1,
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text("회원가입"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
