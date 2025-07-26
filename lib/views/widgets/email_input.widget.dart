import 'package:flutter/material.dart';

class EmailInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final String? errorText;

  const EmailInputWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.errorText,
  });

  @override
  State<StatefulWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  final List<String> _domains = [
    'gmail.com',
    'naver.com',
    'daum.net',
    'hanmail.net',
    'kakao.com',
    'outlook.com',
    'icloud.com',
  ];
  String? _selectedDomain;
  late TextEditingController _usernameController;
  late TextEditingController _domainController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _domainController = TextEditingController();

    // Initialize controllers if the main controller already has a value
    if (widget.controller.text.contains('@')) {
      final parts = widget.controller.text.split('@');
      _usernameController.text = parts[0];
      _domainController.text = parts[1];
      _selectedDomain = parts[1];
    } else {
      _usernameController.text = widget.controller.text;
    }

    _usernameController.addListener(_updateMainController);
    _domainController.addListener(_updateMainController);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_updateMainController);
    _domainController.removeListener(_updateMainController);
    _usernameController.dispose();
    _domainController.dispose();
    super.dispose();
  }

  void _updateMainController() {
    widget.controller.text = '${_usernameController.text}@${_domainController.text}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _usernameController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: TextStyle(color: Color.fromRGBO(189, 189, 189, 1)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Color.fromRGBO(224, 224, 224, 1),
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email username';
            }
            return null;
          },
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text('@', style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedDomain,
                hint: Text('Select or type domain'),
                decoration: InputDecoration(
                  errorText: widget.errorText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(224, 224, 224, 1),
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                ),
                items: _domains.map((String domain) {
                  return DropdownMenuItem<String>(
                    value: domain,
                    child: Text(domain),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDomain = newValue;
                    _domainController.text = newValue ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select or enter a domain';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: _domainController,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Custom domain',
                  hintStyle: TextStyle(color: Color.fromRGBO(189, 189, 189, 1)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(224, 224, 224, 1),
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedDomain = null; // Clear selected domain if typing custom
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a domain';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
