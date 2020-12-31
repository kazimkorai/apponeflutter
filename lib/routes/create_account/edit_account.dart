import 'dart:async';
import 'dart:io';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/cities.dart';
import 'package:app_one/model/response/countries.dart';
import 'package:app_one/model/response/countrymodel_kazim.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/viewmodel/create_user_vmodel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccount> {
  var isTermConditionsChecked = false;
  String _valueGender="";
  TextEditingController firstNameTC = TextEditingController();
  TextEditingController lastNameTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  DateTime _valueInDTO;
  List<String> listOfCities = [];
  List<String> listOfCountries = [];

  String _valueDOB = "Date Of Birth";
  bool _passwordVisible;
  bool _confirmPasswordVisible;
  Map<String, dynamic> userRegistrationData;
  String _valueCity = "38028-Alberton";
  String countryId = "202";
  String cityId = "38028";
  String _valueCountry = "South Africa";
  String selectedCountryHint;
  String selectedCityHint;

  SharedPreferences preferences;

  setPrefrence() async
  {
    preferences =await SharedPreferences.getInstance();
    setState(() {
      firstNameTC.text=preferences.getString(Globals.userName);
      _valueDOB=preferences.getString(Globals.dateOfBirth);
      emailTC.text=preferences.getString(Globals.emailId.toString());
      countryId=preferences.getString(Globals.countryId.toString());
      cityId=preferences.getString(Globals.cityId);
      _valueGender=preferences.getString(Globals.gender);
      print(preferences.getString(Globals.dateOfBirth));
   print(   _valueDOB.substring(0,10));
    });

  }

  @override
  void initState() {
    _passwordVisible = true;
    _confirmPasswordVisible = true;
    super.initState();
    print('EditAccount');
    setPrefrence();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<CreateUserViewModel>(
      onModelReady: (model) async {
        await model.getCountries();
        print("Successful");
        populateCountryListForDropdown(model.listCountries);
        setState(() {
          listOfCountries;

        });
        await getCitiesByCountryId(model, '202');
        setState(() {
          listOfCountries;
          _valueCountry = 'South Africa';
          _valueCity = '38028-Alberton';
        });
      },
      builder: (context, model, child) => createAccountView(context, model),
    );
  }

  Scaffold createAccountView(BuildContext context, CreateUserViewModel model) {
    return Scaffold(
        backgroundColor: MyColors.appBlue,
        body: BaseScrollView().baseView(context, [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40),
            child: plainTextField(Localization.stLocalized('firstName'),
                controller: firstNameTC,
                showHideIcon: false,
                obscureText: false),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextField(Localization.stLocalized('lastName'),
                controller: lastNameTC,
                showHideIcon: false,
                obscureText: false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Theme(
                  data:
                      Theme.of(context).copyWith(canvasColor: MyColors.appBlue),
                  child: ButtonTheme(
                    child: DropdownButton<String>(
                      underline: Container(
                        color: MyColors.colorWhite,
                        height: 1,
                      ),
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      hint: Text(
                        _valueGender==null?"Gender":_valueGender,
                        style: CTheme.textRegular18White(),
                        textAlign: TextAlign.start,
                      ),
                      isExpanded: true,
                      items: dropDownMenuItems(),
                      onTap: () => FocusScope.of(context).unfocus(),
                      onChanged: (value) {
                        setState(() {
                          _valueGender = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: GestureDetector(
              onTap: () =>
                  {FocusScope.of(context).unfocus(), dateTimePicker(context)},
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: MyColors.appBlue,
                    border:
                        Border(bottom: BorderSide(color: MyColors.colorWhite))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        _valueDOB,
                        style: CTheme.textRegular18White(),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: MyColors.colorWhite,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextFieldEmail(Localization.stLocalized('emailAddress'),
                controller: emailTC, showHideIcon: false, obscureText: false),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Theme(
                  data:
                      Theme.of(context).copyWith(canvasColor: MyColors.appBlue),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                        ),
                      ),
                      underline: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          color: MyColors.colorWhite,
                          height: 1,
                        ),
                      ),
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      hint: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _valueCountry,
                              style: CTheme.textRegular18White(),
                            ),
                          ),
                        ],
                      ),
                      isExpanded: true,
                      items: listOfCountries
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.substring(
                                value.indexOf("-") + 1, value.length),
                            style: CTheme.textRegular18White(),
                            textAlign: TextAlign.start,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        //Todo:Kazim Here for drop down
                        listOfCities.clear();
                        getCitiesByCountryId(
                            model, value.substring(0, value.indexOf('-')));
                        setState(() {
                          selectedCountryHint = value;
                          _valueCountry = value;
                          countryId =
                              _valueCountry.substring(0, value.indexOf('-'));

                          _valueCity = "Select City";
                        });
                      },
                      value:
                          selectedCountryHint == "" ? "" : selectedCountryHint,
                    ),
                  ),
                ),
              ),
            ),
          ),
          listOfCities.length > 0
              ? Padding(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Container(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: MyColors.appBlue),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 25,
                              ),
                            ),
                            underline: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                color: MyColors.colorWhite,
                                height: 1,
                              ),
                            ),
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.white,
                            hint: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _valueCity.substring(
                                        _valueCity.indexOf("-") + 1,
                                        _valueCity.length),
                                    style: CTheme.textRegular18White(),
                                  ),
                                ),
                              ],
                            ),
                            isExpanded: true,
                            items: listOfCities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value.substring(
                                      value.indexOf("-") + 1, value.length),
                                  style: CTheme.textRegular18White(),
                                  textAlign: TextAlign.start,
                                ),
                              );
                            }).toList(),
                            onTap: () => FocusScope.of(context).unfocus(),
                            onChanged: (value) {
                              setState(() {
                                selectedCityHint = value;
                                _valueCity = value;
                                cityId =
                                    _valueCity.substring(0, value.indexOf('-'));

                              });
                            },
                            /* value: (selectedCityHint  == "" || selectedCityHint ==
                            selectedCountryHint)? "":selectedCityHint,*/
                            // value: _valueCity,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
            margin: EdgeInsets.only(top: 10),
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  height: 50,
                ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextField(Localization.stLocalized('createPassword'),
                controller: passwordTC,
                showHideIcon: true,
                obscureText: true,
                passwordVisibility: _passwordVisible),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: plainTextField(Localization.stLocalized('confirmPassword'),
                controller: confirmPasswordTC,
                showHideIcon: true,
                obscureText: true,
                passwordVisibility: _confirmPasswordVisible),
          ),
         /* Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 30),
            child: acceptAgreementRow(),
          ),*/
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 35),
            child: roundedSquareButton(
                Localization.stLocalized('editAccount'),
                () => {
                      if (validateFields())
                        {
                          /*  Navigator.pushNamed(context, '/create_social_profile',
                              arguments: {
                                "name": firstNameTC.text.trim(),
                                "gender": _valueGender,
                                "date_of_birth": _valueDOB,
                                "device_type":
                                    Platform.isIOS ? "Ios" : "Android",
                                "device_token": "TBD",
                                "email": emailTC.text.trim(),
                                "country_id": _valueCountry.substring(
                                    0, _valueCountry.indexOf('-')),
                                "city_id": _valueCity.substring(
                                    0, _valueCity.indexOf('-')),
                                "password": passwordTC.text.trim(),
                                "phone": "",
                                "address": "",
                                "about": "",
                                "profile_name": "",
                                "profile_email": emailTC.text.trim(),
                                "profile_phone": "",
                                "profile_address": "",
                                "profile_website": "",
                                "profile_about": "",
                                "profile_type": "",
                                "profile_status": "",
                                "interest": []
                              })*/
                        }
                    }),
          ),
        ]));
  }

/*  Stack acceptAgreementRow() {
    return Stack(
      children: [
        SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Localization.stLocalized('iAccept'),
                style: CTheme.textRegular14White(),
              ),
              GestureDetector(
                onTap: () => {
                  CTheme.showAppAlertOneButton(
                      context: context,
                      title: "Terms and Conditions",
                      bodyText: "Help protect your website and its users "
                          "with clear and fair website terms and conditions."
                          " These terms and conditions for a website set out"
                          " key issues such as acceptable use, privacy,"
                          " cookies, registration and passwords,"
                          " intellectual property, links to other"
                          " sites, termination and disclaimers of"
                          " responsibility. Terms and conditions "
                          "are used and necessary to protect a website"
                          "owner from liability of a user relying on the "
                          "information or the goods provided from the site "
                          "then suffering a loss.\n\nMaking your own terms and "
                          "conditions for your website is hard, not "
                          "impossible, to do. It can take a few hours to "
                          "few days for a person with no legal background "
                          "to make. But worry no more; we are here to help "
                          "you out.\n\nAll you need to do is fill up the blank "
                          "spaces and then you will receive an email with "
                          "your personalized terms and conditions.")
                },
                child: Text(
                  Localization.stLocalized('termAndCondition'),
                  style: CTheme.textRegular14Blue(),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: MyColors.colorWhite,
              ),
              child: SizedBox(
                height: 35,
                width: 35,
                child: Checkbox(
                  activeColor: Colors.white,
                  value: isTermConditionsChecked,
                  onChanged: (value) {
                    FocusScope.of(context).unfocus();
                    termsConditionsCb(value);
                  },
                  checkColor: Colors.black, // color of tick Mark
                ),
              ),
            ),
          ],
        )
      ],
    );
  }*/

  TextField plainTextField(String hintText, {TextEditingController controller,
      bool obscureText,
      bool showHideIcon,
      bool passwordVisibility}) {
    return TextField(

      controller: controller,
      style: CTheme.textRegular18White(),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        hintText: hintText,
        hintStyle: CTheme.textRegular18White(),
        suffixIcon: showHideIcon
            ? IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisibility ? Icons.visibility_off : Icons.visibility,
                  color: MyColors.colorLogoOrange,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisibility = !passwordVisibility;
                    _passwordVisible = passwordVisibility;
                    _confirmPasswordVisible = passwordVisibility;
                  });
                },
              )
            : Container(width: 1),
      ),
      obscureText: obscureText ? passwordVisibility : false,
    );
  }



  TextField plainTextFieldEmail(String hintText, {TextEditingController controller,
    bool obscureText,
    bool showHideIcon,
    bool passwordVisibility}) {
    return TextField(
      enabled: false,
      controller: controller,
      style: CTheme.textRegular18White(),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.colorWhite),
        ),
        hintText: hintText,
        hintStyle: CTheme.textRegular18White(),
        suffixIcon: showHideIcon
            ? IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisibility ? Icons.visibility_off : Icons.visibility,
            color: MyColors.colorLogoOrange,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              passwordVisibility = !passwordVisibility;
              _passwordVisible = passwordVisibility;
              _confirmPasswordVisible = passwordVisibility;
            });
          },
        )
            : Container(width: 1),
      ),
      obscureText: obscureText ? passwordVisibility : false,
    );
  }
  Widget roundedSquareButton(String btnText, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: (BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF242A37), Color(0xFF4E586E)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
              )),
              child: Text(
                btnText,
                style: CTheme.textRegularBold14White(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> dropDownMenuItems() {
    return [
      DropdownMenuItem(
        value: "Male",
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                "Male",
                style: CTheme.textRegular18White(),
              ),
            ),
          ],
        ),
      ),
      DropdownMenuItem(
        value: "Female",
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                "Female",
                style: CTheme.textRegular18White(),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  void termsConditionsCb(bool value) {
    if (isTermConditionsChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isTermConditionsChecked = true;
      });
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context,
          title: "Terms And Agreement",
          bodyText: "I accept the terms and agreements",
);
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isTermConditionsChecked = false;
      });
    }
  }

  bool validateFields() {
    var isValidated = false;
    if (firstNameTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context,
          title: 'Field Empty',
          bodyText: 'Please enter first name',
);
    } else if (_valueGender == null) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Field Empty',
          bodyText: 'Please select gender',
     );
    } else if (_valueDOB == 'Date Of Birth') {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Date Of Birth Missing',
          bodyText: 'Please select date of birth',
);
    } else if (_valueInDTO.isSameOrGreaterThanDate(DateTime.now())) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Date Of Birth Error',
          bodyText: 'Date of birth cannot be current date or greater',
  );
    } else if (emailTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Field Empty',
          bodyText: 'Please enter email',
);
    } else if (!EmailValidator.validate(emailTC.text.trim())) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Email Error',
          bodyText: 'Please enter valid email',
);
    } else if (_valueCountry == null) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Select Country',
          bodyText: 'Please select a country',
);
    } else if (_valueCity == null) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Select City',
          bodyText: 'Please select a city',
);
    }
    else if (_valueCity == 'Select City') {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Select City',
          bodyText: 'Please select a city',
);
    }else if (passwordTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Field Empty',
          bodyText: 'Please enter password',
);
    } else if (passwordTC.text.length < 8) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Weak Password',
          bodyText: 'Please enter strong password',
);
    } else if (confirmPasswordTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Field Empty',
          bodyText: 'Please enter password again to confirm',
);
    } else if (passwordTC.text != confirmPasswordTC.text) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Unmatched Passwords',
          bodyText: 'Password confirmation failed',
);
    } else if (!isTermConditionsChecked) {
      CTheme.showAppAlertOneButton(
        "Okay",
          context: context,
          title: 'Terms And Conditions',
          bodyText: 'Accept terms and conditions',
);
    } else {
      isValidated = true;


      userRegistrationData = {
        "name": firstNameTC.text,
        "gender": _valueGender,
        "date_of_birth": _valueDOB,
        "device_type": "android",
        "device_token": "sdadadsdadasdasdadad",
        'email': emailTC.text.trim(),
        "country_id": countryId,
        "city_id": cityId,
        'password': passwordTC.text.trim(),
      };
     // CTheme.showCircularProgressDialog(context);
      CreateUserViewModel model = new CreateUserViewModel();
      print(userRegistrationData.toString());
    ///  changePasswordInFirebase(passwordTC.text.toString());





      //// bottom code died code
  /*    createUserInFirebase(userRegistrationData['email'],
          userRegistrationData['password'], model);*/
    }
    return isValidated;
  }

  ///kazim
  void changePasswordInFirebase(String password) async {
    User user = FirebaseAuth.instance.currentUser;
    print(user.email.toString());
    user.updatePassword(password).then((_) {
      print("Your password changed Succesfully ");

    }).catchError((err) {
      print("You can't change the Password" + err.toString());
    });
  }
  createUserInFirebase(email, password, CreateUserViewModel model) async {

    String signUpResult;

    ///Kazim todo:work here Image:issue;
    ///
    ///
    bool isImageSelect = false;
    if (isImageSelect) {
      signUpResult = await model.createUser(
        email: email,
        password: password,
      );
    } else {
      signUpResult = await model.createUser(
        email: email,
        password: password,
      );
    }
    if (signUpResult == 'Successful') {
      print(signUpResult);
      //// Todo: kazim here Your ServerApiCall
      registerUserInApi(model);
    } else {
      print(signUpResult);
      Navigator.pop(context);
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context, title: 'Error Signing Up', bodyText: signUpResult);
    }
  }

  registerUserInApi(CreateUserViewModel model) async {
    await model.registerUser(userRegistrationData);
    if (model.registerSuccess) {
      Navigator.pop(context);
      print("Successful");
      print(model.registrationData.data.email);
      await addValueToSharedPreference(model);
      CTheme.showAppAlertOneButton(
          "Continue",
          context: context,
          title: 'Account has been  Registered Successfully',
          bodyText: "Welcome to App One",

          handler2: (action) => {
                Navigator.pushReplacementNamed(
                    context, '/create_social_profile')
              });
    } else {
      Navigator.pop(context);
      print("Error Register User Api");
      CTheme.showAppAlertOneButton(
          "Okay",
          context: context,
          title: 'Error Signing Up',
          bodyText: "The was some error creating profile try later.");
    }
  }

  Future addValueToSharedPreference(CreateUserViewModel model) async {
    await SharedPreferences.getInstance().then((value) => {
          value.setString(
              Globals.userAuthToken, model.registrationData.data.token),
          value.setString(Globals.userName, model.registrationData.data.name),
          value.setString(Globals.profileId,
              model.registrationData.data.userProfileId.toString()),
          value.setString(
              Globals.userId, model.registrationData.data.userId.toString()),
          value.setString(Globals.profileType,
              model.registrationData.data.profileStatus.toString()),
          value.setString(Globals.profileStatus,
              model.registrationData.data.profileStatus.toString()),
          value.setString(
              Globals.emailId, model.registrationData.data.email.toString()),
          value.setString(Globals.countryId, countryId),
          value.setString(
            Globals.cityId, cityId),

        });
  }

  ///kazim
  Future dateTimePicker(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color.fromRGBO(70, 69, 69, 1),
              height: MediaQuery.of(context).copyWith().size.height / 2.5,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        height: 42,
                        decoration: BoxDecoration(
                          color: MyColors.colorDarkBlack,
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (_valueInDTO != null) {
                            String formattedDateLocal =
                                DateFormat('dd -MMM- yyyy').format(_valueInDTO);
                            _valueDOB = formattedDateLocal;
                          } else {
                            _valueInDTO = DateTime.parse("2019-01-01");
                            String formattedDate =
                                DateFormat('ddMMyyyy').format(_valueInDTO);
                            String formattedDateLocal =
                                DateFormat('dd -MMM- yyyy').format(_valueInDTO);
                            _valueDOB = formattedDateLocal;
                          }
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: CupertinoDatePicker(
                        minimumYear: 1800,
                        maximumYear: DateTime.now().year - 1,
                        initialDateTime: DateTime.parse('2019-01-01'),
                        backgroundColor: MyColors.colorWhite,
                        onDateTimeChanged: (DateTime dateTime) =>
                            {_valueInDTO = dateTime},
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void populateCountryListForDropdown(List<CountryKazim> countryData) {
    for (int index = 0; index < countryData.length; index++) {
      listOfCountries
          .add("${countryData[index].id}-${countryData[index].name}");

    }
  }

  void populateCityListForDropdown(Cities cityData) {
    listOfCities = [];
    cityData.data.forEach((element) {
      listOfCities.add("${element.id}-${element.name}");
    });
    listOfCities.sort((a, b) {
      return a
          .substring(a.indexOf("-") + 1)
          .toLowerCase()
          .compareTo(b.substring(b.indexOf("-") + 1).toLowerCase());
    });

  }

  void getCitiesByCountryId(CreateUserViewModel model, String countryId) async {
    CTheme.showCircularProgressDialog(context);
    await model.getCities(countryId);
    if (model.citySuccess) {
      print("Successful");
      populateCityListForDropdown(model.cityData);
      setState(() {
        listOfCities;
      });
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      print("Error");
    }
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameOrGreaterThanDate(DateTime other) {
    return this.year >= other.year &&
        this.month >= other.month &&
        this.day >= other.day;
  }
}
