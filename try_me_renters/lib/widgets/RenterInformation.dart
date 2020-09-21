import 'package:flutter/material.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/Request.dart';

class CompanyInformation extends StatefulWidget {
  @override
  _CompanyInformationState createState() => _CompanyInformationState();
}

class _CompanyInformationState extends State<CompanyInformation> {
  var edit = new List(7);
  double _widthScreen;
  double _heightScreen;
  bool _infoValid;
  final _formKey = GlobalKey<FormState>();

  String buttonText = 'Sauvegarder';
  String tmp;

  @override
  void initState() {
    initBool(edit);
    super.initState();
  }

  void initBool(var list) {
    for (int i = 0; i < 7; i++) {
      list[i] = false;
    }
  }

  /*String modifySiretSiren(String siretSiren) {
  String tmp = siretSiren;
  siretSiren = tmp.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");
  var parts = siretSiren.split(" ");
  siretSiren = parts[0] + ' ' + parts[1] + ' ' + parts[2] + ' ' + parts[3] + parts[4];
  return (siretSiren);
  }*/

  Widget _presentation(double widthScreen) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(widthScreen / 20),
          child: CircleAvatar(
            backgroundImage: company.pathToAvatar != null
                ? NetworkImage(company.pathToAvatar)
                : AssetImage("assets/company_logo_temp.jpg"),
            radius: widthScreen / 10,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    //get name here
                    child: (() {
                  if (company.name != null && company.name != "")
                    return (Text(
                      company.name,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.black,
                      ),
                    ));
                  else
                    return (Text(
                      "Pas de nom défini",
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.orange,
                      ),
                    ));
                }())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalFirstName(var edit) {
    if (edit[1]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.name != null ? company.name : "",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre nom",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z-]{2,16}$").hasMatch(value);
                          if (value.isEmpty) {
                            tmp = null;
                            return null;
                          } else if (!_infoValid) {
                            return "Le format de votre nom est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[1] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    company.name = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: (() {
              if (company.name != null && company.name != "")
                return (Text(
                  company.name,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ));
              else
                return (Text(
                  "Pas de nom défini",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.orange,
                  ),
                ));
            }())),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[1] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalAddress(var edit) {
    if (edit[2]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue:
                            company.address != null ? company.address : "",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre adresse",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid = RegExp(r"^[a-zA-Z0-9-', ]{2,100}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            tmp = null;
                            return null;
                          } else if (!_infoValid) {
                            return "Le format de votre adresse est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[2] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    company.address = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: (() {
              if (company.address != null && company.address != "")
                return (Text(
                  company.address,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ));
              else
                return (Text(
                  "Pas d'adresse définie",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.orange,
                  ),
                ));
            }())),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[2] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalPhoneNumber(var edit) {
    if (edit[3]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.phoneNumber != null
                            ? company.phoneNumber
                            : "",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer votre numéro de téléphone",
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[0-9 ]{10,10}$").hasMatch(value);
                          if (value.isEmpty) {
                            tmp = null;
                            return null;
                          } else if (!_infoValid) {
                            return "Le format de votre numéro de téléphone est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[3] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    //tmp = modifyPhoneNumber(tmp);
                    company.phoneNumber = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: (() {
              if (company.phoneNumber != null && company.phoneNumber != "")
                return (Text(
                  company.phoneNumber,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ));
              else
                return (Text(
                  "Pas de numéro de téléphone défini",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.orange,
                  ),
                ));
            }())),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[3] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _personalEmail(var edit) {
    if (edit[4]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue:
                            company.email != null ? company.email : "",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entre votre email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid = RegExp(
                                  r"^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            tmp = null;
                            return null;
                          } else if (!_infoValid) {
                            return "Le format de votre email est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[4] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    company.email = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: (() {
              if (company.email != null && company.email != "")
                return (Text(
                  company.email,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ));
              else
                return (Text(
                  "Pas d'adresse mail définie",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.orange,
                  ),
                ));
            }())),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[4] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _siren(var edit) {
    if (edit[6]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue:
                            company.siren != null ? company.siren : "",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer le SIREN de votre entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid = RegExp(r"^[0-9]{9,9}$").hasMatch(value);
                          if (value.isEmpty) {
                            tmp = null;
                            return null;
                          } else if (!_infoValid) {
                            return "Le format du SIREN de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[6] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    //tmp = modifySiretSiren(tmp);
                    company.siren = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: (() {
              if (company.siren != null && company.siren != "")
                return (Text(
                  company.siren,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ));
              else
                return (Text(
                  "Pas de SIREN défini",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.orange,
                  ),
                ));
            }())),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[6] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _siret(var edit) {
    if (edit[5]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue:
                            company.siret != null ? company.siret : "",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer le SIRET de votre entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[0-9]{14,14}$").hasMatch(value);
                          if (value.isEmpty) {
                            tmp = null;
                            return null;
                          } else if (!_infoValid) {
                            return "Le format du SIRET de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[5] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    //tmp = modifySiretSiren(tmp);
                    company.siret = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: (() {
              if (company.siret != null && company.siret != "")
                return (Text(
                  company.siret,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ));
              else
                return (Text(
                  "Pas de SIRET défini",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.orange,
                  ),
                ));
            }())),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[5] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _myDivider() {
    return Container(
      margin:
          EdgeInsets.only(left: _widthScreen / 10, right: _widthScreen / 10),
      child: Divider(
        height: 1,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    _heightScreen = (_height > _width) ? _height : _width;
    _widthScreen = (_height > _width) ? _width : _height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Informations de l\'entreprise'),
        centerTitle: true,
        backgroundColor: Color(0xff1F2C47),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _heightScreen * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _presentation(_widthScreen),
              _myDivider(),
              _personalFirstName(edit),
              _myDivider(),
              _personalAddress(edit),
              _myDivider(),
              _personalPhoneNumber(edit),
              _myDivider(),
              _personalEmail(edit),
              _myDivider(),
              _siret(edit),
              _myDivider(),
              _siren(edit),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (!edit[0]) {
                      Request.modifyCompany().whenComplete(
                          () => Navigator.pushNamed(context, "home"));
                    }
                  });
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xff58c24c),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
