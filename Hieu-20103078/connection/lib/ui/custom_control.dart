import 'package:connection/models/place.dart';
import 'package:connection/models/lop.dart';
import 'package:flutter/material.dart';

import '../models/profile.dart';
import 'AppConstant.dart';

class CustomPlaceDropDown extends StatefulWidget {
  const CustomPlaceDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.callback,
    required this.list,
    required this.valueName,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Place> list;

  final Function(int ouputId, String outputName) callback;
  @override
  State<CustomPlaceDropDown> createState() => _CustomPlaceDropDownState();
}

class _CustomPlaceDropDownState extends State<CustomPlaceDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    outputId = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: AppConstant.textbody,
            ),
            status == 0
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 1;
                      });
                    },
                    child: Text(
                      widget.valueName == "" ? "không có" : widget.valueName,
                      style: AppConstant.textbodyfocus,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200]),
                    width: widget.width,
                    child: DropdownButton(
                      value: widget.valueId,
                      items: widget.list
                          .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Container(
                                width: widget.width - 45,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: Text(
                                  e.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          outputId = value!;
                          for (var dropitem in widget.list) {
                            if (dropitem.id == outputId) {
                              outputName = dropitem.name;
                              widget.callback(outputId, outputName);
                              break;
                            }
                          }
                          status = 0;
                        });
                      },
                    ),
                  ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

class custombutton extends StatelessWidget {
  const custombutton({
    super.key,
    required this.textButton,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 71, 126),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTestField extends StatelessWidget {
  const CustomTestField({
    super.key,
    required TextEditingController textController,
    required this.hinText,
    required this.obscureText,
  }) : _textControler = textController;

  final TextEditingController _textControler;
  final String hinText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 183, 185, 183),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: TextField(
          obscureText: obscureText,
          controller: _textControler,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: hinText),
        ),
      ),
    );
  }
}

class custombutton2 extends StatelessWidget {
  const custombutton2({
    super.key,
    required this.textButton,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 175, 8),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: const Color.fromARGB(6, 41, 25, 110).withOpacity(0.5),
      child: const Center(
        child: Image(
          width: 80,
          image: AssetImage('./assets/img/Loading.gif'),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textButton,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController textController,
    required this.hintText,
    required this.obscureText,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: TextField(
        obscureText: obscureText,
        controller: _textController,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.account_balance,
      size: 100,
      color: Color.fromRGBO(241, 75, 33, 1),
    );
  }
}

class AppLogoMain extends StatelessWidget {
  const AppLogoMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.mosque_sharp,
      size: 150,
      color: Color.fromRGBO(241, 75, 33, 1),
    );
  }
}

class AppLogo_Forgot extends StatelessWidget {
  const AppLogo_Forgot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 2.0,
      child: const Icon(
        Icons.question_mark_outlined,
        size: 100,
        color: Color.fromRGBO(241, 75, 33, 1),
      ),
    );
  }
}

class CustomAvartar1 extends StatelessWidget {
  const CustomAvartar1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.25),
      child: Container(
        width: 100,
        height: 100,
        child: Image.network(
          Profile().user.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  const CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.callback,
    required this.list,
    required this.valueName,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;

  final Function(int ouputId, String outputName) callback;
  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    outputId = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == "" ? "không có" : outputName,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200]),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Container(
                            width: widget.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              e.ten,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                ),
              ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputTextFromField extends StatefulWidget {
  const CustomInputTextFromField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
    this.type = TextInputType.text,
  });

  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function(String output) callback;
  @override
  State<CustomInputTextFromField> createState() =>
      _CustomInputTextFromFieldState();
}

class _CustomInputTextFromFieldState extends State<CustomInputTextFromField> {
  int status = 0;
  String output = "";

  @override
  void initState() {
    output = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.value == "" ? "không có" : widget.value,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      width: widget.width - 40,
                      child: TextFormField(
                        keyboardType: widget.type,
                        decoration: InputDecoration(border: InputBorder.none),
                        initialValue: output,
                        onChanged: (value) {
                          setState(() {
                            output = value;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          status = 0;
                          widget.callback(output);
                        });
                      },
                      child: Icon(
                        Icons.save,
                        size: 20,
                      ),
                    )
                  ],
                ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
