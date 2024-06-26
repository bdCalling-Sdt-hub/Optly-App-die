import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optly/utils/app_colors.dart';

import '../../../../controller/profile_controller.dart';
import '../../../../helpers/data.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});
  final _profileController = Get.put(ProfileController());

  final List<String> materialStatusList = [
    "ledig",
    "verheiratet",
    "geschieden",
    "verwitet",
    "dauernd getrennt lebend",
    "Lebenspartnerschaft eingetragen",
    "Lebenspartnerschaft aufgehoben"
  ];

  final List<String> genderList = ["Mannlich", "Weiblich"];
  final List<String> severelyDisabled = ["Ja", "Nein"];

  var selectMaterialStatus;
  var selectGender;
  var selectCountry;

  @override
  Widget build(BuildContext context) {
    var data = _profileController.profileData.value.data!.info!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField(initialValue:data.lastname??"",labelText: "family_name", isValidator: true),
        buildTextField(initialValue:data.firstname??"",labelText: "first_name", isValidator: true),
        buildTextField(initialValue:data.street??"",labelText: "street", isValidator: true),
        buildTextField(initialValue:data.houseno??"",labelText: "house_number", isValidator: true),
        buildTextField(initialValue:data.zip.toString(),labelText: "post_code", isValidator: true),
        buildTextField(initialValue:data.city??"",labelText: "city", isValidator: true),
        buildTextField(initialValue:data.email??"",labelText: "email", isValidator: true),
        buildTextField(initialValue:data.phone??"",labelText: "phone", isValidator: true),
        SizedBox(
          height: 5.h,
        ),

        /// add marital status
        DropdownButtonFormField<String>(
          value: selectMaterialStatus,
          onChanged: (String? value) {},
          items: materialStatusList.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "marital_status".tr,
              labelStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),
        SizedBox(
          height: 5.h,
        ),

        buildTextField(labelText: "password", isValidator: true),
        buildTextField(labelText: "repeat_password", isValidator: true),

        /// add dob
        ///
        ///
        SizedBox(
          height: 10.h,
        ),
        Text(
          "birthday".tr,
          style: TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: buildTextField(
                initialValue: data.day,
                  labelText: "Tag*/TT",
                  isOutlineBorder: true,
                isValidator: true,
                  textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],

              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                flex: 3,
                child: buildTextField(
                  initialValue: data.month,
                    labelText: "Monat*/MM",
                    isOutlineBorder: true,
                    isValidator: true,
                    textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],)),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                flex: 5,
                child: buildTextField(
                  initialValue: data.year,
                    labelText: "Jahr*/JJJJ",
                    isOutlineBorder: true,
                  isValidator: true,
                    textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],)),
          ],
        ),

        ///
        /// add gender
        ///
        SizedBox(
          height: 5.h,
        ),
        DropdownButtonFormField<String>(
          value: selectGender,
          onChanged: (String? value) {},
          items: genderList.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "gender".tr,
              labelStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),
        SizedBox(
          height: 5.h,
        ),

        ///
        ///
        buildTextField(initialValue: data.versicherungsnummer??"",
            labelText: "social_security_number-according", isValidator: true),

        ///<----------- add severely disabled ---->
        SizedBox(
          height: 5.h,
        ),
        DropdownButtonFormField<String>(
          value: selectCountry,
          isExpanded: true,
          menuMaxHeight: 300,
          onChanged: (String? value) {},
          items: countriesGerman.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
              labelText: "country_of_birth".tr,
              labelStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyColor))),
        ),
        SizedBox(
          height: 5.h,
        ),

        ///<----------- add severely disabled  close---->
        buildTextField(
          initialValue: data.birthplace??"",
          labelText: "place_of_birth",
        ),
        buildTextField(
          initialValue: data.birthcountry??"",
          labelText: "nationality",
        ),
        buildTextField(
          labelText: "ware_going",
          initialValue: data.iban??""
        ),
        buildTextField(
          initialValue: data.bic??"",
          labelText: "bic",
        ),
      ],
    );
  }


}

buildTextField(
    {String? labelText,
      bool isValidator = false,
      TextEditingController? controller,
      TextInputType? textInputType,
      bool obscureText = false,
      bool isOutlineBorder = false,
      List<TextInputFormatter>? inputFormatters,
      String? initialValue}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: textInputType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      validator: isValidator
          ? (v) {
        if (v!.isEmpty) {
          return "This field is required.".tr;
        }
        return null;
      }
          : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: labelText!.tr,
          labelStyle: TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
          errorBorder: isOutlineBorder ? errorOutlineInputBorder() : null,
          focusedErrorBorder: isOutlineBorder ? errorOutlineInputBorder() : null,
          focusedBorder: isOutlineBorder ? focusOutlineInputBorder() : null,
          enabledBorder: isOutlineBorder
              ? enableOutlineInputBorder()
              : UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyColor))),
    ),
  );
}
enableOutlineInputBorder() {
  return OutlineInputBorder(borderSide: BorderSide(color: AppColors.greyColor));
}

disableOutlineInputBorder() {
  return OutlineInputBorder(borderSide: BorderSide(color: AppColors.greyColor));
}

focusOutlineInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor));
}

errorOutlineInputBorder() {
  return const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
}
