import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import '../../../state/current_user_state.dart';
import '../../../utils/app_theme.dart';

class DetailsContainer extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String title;
  final String fieldName;
  final String data;
  final IconData icon;
  final CurrentUser provider;
  const DetailsContainer({
    Key? key,
    required this.title,
    required this.fieldName,
    required this.data,
    required this.controller,
    required this.formKey,
    required this.icon,
    required this.provider,
  }) : super(key: key);

  @override
  State<DetailsContainer> createState() => _DetailsContainerState();
}

class _DetailsContainerState extends State<DetailsContainer> {
  final AppTheme theme = AppTheme();

  bool obscureText = false;

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<String> updateName() async {
    String response = '';

    try {
      response = await widget.provider.updateName(widget.controller.text);
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updateEmail() async {
    String response;

    try {
      response = await widget.provider.updateEmail(widget.controller.text);
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updatePassword() async {
    String response;

    try {
      response = await widget.provider.updatePassword(widget.controller.text);
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        width: size.width * 0.95,
        decoration: BoxDecoration(
          color: theme.kCanvasColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(6, 7),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: () async {
                      final scaffoldMessager = ScaffoldMessenger.of(context);
                      if (widget.formKey.currentState!.validate()) {
                        String response = '';
                        if (widget.fieldName == 'Full Name') {
                          response = await updateName();
                        } else if (widget.fieldName == 'Email') {
                          response = await updateEmail();
                        } else {
                          response = await updatePassword();
                        }
                        scaffoldMessager
                            .showSnackBar(SnackBar(content: Text(response)));
                      }
                    },
                    child: ClayContainer(
                      color: theme.kCanvasColor,
                      surfaceColor: theme.kSecondaryColor,
                      borderRadius: 200,
                      depth: 40,
                      curveType: CurveType.concave,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.kWhiteText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 14),
              child: Row(
                children: [
                  Text(
                    widget.fieldName,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Form(
              key: widget.formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.kCanvasColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(6, 9),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: widget.controller,
                  obscureText:
                      (widget.fieldName == 'Password') ? obscureText : false,
                  decoration: InputDecoration(
                    hintText: widget.data,
                    prefixIcon: Icon(
                      widget.icon,
                    ),
                    // if(fieldName == 'Password')
                    suffixIcon: (widget.fieldName == 'Password')
                        ? IconButton(
                            onPressed: showPassword,
                            icon: (obscureText)
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          )
                        : const SizedBox(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    } else if (value == 'some data') {
                      return 'New ${widget.fieldName} cannot be same as current';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
