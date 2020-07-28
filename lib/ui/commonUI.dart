// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:minicode_crm/translation/localizations.dart';

class CommonUI{
  BuildContext context ;
  CommonUI(this.context);
  Widget dropDownUI(String currentVal, List<String> list,Function func){
    return  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 100.0,

                          // width: MediaQuery.of(context).size.width - 40.0,
                          decoration: BoxDecoration(
                              color: Colors.indigo[50].withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: new DropdownButton<String>(
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((list.length<= 0)?"No Data Found":"select ",
                                style: TextStyle(
                                            color: Colors.indigo[300])),
                            ),
                            underline: Container(color:(Colors.indigo[50])),

                            iconEnabledColor: Colors.indigo,
                            iconDisabledColor: Colors.indigo,
                            value:(currentVal != null)?currentVal:"",
                            items:
                                list.map((String value) {
                              return new DropdownMenuItem<String>(

                                value: value,
                                child: Center(
                                  // padding: const EdgeInsets.only(left:20.0,right:0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(value,
                                        style: TextStyle(
                                            color: Colors.indigo[300])),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged:func,
                                                      ),
                                                    ),
                                                  ],
                                                );
                              }
                              Widget buildTextField(String hint,TextEditingController controller,TextInputType textInputType,context,{Function errorMsg}){
                                return Padding(
                                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                                      child: Theme(
                                      data: new ThemeData(
                                      primaryColor: Colors.indigo,
                                      primaryColorDark: Colors.indigo,
                                      ),
                                                    child: TextFormField(
                                                      validator: errorMsg
                                                    ,
                                        //  obscureText:(hint == AppLocalizations.of(context).pass)? !isVisible:true,           
                                          controller: controller,
                                          textDirection:(Localizations.localeOf(context).languageCode == "ar")?TextDirection.rtl:TextDirection.ltr,
                                          keyboardType: textInputType,
                                           maxLines: null,
                                           style: TextStyle(color: Colors.indigo),
                                          decoration: InputDecoration(
                                            
                                              // e3rrorText:errorMsg,
                                              filled: true,
                                              fillColor: Colors.indigo[50].withOpacity(0.8),
                                              contentPadding: EdgeInsets.all(5.0),
                                              border: new OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                             
                                              hintText: hint,
                                              hintStyle: TextStyle(color: Colors.indigo[300])),
                                        ),
                                      ),
                                    );
                              }
                            
                             
}