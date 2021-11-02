import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/data/drop_down_menu.dart';

Widget textInputField({
  @required TextEditingController controller,
  @required TextInputType type,
  double size,
  Function onSubmit,
  Function onChange,
  Function onTap,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: AppColor.iconsColor,
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        cursorColor: Colors.amberAccent,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );

Widget buildPhoneFormField(
    DropDwonItem seletedItem, TextEditingController textEditingController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
          flex: 4,
          child: Container(
            height: 55,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.iconsColor,
                width: 2,
              ),
            ),
            child: showDrobDownButton(seletedItem),
          )),
      SizedBox(
        width: 10,
      ),
      Expanded(
          flex: 7,
          child: textInputField(
              controller: textEditingController,
              type: TextInputType.phone,
              validate: (_) {},
              label: "enter phone number",
              prefix: Icons.phone_android_rounded))
    ],
  );
}

// show custom DrobDownButtonr..
Widget showDrobDownButton(DropDwonItem seletedItem) {
  return DropdownButton(
      hint: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/egypt.png",
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "+20",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      value: seletedItem,
      items: dropDwonItems.map((item) {
        return DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Image.asset(
                item.imagePath,
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                item.name,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          value: item,
        );
      }).toList(),
      onChanged: (value) {});
}
