import 'dart:convert';
import 'dart:io';
import 'package:app_one/constants/MyColors.dart';
import 'package:app_one/constants/CTheme.dart';
import 'package:app_one/constants/localization.dart';
import 'package:app_one/globals/globals.dart';
import 'package:app_one/model/response/cities.dart';
import 'package:app_one/model/response/countries.dart';
import 'package:app_one/model/response/interests.dart';
import 'package:app_one/routes/baseView/base_view.dart';
import 'package:app_one/utils/base_view/base_view.dart';
import 'package:app_one/utils/image_picker/image_picker.dart';
import 'package:app_one/utils/locations/get_locations.dart';
import 'package:app_one/viewmodel/create_user_buisness_account.dart';
import 'package:app_one/viewmodel/create_user_social_account.dart';
import 'package:app_one/viewmodel/create_user_vmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_one/model/response/countrymodel_kazim.dart';

class EditBuisnessProfile extends StatefulWidget {
  @override
  _EditBusinessProfileScreenState createState() =>
      _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBuisnessProfile> {
  var radioValue;
  TextEditingController textControllerBN = TextEditingController();
  List<String> listOfCountries = [];
  PickedFile imageFile;
  TextEditingController businessNameTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();
  TextEditingController businessWebsiteTC = TextEditingController();
  TextEditingController aboutTC = TextEditingController();
  List<String> listOfCities = new List();
  List previousSelectedCat = new List();
  String selectedCountryHint;
  String selectedCityHint;
  String _valueCity = "38028-Alberton";
  String countryId = "202";
  String cityId = "38028";
  String _valueCountry = "South Africa";
  Map<String, dynamic> userBuisnessData;
  var _valueProfileType = "public";
  String prefUserId = "";
  String prefEmail = "";
  List<dynamic> listIntrests = List();
  List<Map<String, String>> listMap = new List();
  List<Map<String, String>> selectedInterestsList = new List();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _lineAddress = "";
  String imageApiUrl = "";

  List removedItems = new List();

  @override
  void initState() {
    super.initState();
    print("edit_buisness");

    getIntresetsAndData();
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
          _valueCountry = 'South Africa';
          _valueCity = '38028-Alberton';
        });
      },
      builder: (context, model, child) =>
          createBusinessProfileView(context, model),
    );
  }

  void populateCountryListForDropdown(List<CountryKazim> countryData) {
    for (int index = 0; index < countryData.length; index++) {
      listOfCountries
          .add("${countryData[index].id}-${countryData[index].name}");
      print(listOfCountries.length);
    }
  }

  Scaffold createBusinessProfileView(
      BuildContext context, CreateUserViewModel model) {
    return Scaffold(
        backgroundColor: MyColors.appBlue,
        body: BaseScrollView().baseView(context, [
          Padding(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15, bottom: 30),
            child: profileItem(() async {
              imageFile = await PickImageController.instance.picker
                  .getImage(source: ImageSource.gallery, imageQuality: 30);
              if (imageFile != null) {
                print("${File(imageFile.path).lengthSync() * 0.001} Kb");
                setState(() {
                  imageFile;
                });
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
            child: plainTextField(
                Localization.stLocalized('businessName'), businessNameTC),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
            child: plainTextFieldEmail(
                Localization.stLocalized('emailUsed'), emailTC),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
            child: plainTextField(
                Localization.stLocalized('businessWebsite'), businessWebsiteTC),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 35, right: 35),
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
                          print("**countryId===> " +
                              _valueCountry.substring(0, value.indexOf('-')));
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
                  padding: const EdgeInsets.only(top: 30, left: 35, right: 35),
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
                                print("**cityId==>" + cityId);
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
                  height: 10,
                  width: 10,
                ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              Localization.stLocalized('aboutMe'),
              style: CTheme.textRegular21White(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50, right: 50),
            child: whiteMultilineTextField(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              Localization.stLocalized('profileType'),
              style: CTheme.textRegular21White(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Stack(
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: MyColors.colorLogoOrange,
                        ),
                        child: RadioListTile(
                          activeColor: MyColors.colorLogoOrange,
                          groupValue: _valueProfileType,
                          value: "public",
                          onChanged: (value) => {
                            setState(() {
                              _valueProfileType = value;
                            })
                          },
                          title: Text(
                            "Public",
                            style: CTheme.textRegular16White(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: MyColors.colorLogoOrange),
                        child: RadioListTile(
                          activeColor: MyColors.colorLogoOrange,
                          groupValue: _valueProfileType,
                          value: "private",
                          onChanged: (value) => {
                            setState(() {
                              _valueProfileType = value;
                            })
                          },
                          title: Text(
                            "Private",
                            style: CTheme.textRegular16White(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              Localization.stLocalized('selectInterests'),
              style: CTheme.textRegular21White(),
            ),
          ),
          listIntrests.length != 0
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 40, right: 40, bottom: 30),
                  child: Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new MultiSelect(
                            autovalidate: true,
                            dataSource: listMap,
                            initialValue: previousSelectedCat,
                            textField: 'name',
                            valueField: 'id',
                            titleText: 'Select Your Interests ',
                            hintText:
                                "Please select interests (Min: 2 and Max: 8)",
                            maxLength: 8,
                            // optional
                            validator: (dynamic value) {
                              if (value == null) {
                                return 'Please select at least 2 interests';
                              }
                              return null;
                            },
                            filterable: true,
                            required: true,
                            onSaved: (value) {
                              if (value != null) {
                                selectedInterestsList = new List();
                                for (int index = 0;
                                    index < value.length;
                                    index++) {
                                  Map<String, String> selectedDataToMap = {
                                    'id': value[index]
                                  };
                                  selectedInterestsList.add(selectedDataToMap);
                                }
                                print(selectedInterestsList.length);
                              }
                            },
                            selectIcon: Icons.add,
                            saveButtonColor: MyColors.colorLogoOrange,
                            checkBoxColor: MyColors.colorLogoOrange,
                            cancelButtonColor: MyColors.colorLogoOrange,
                            cancelButtonTextColor: MyColors.colorWhite,
                            //  searchBoxColor: MyColors.colorLogoOrange,
                            selectIconColor: MyColors.colorWhite,
                            clearButtonColor: Color(0xFF242A37),
                            maxLengthText: "",
                            maxLengthIndicatorColor: MyColors.colorLogoOrange,
                            clearButtonTextColor: Colors.white,
                            titleTextColor: MyColors.colorLogoOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Text("loading"),
          Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 50, right: 50, bottom: 30),
            child: roundedSquareButton(
                Localization.stLocalized('updateBusinessProfile'), 50,
                () async {
              if (validateFields()) {
                userBuisnessData = {
                  "user_id": prefUserId.toString(),
                  "country_id": countryId,
                  "city_id": cityId,
                  "profile_name": businessNameTC.text,
                  "profile_email": emailTC.text,
                  "profile_phone": "",
                  "profile_address": _lineAddress.toString(),
                  "profile_website": businessWebsiteTC.text.toString(),
                  "profile_about": aboutTC.text.toString(),
                  "profile_type": "business",
                  "profile_status": _valueProfileType,
                  "about": aboutTC.text.toString(),
                  "interest": selectedInterestsList,
                  "removedItems": removedItems
                };

                if (imageFile != null) {
                  userBuisnessData['profile_image'] =
                      await convertImageToBase64(imageFile);
                }


                editBusinessAccount(userBuisnessData);
              }
            }),
          )
        ]));
  }

  Future<String> convertImageToBase64(imageFile) async {
    var headerString = 'data:image/png;base64,';
    File image = new File(imageFile.path);
    List<int> imageBytes = await image.readAsBytesSync();
    String base64Image = await base64.encode(imageBytes);
    var encodedImage = "$headerString$base64Image";
    print("Base64 Image Content: $encodedImage");
    return encodedImage;
  }

  void getCitiesByCountryId(CreateUserViewModel model, String countryId) async {
    CTheme.showCircularProgressDialog(context);
    await model.getCities(countryId);
    if (model.citySuccess) {
      print("Successful");
      populateCityListForDropdown(model.cityData);
      setState(() {
        listOfCountries;
      });
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      print("Error");
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
    print(listOfCities);
  }

  Widget profileItem(Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            color: MyColors.appBlue,
            elevation: 8,
            shadowColor: MyColors.appBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: imageFile == null
                      ? Container(
                          height: 140,
                          width: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.colorWhite,
                              border: Border.all(
                                  color: MyColors.colorLogoOrange, width: 6)),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              imageUrl: imageApiUrl,
                            ),
                          ),
                        )
                      : Container(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75)),
                              child: Image.file(
                                File(imageFile.path),
                                fit: BoxFit.cover,
                              ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 85, right: 85, bottom: 20),
                  child: roundedSquareButton(
                      Localization.stLocalized('uploadImage'), 30, onTap),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container whiteMultilineTextField() {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.colorWhite, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: aboutTC,
          maxLines: 4,
          style: CTheme.textRegular16Black(),
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            fillColor: MyColors.colorWhite,
          ),
        ),
      ),
    );
  }

  Widget profileTypeBox(
      String headingText, String subText, String btnText, Function onTap) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.appBlue,
        border: Border(
          left: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          right: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          bottom: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
          top: BorderSide(
            color: MyColors.colorLogoOrange,
            width: 5,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              headingText,
              style: CTheme.textRegular26LogoOrange(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 0.5,
              width: 200,
              color: MyColors.colorLogoOrange,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 75, right: 75),
            child: Text(
              subText,
              style: CTheme.textRegular11WhiteItalic(),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 40, right: 40, bottom: 25),
              child: Row(
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
              ))
        ],
      ),
    );
  }

  Widget roundedSquareButton(String btnText, double height, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              height: height,
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

  TextField plainTextField(
      String hintText, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
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
      ),
    );
  }

  TextField plainTextFieldEmail(
      String hintText, TextEditingController textEditingController) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: textEditingController,
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
      ),
    );
  }

  bool validateFields() {
    var isValidated = false;
    _onFormSaved();
    /*   if (imageFile == null) {
      CTheme.showAppAlertOneButton(
          context: context,
          title: 'Select Image',
          bodyText: 'Please select profile image',
          btnTitle: 'Okay');
    } else*/
    if (businessNameTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Field Empty',
        bodyText: 'Please specify profile name',
      );
    } else if (emailTC.text.trim().length == 0) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Select Profile Type',
        bodyText: 'Please enter business email',
      );
    } else if (!EmailValidator.validate(emailTC.text.trim())) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Email Error',
        bodyText: 'Please enter valid email',
      );
    } else if (businessWebsiteTC.text.isEmpty) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Website Error',
        bodyText: 'Please enter valid website',
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
    } else if (aboutTC.text == "") {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Field Empty',
        bodyText: 'Please specify about us',
      );
    }

    ///Hard Coded for testing.
    else if (selectedInterestsList.length < 2) {
      CTheme.showAppAlertOneButton(
        "Okay",
        context: context,
        title: 'Error',
        bodyText: 'Please select at least 2 interests',
      );
    } else {
      isValidated = true;

      for (int index = 0; index < previousSelectedCat.length; index++) {
        if (!selectedInterestsList.contains(previousSelectedCat[index])) {
          print(previousSelectedCat[index].toString() + "k");
          removedItems.add(previousSelectedCat[index]);
          print(removedItems.toString());
        } else {
          print(removedItems.toString());
        }
      }
    }
    return isValidated;
  }

  void _onFormSaved() {
    final FormState form = _formKey.currentState;
    form.save();
  }

  getIntresetsAndData() async {
    CreateUserViewModel model = new CreateUserViewModel();
    CTheme.showCircularProgressDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefUserId = prefs.getString(Globals.userId.toString());
    prefEmail = prefs.getString(Globals.emailId.toString());
    GetUserLocations getUserLocations = new GetUserLocations();
    getUserLocations.getLocation();
    setState(() {
      _lineAddress = prefs.getString(Globals.addressLine);
    });
    await model.GetBusinessProfileDetils();
    if (model.getSocialSuccess) {
      prefs.setString(Globals.urlImageSocial,
          model.specificProfileDetails.data.profileImage.toString());
      setState(() {
        businessNameTC.text = model.specificProfileDetails.data.profileName;
        businessWebsiteTC.text =
            model.specificProfileDetails.data.profileWebsite;
        emailTC.text =
            model.specificProfileDetails.data.profileEmail.toString();
        aboutTC.text =
            model.specificProfileDetails.data.profileAbout.toString();
        _valueProfileType =
            model.specificProfileDetails.data.profileStatus.toString();
        cityId = model.specificProfileDetails.data.cityId.toString();
        _valueCity = model.specificProfileDetails.data.cityName.toString();
        countryId = model.specificProfileDetails.data.countryId.toString();
        _valueCountry = model.specificProfileDetails.data.countryName;
        imageApiUrl = model.specificProfileDetails.data.profileImage.toString();
        print("_valueProfileType==> " +
            model.specificProfileDetails.data.profileStatus);
        print("profileWebsite==> " +
            model.specificProfileDetails.data.profileWebsite);
        previousSelectedCat = new List();
        for (int index = 0;
            index < model.specificProfileDetails.data.category.length;
            index++) {
          previousSelectedCat.add(model
              .specificProfileDetails.data.category[index].categoryId
              .toString());

          print("selectedDataToMap===> " + previousSelectedCat.toString());
        }
      });
    }

    await model.getIntrests();
    if (model.intrestsSuccess) {
      setState(() {
        print(model.intrestsData.data.category.length);
        listIntrests = model.intrestsData.data.category;
        for (int index = 0;
            index < model.intrestsData.data.category.length;
            index++) {
          print(model.intrestsData.data.category[index].name);
          Map<String, String> dataMap = {
            'name': model.intrestsData.data.category[index].name,
            'id': model.intrestsData.data.category[index].id.toString(),
          };
          listMap.add(dataMap);
        }
      });
      Navigator.pop(context);
      return listIntrests;
    } else {
      Navigator.pop(context);
      print("Error");
    }
  }

  Future<String> createBusinessAccountFirebase(
      {String email, File userImageFile}) async {
    var signUpSuccess;
    try {
      {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final User user = auth.currentUser;
        final uid = user.uid;

        userImageFile != null
            ? await FirebaseStorage()
                .ref()
                .child('userBuisnessAccount/${uid}/')
                .putFile(userImageFile)
                .onComplete
                .then((storageValue) async {
                await FirebaseFirestore.instance
                    .collection('userBuisnessAccount')
                    .doc(uid)
                    .collection("1")
                    .add({
                      'userId': uid,
                      'fcmToken': await getToken(),
                      'createdAt': FieldValue.serverTimestamp(),
                      'name': email.substring(0, email.indexOf('@')),
                      'email': email,
                      "country_id": countryId,
                      "city_id": cityId,
                      "profile_name": businessNameTC.text.toString(),
                      "profile_email": email,
                      "profile_phone": "",
                      "profile_address": _lineAddress,
                      "profile_website": "",
                      "profile_about": aboutTC.text.toString(),
                      "profile_type": "business",
                      "profile_status": _valueProfileType,
                      "about": aboutTC.text.toString(),
                      'userImageUrl': userImageFile != null
                          ? await storageValue.ref.getDownloadURL()
                          : "",
                    })
                    .whenComplete(() => {signUpSuccess = 'Successful'})
                    .catchError((error) => {
                          error = error.toString().substring(
                              error.toString().indexOf(']') + 1,
                              error.toString().length - 1),
                          signUpSuccess = error
                        });
              }).catchError((error) => {
                      error = error.toString().substring(
                          error.toString().indexOf(']') + 1,
                          error.toString().length - 1),
                      signUpSuccess = error
                    })
            : await FirebaseFirestore.instance
                .collection('userBuisnessAccount')
                .doc(uid)
                .collection("BuisnessAccount")
                .add({
                  'userId': uid,
                  'fcmToken': await getToken(),
                  'createdAt': FieldValue.serverTimestamp(),
                  'name': email.substring(0, email.indexOf('@')),
                  'email': email,
                  "country_id": countryId,
                  "city_id": cityId,
                  "profile_name": businessNameTC.text.toString(),
                  "profile_email": email,
                  "profile_phone": "",
                  "profile_address": _lineAddress,
                  "profile_website": businessWebsiteTC.text.toString(),
                  "profile_about": aboutTC.text.toString(),
                  "profile_type": "business",
                  "profile_status": _valueProfileType,
                  "about": aboutTC.text.toString(),
                })
                .whenComplete(() => {signUpSuccess = 'Successful'})
                .catchError((error) => {
                      error = error.toString().substring(
                          error.toString().indexOf(']') + 1,
                          error.toString().length - 1),
                      signUpSuccess = error
                    });
      }
    } catch (error) {
      print(error);
    }
    return signUpSuccess;
  }

  editBusinessAccount(parameterMap) async {
    CTheme.showCircularProgressDialog(context);
    CreateBuisnessAccountViewModel model = new CreateBuisnessAccountViewModel();
    await model.editBuisnessAccount(parameterMap);
    print(model.editBussinessData.data.toString());
    if (model.editBussinessSuccess) {
      Navigator.pop(context);
      print("Successful");
      print(model.editBussinessData.data.toString());
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Business Account Updated',
          bodyText: "Your Business Account Updated Successfully",
          handler2: (action) =>
              {Navigator.pushReplacementNamed(context, '/profile_home')});
    } else {
      Navigator.pop(context);
      print("Error Updated Business Profile");
      CTheme.showAppAlertOneButton("Okay",
          context: context,
          title: 'Error Updated Business Profile',
          bodyText: "Error Updated Business Profile.");
    }
  }

  Future<String> getToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String tokenResult;
    await _firebaseMessaging
        .getToken()
        .then((value) => {
              print('Token For User Is: ' + value),
              tokenResult = value,
            })
        .catchError((error) => {
              print('Get Token Error is : ${error.toString()}'),
              tokenResult = 'Failed'
            });
    return tokenResult;
  }
}

//overridden class to customize chips
class _Chip extends StatelessWidget {
  const _Chip({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: MyColors.colorLogoOrange,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 15,
        color: MyColors.colorWhite,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
