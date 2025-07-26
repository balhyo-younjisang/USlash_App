import 'package:app/views/screens/interest.screen.dart';
import 'package:app/views/screens/login.screen.dart';
import 'package:app/views/widgets/button.widget.dart';
import 'package:app/views/widgets/input.widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController _emailPrefixController = TextEditingController();
  final TextEditingController _customDomainController = TextEditingController();
  final List<String> _emailDomains = ['naver.com', 'gmail.com', '직접입력'];
  String? _selectedDomain = 'naver.com';
  final TextEditingController phoneController = TextEditingController();

  bool _isIdValid = false;
  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool _isPhoneValid = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    idController.addListener(_updateButtonStates);
    passwordController.addListener(_updateButtonStates);
    passwordConfirmController.addListener(_updateButtonStates);
    _emailPrefixController.addListener(_updateButtonStates);
    _customDomainController.addListener(_updateButtonStates);
    phoneController.addListener(_updateButtonStates);
    _updateButtonStates(); // Initial check
  }

  @override
  void dispose() {
    idController.removeListener(_updateButtonStates);
    passwordController.removeListener(_updateButtonStates);
    passwordConfirmController.removeListener(_updateButtonStates);
    _emailPrefixController.removeListener(_updateButtonStates);
    _customDomainController.removeListener(_updateButtonStates);
    phoneController.removeListener(_updateButtonStates);

    idController.dispose();
    passwordController.dispose();
    _emailPrefixController.dispose();
    _customDomainController.dispose();
    phoneController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  void _updateButtonStates() {
    setState(() {
      _isIdValid = idController.text.isNotEmpty;
      _isPasswordValid =
          passwordController.text.isNotEmpty &&
          passwordConfirmController.text.isNotEmpty &&
          passwordController.text == passwordConfirmController.text;
      _isEmailValid =
          _emailPrefixController.text.isNotEmpty &&
          (_selectedDomain != '직접입력' ||
              _customDomainController.text.isNotEmpty);
      _isPhoneValid =
          phoneController.text.isNotEmpty &&
          RegExp(r"^\d{3}-\d{3,4}-\d{4}$").hasMatch(phoneController.text);

      _isFormValid =
          _isIdValid && _isPasswordValid && _isEmailValid && _isPhoneValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("아이디", style: TextStyle(fontSize: 14)),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: size.height * 0.05,
                            child: InputWidget(
                              controller: idController,
                              labelText: "아이디",
                              isObsecure: false,
                              backgroundColor: const Color.fromRGBO(
                                245,
                                245,
                                245,
                                1,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '아이디를 입력해주세요.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: size.width * 0.2,
                          child: ColoredTextButton(
                            width: size.width * 0.02,
                            height: size.height * 0.05,
                            pressHandler: _isIdValid ? () => {} : () {},
                            text: "중복확인",
                            color: _isIdValid
                                ? Colors.white
                                : const Color.fromRGBO(189, 189, 189, 1),
                            backgroundColor: _isIdValid
                                ? Theme.of(context).primaryColor
                                : const Color.fromRGBO(245, 245, 245, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("비밀번호", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.05,
                      child: InputWidget(
                        controller: passwordController,
                        labelText: "비밀번호",
                        isObsecure: true,
                        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.05,
                      child: InputWidget(
                        controller: passwordConfirmController,
                        labelText: "비밀번호 확인",
                        isObsecure: true,
                        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호 확인을 입력해주세요.';
                          }
                          if (value != passwordController.text) {
                            return '비밀번호가 일치하지 않습니다.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("이메일", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.35,
                          height: size.height * 0.05,
                          child: InputWidget(
                            controller: _emailPrefixController,
                            labelText: "이메일",
                            isObsecure: false,
                            backgroundColor: const Color.fromRGBO(
                              245,
                              245,
                              245,
                              1,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '이메일 주소를 입력해주세요.';
                              }
                              String domain = _selectedDomain == '직접입력'
                                  ? _customDomainController.text
                                  : _selectedDomain!;
                              if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch("$value@$domain")) {
                                return '유효한 이메일 주소를 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text(" @ "),
                        SizedBox(
                          width: size.width * 0.4,
                          height: size.height * 0.05,
                          child: DropdownButtonFormField<String>(
                            value: _selectedDomain,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDomain = newValue;
                                if (newValue != '직접입력') {
                                  _customDomainController.clear();
                                }
                                _updateButtonStates();
                              });
                            },
                            items: _emailDomains.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(245, 245, 245, 1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_selectedDomain == '직접입력') SizedBox(height: 10),
                    if (_selectedDomain == '직접입력')
                      SizedBox(
                        width: size.width * 0.5,
                        height: size.height * 0.05,
                        child: InputWidget(
                          controller: _customDomainController,
                          labelText: "도메인 직접입력",
                          isObsecure: false,
                          backgroundColor: const Color.fromRGBO(
                            245,
                            245,
                            245,
                            1,
                          ),
                          validator: (value) {
                            if (_selectedDomain == '직접입력' &&
                                (value == null || value.isEmpty)) {
                              return '도메인을 입력해주세요.';
                            }
                            return null;
                          },
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("휴대폰 번호", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: size.height * 0.05,
                            child: InputWidget(
                              controller: phoneController,
                              labelText: "휴대폰 번호",
                              isObsecure: false,
                              backgroundColor: const Color.fromRGBO(
                                245,
                                245,
                                245,
                                1,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '휴대폰 번호를 입력해주세요.';
                                }
                                if (!RegExp(
                                  r"^\d{3}-\d{3,4}-\d{4}$",
                                ).hasMatch(value)) {
                                  return '유효한 휴대폰 번호를 입력해주세요. (예: 010-1234-5678)';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: size.width * 0.3,
                          child: ColoredTextButton(
                            width: size.width * 0.02,
                            height: size.height * 0.05,
                            pressHandler: _isPhoneValid ? () => {} : () {},
                            text: "인증번호 받기",
                            color: _isPhoneValid
                                ? Colors.white
                                : const Color.fromRGBO(189, 189, 189, 1),
                            backgroundColor: _isPhoneValid
                                ? Theme.of(context).primaryColor
                                : const Color.fromRGBO(245, 245, 245, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ColoredTextButton(
                width: size.width * 0.8,
                height: size.height * 0.05,
                pressHandler: _isFormValid
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InterestScreen(),
                            ),
                          );
                        }
                      }
                    : () {},
                text: "가입하기",
                color: _isFormValid
                    ? Colors.white
                    : const Color.fromRGBO(189, 189, 189, 1),
                backgroundColor: _isFormValid
                    ? Theme.of(context).primaryColor
                    : const Color.fromRGBO(245, 245, 245, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text("로그인"),
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
