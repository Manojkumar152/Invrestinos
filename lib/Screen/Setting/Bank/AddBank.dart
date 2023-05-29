import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:investions/Api/ApiCollections.dart';

import '../../../Api/ApiMain.dart';
import '../../../Api/CommonTextField.dart';
import '../../../Constant/ColorsCollection.dart';
import '../../../Constant/ToastClass.dart';

class AddNewBank extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddNewBank();
  }
}

class _AddNewBank extends State<AddNewBank> {
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _reenterController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _accTypeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _aliasFocus = FocusNode();
  final _accountFocus = FocusNode();
  final _reenterFocus = FocusNode();
  final _ifscFocus = FocusNode();
  final _accountTypeFocus = FocusNode();
  String isClicked="0";
  String? nationality;
  StateObj? stateobj;
  String? state;
  List<StateObj> stateList=[];
  List<String> country=[   'Afghanistan','Åland Islands',
    'Albania','Algeria','American Samoa', 'AndorrA' 'Angola', 'Anguilla', 'Antarctica','Antigua and Barbuda',
    'Argentina','Armenia', 'Aruba',  'Australia',  'Austria', 'Azerbaijan','Bahamas','Bahrain',
    'Bangladesh',  'Barbados','Belarus', 'Belgium',
    'Belize', 'Benin',  'Bermuda','Bhutan',  'Bolivia',  'Bosnia and Herzegovina', 'Botswana',
    'Bouvet Island',
    'Brazil',
    'British Indian Ocean Territory',
    'Brunei Darussalam',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cape Verde',
    'Cayman Islands',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Christmas Island',
    'Cocos (Keeling) Islands',
    'Colombia',
    'Comoros',
    'Congo',
    'Congo, The Democratic Republic of the',
    'Cook Islands',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Falkland Islands (Malvinas)',
    'Faroe Islands',
    'Fiji',
    'Finland',
    'France',
    'French Guiana',
    'French Polynesia',
    'French Southern Territories',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Gibraltar',
    'Greece',
    'Greenland',
    'Grenada',
    'Guadeloupe',
    'Guam',
    'Guatemala',
    'Guernsey',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Heard Island and Mcdonald Islands',
    'Holy See (Vatican City State)',
    'Honduras',
    'Hong Kong',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran, Islamic Republic Of',
    'Iraq',
    'Ireland',
    'Isle of Man',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jersey',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, Democratic People\'S Republic of',
    'Korea, Republic of',
    'Kuwait',
    'Kyrgyzstan',
    'Lao People\'S Democratic Republic',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libyan Arab Jamahiriya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macao',
    'Macedonia, The Former Yugoslav Republic of',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Martinique',
    'Mauritania',
    'Mauritius',
    'Mayotte',
    'Mexico',
    'Micronesia, Federated States of',
    'Moldova, Republic of',
    'Monaco',
    'Mongolia',
    'Montserrat',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'Netherlands Antilles',
    'New Caledonia',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Niue',
    'Norfolk Island',
    'Northern Mariana Islands',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestinian Territory, Occupied',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Pitcairn',
    'Poland',
    'Portugal',
    'Puerto Rico',
    'Qatar',
    'Reunion',
    'Romania',
    'Russian Federation',
    'RWANDA',
    'Saint Helena',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Pierre and Miquelon',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia and Montenegro',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Georgia and the South Sandwich Islands',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suri"name"',
    'Svalbard and Jan Mayen',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syrian Arab Republic',
    'Taiwan, Province of China',
    'Tajikistan',
    'Tanzania, United Republic of',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tokelau',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Turks and Caicos Islands',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'United States Minor Outlying Islands',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Venezuela',
    'Viet Nam',
    'Virgin Islands, British',
    'Virgin Islands, U.S.',
    'Wallis and Futuna',
    'Western Sahara',
    'Yemen',
    'Zambia',
    'Zimbabwe',];
  List<String> Accounttype=[
    "saving","current"
  ];
  String? account_type;
  bool validateStructure(String value){
    String  pattern = r'^[A-Za-z]{4}[a-zA-Z0-9]{7}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;

    // TODO: implement build
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height*0.3,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/dashboard_headerImage.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.1),
                          InkWell(
                            onTap:(){
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.arrow_back,color: Colors.white),
                                SizedBox(width: 5,),
                                Text('Add Bank', style: TextStyle(fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                        ]
                    ),
                  ),
                ],
              ),
              Container(
                  width: width,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).cardColor,
                  ),
                  margin: EdgeInsets.only(top:130,left:10.0,right:10.0,),
                  height:height,
                  child:Padding(
                    padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top:10,bottom: 5.0),
                            child: Text('Name', style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color:Theme.of(context).textTheme.headline2?.color)),
                          ),
                      TextFieldCommon(textcotroller: _aliasController, hint: "enter name", validation:"name required", hintColor: Theme.of(context).textTheme.headline2?.color),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,bottom: 5.0),
                            child: Text('Account Number', style: TextStyle(fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color:Theme.of(context).textTheme.headline2?.color,)),
                          ),
                          TextFieldCommon(textcotroller: _accountNoController, hint: "enter account number", validation:"account number required", hintColor: Theme.of(context).textTheme.headline2?.color,inputType: TextInputType.number,numberlength: 18,numbercheck: true,minnumberlengtgh:9,numbermessage: "Invalid account number"),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,bottom: 5.0),
                            child: Text('Re-Account Number', style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).textTheme.headline2?.color)),
                          ),
                          Container(
                            height:height*0.06,
                            margin: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                              color: Theme.of(context)
                                  .indicatorColor
                                  .withOpacity(0.4),
                            ),
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline3?.color,
                                  fontSize: 11.0,fontWeight: FontWeight.w500
                                ),
                                textInputAction: TextInputAction.done,
                              //  focusNode: _reenterFocus,
                                keyboardType: TextInputType.number,
                                validator: (value){
                                  if(_accountNoController.text!=_reenterController.text){
                                    return 'account number is not match';
                                  }
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: _reenterController,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  errorBorder: InputBorder.none,
                                  errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.6),
                                  contentPadding:  EdgeInsets.only(left: 10),
                                  hintText: "Re-enter account number",
                                  hintStyle: TextStyle(
                                    color: Theme.of(context).textTheme.headline2?.color,
                                    fontSize: 10.0,fontWeight: FontWeight.w500
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,bottom: 5.0),
                            child: Text('Nationality', style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).textTheme.headline2?.color)),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                color: Theme.of(context)
                                    .indicatorColor
                                    .withOpacity(0.4),
                              ),
                              margin: EdgeInsets.only(left: 5,right: 5),
                              height: MediaQuery.of(context).size.height*0.06,
                              child: Center(
                                child: DropdownButtonFormField<String>(
                                  iconEnabledColor:Theme.of(context).textTheme.headline2?.color,
                                  dropdownColor:Theme.of(context).backgroundColor,
                                  value:nationality,
                                  items: country.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Text(value,style: TextStyle(fontSize: 12,
                                              color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    nationality = newVal;
                                   // getState(nationality.toString());
                                    print(nationality.toString());
                                  },
                                  hint: Text('Select Country', style:TextStyle(fontSize: 11, color: Theme.of(context).textTheme.headline2?.color)),
                                  validator: (value) => value == null ? ' Please select country' : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.only(left: 8),
                                      errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.8),
                                      focusedBorder:InputBorder.none,
                                      errorBorder: InputBorder.none
                                    //focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  style: TextStyle(color:Theme.of(context).textTheme.headline2?.color, fontSize: 12,fontWeight: FontWeight.w600),

                                ),
                              )
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,bottom: 5.0),
                            child: Text('IFSC Code', style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).textTheme.headline2?.color)),
                          ),
                          Container(
                            height:height*0.06,
                            width:width,
                            margin:  EdgeInsets.only(left:4.0,right: 4.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .indicatorColor
                                    .withOpacity(0.4),
                                borderRadius: BorderRadius.circular(2)),
                            child: Center(
                              child: TextFormField(
                                  controller: _ifscController,
                                 // inputFormatters: [LengthLimitingTextInputFormatter(12),],
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.6),
                                    contentPadding:  EdgeInsets.only(left: 10,),
                                    hintText: 'enter ifsc code',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).textTheme.headline2?.color,
                                      fontSize: 11.0,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.headline3?.color,
                                    fontSize: 11.0,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'IFSC Code is required';
                                    }if(!validateStructure(value.toString())){
                                      return 'The value must be alpha-numeric';
                                    }
                                    else {
                                      return null;
                                    }
                                  }
                              ),
                            ),
                          ),
                          // SizedBox(height: 10),
                          // Padding(
                          //   padding: const EdgeInsets.only(left:0.0,right:5.0,top:0,bottom: 5.0),
                          //   child: Text('Select State', style: TextStyle(fontSize: 12.0,
                          //     fontWeight: FontWeight.w500,
                          //     color: Theme.of(context).textTheme.headline2?.color,)),
                          // ),
                          // Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          //       color: Theme.of(context)
                          //           .indicatorColor
                          //           .withOpacity(0.4),
                          //     ),
                          //     margin: EdgeInsets.only(left: 5,right: 5),
                          //     height: MediaQuery.of(context).size.height*0.06,
                          //     child: Center(
                          //       child: DropdownButtonFormField<StateObj>(
                          //         iconEnabledColor:Theme.of(context).textTheme.headline2?.color,
                          //         dropdownColor:Theme.of(context).backgroundColor,
                          //         value:getSelectProductTax(stateobj),
                          //           items: stateList.map((StateObj value) {
                          //             return DropdownMenuItem<StateObj>(
                          //               value: value,
                          //               child: Padding(
                          //                 padding: EdgeInsets.only(left:8.0),
                          //                 child: Text(value.name,style: TextStyle(fontSize: 12,
                          //                     color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                          //                 ),
                          //               ),
                          //             );
                          //           }).toList(),
                          //         onChanged: (newVal) {
                          //           stateobj = newVal;
                          //           setState(() {
                          //             state= stateobj!.name;
                          //           });
                          //           print(state.toString());
                          //         },
                          //         hint: Text('Select state', style:TextStyle(fontSize: 11, color: Theme.of(context).textTheme.headline2?.color)),
                          //         validator: (value) => value == null ? ' Please select state' : null,
                          //         autovalidateMode: AutovalidateMode.onUserInteraction,
                          //         decoration: InputDecoration(
                          //             border: InputBorder.none,
                          //             enabledBorder: InputBorder.none,
                          //             isCollapsed: true,
                          //             contentPadding: EdgeInsets.only(left: 8),
                          //             errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.8),
                          //             focusedBorder:InputBorder.none,
                          //             errorBorder: InputBorder.none
                          //           //focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                          //         ),
                          //         isDense: true,
                          //         isExpanded: true,
                          //         style: TextStyle(color:Theme.of(context).textTheme.headline2?.color, fontSize: 12,fontWeight: FontWeight.w600),
                          //
                          //       ),
                          //     )
                          // ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,bottom: 5.0),
                            child: Text('Account type', style: TextStyle(fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.headline2?.color,)),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                color: Theme.of(context).indicatorColor.withOpacity(0.4),),
                              height: MediaQuery.of(context).size.height*0.07,
                              child: Center(
                                child: DropdownButtonFormField<String>(
                                  iconEnabledColor:Theme.of(context).textTheme.headline2?.color,
                                  dropdownColor:Theme.of(context).backgroundColor,
                                  items: Accounttype.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: EdgeInsets.only(left:8.0),
                                        child: Text(value,style: TextStyle(fontSize: 12,
                                            color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value:account_type,
                                  onChanged: (newVal) {
                                    account_type = newVal;
                                  },
                                  hint: Text('select type', style:TextStyle(fontSize: 12, color:Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w500)),
                                  validator: (value) => value == null ? ' Please select account type' : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.only(left: 8),
                                      errorStyle: TextStyle(fontSize: 10,color: Colors.red,height: 0.8),
                                      focusedBorder:InputBorder.none,
                                      errorBorder: InputBorder.none
                                  ),
                                  style: TextStyle(color: Theme.of(context).textTheme.headline2?.color, fontSize: 12),
                                  isDense: true,
                                  isExpanded: true,
                                ),
                              )
                          ),
                          SizedBox(height: 40),
                          InkWell(
                            onTap: (){
                              if(_formKey.currentState!.validate()) {
                                  setState(() {
                                    isClicked="1";
                                  });
                                  addBankDetail();
                              }
                            },
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  color:Theme
                                      .of(context)
                                      .hoverColor.withOpacity(0.9)),
                              child: Center(
                                child:isClicked=="0"?Text('Save',textAlign: TextAlign.center, style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color:Colors.white)):SizedBox(height:15,width:15,child: Center(child: CircularProgressIndicator(color:Theme.of(context).textTheme.headline2?.color)),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          )
      ),
    );
  }

  Future<void> addBankDetail() async {
    final paramDic = {
      "alias": _aliasController.text.toString(),
      "account_number": _accountNoController.text.toString(),
      "account_type": account_type.toString(),
      "confirm_account_number": _reenterController.text.toString(),
      "ifsc_code": _ifscController.text.toString(),
      "country": nationality.toString(),
    };
    print(paramDic);
    var response;
    response = await LBMAPIMainClass(ApiCollections.addbankdetail, paramDic, "Post");
    var data = json.decode(response.body);
    print(data.toString());
    print(response);
    if(data["status_code"]=='1'){
      setState(() {
        isClicked="0";
      });
      Navigator.of(context).pop();
    }
    else{
      setState(() {
        isClicked="0";
      });
      ToastShowClass.toastShow(context,data["message"], Colors.red);
    }
  }

  // Future<void> getState(String nationality) async{
  //   print("state"+" "+nationality);
  //   final paramDic = {
  //     "country": nationality.toString(),
  //   };
  //   print(paramDic);
  //   var response = await ServerMain(ApiCollections.getstate, paramDic, "Get");
  //   var data = json.decode(response.body);
  //   print("res"+response.body);
  //   if(data["status_code"]=='1'){
  //       stateList.clear();
  //     for(int i=0;i<data["data"]["states"].length;i++){
  //       setState(() {
  //         stateList.add(new StateObj(data["data"]["states"][i].toString()));
  //       });
  //     }
  //   }
  //   else{
  //     ToastShowClass.toastShow(context,data["message"], Colors.red);
  //   }
  // }
  Future<void> getCountry() async{
    final paramDic = {
      "": "",
    };
    print(paramDic);
    var response = await ServerMain(ApiCollections.getCountry, paramDic, "Get");
    var data = json.decode(response.body);
    print("res"+response.body);
    if(data["status_code"]=='1'){
      country.clear();
      for(int i=0;i<data["data"]["countries"].length;i++){
        setState(() {
          country.add(data["data"]["countries"][i]["country"].toString());
        });
      }
      print("Done");
    }
    else{
      ToastShowClass.toastShow(context,data["message"], Colors.red);
    }
  }
  getSelectProductTax(yourValue){
    //add this line of code
    if(yourValue == null) return null;
    for(stateobj in stateList){
      if(stateobj!.name == yourValue.name)
        return stateobj;
    }
    return null;
  }
}

class StateObj {
  String name;
  StateObj(this.name);
}