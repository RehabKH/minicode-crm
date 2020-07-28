import 'dart:async';
import 'dart:ui';

// import 'package:amial/l10n/messages_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }
 

  String get  makeAccount{
    return Intl.message('make account', name: 'makeAccount');
  }

  String get signUp {
    return Intl.message('Sign up', name: 'signUp');
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }

  

  String get Name {
    return Intl.message('Your Name', name: 'Name');
  }

  String get phone {
    return Intl.message('Phone', name: 'phone');
  }

   String get email {
    return Intl.message('Email', name: 'email');
  }

   String get pass {
    return Intl.message('Password', name: 'pass');
  }


   String get signIn {
    return Intl.message('Login', name: 'signIn');
  }
   
   String get hasAcc {
    return Intl.message("Already has account..", name: 'hasAcc');
  }
   String get writeComment {
    return Intl.message("write Comment", name: 'writeComment');
  }
   String get submit {
    return Intl.message("Submit", name: 'submit');
  }
 String get enterCode {
    return Intl.message("Enter Code", name: 'enterCode');
  }
   String get search {
    return Intl.message("Search", name: 'search');
  }
   String get leadComment {
    return Intl.message("Last Comment", name: 'leadComment');
  }
  String get dataNotFound {
    return Intl.message("Data Not Found", name: 'dataNotFound');
  }
  String get creationDate {
    return Intl.message("Creation Date", name: 'creationDate');
  }
   String get nextActionDate {
    return Intl.message("Next Action Date", name: 'nextActionDate');
  } 
 String get addLead {
    return Intl.message("Add Lead", name: 'addLead');
  } 
  String get addAction {
    return Intl.message("Add Action", name: 'addAction');
  } 
    String get contactInfo {
    return Intl.message("Contact Info", name: 'contactInfo');
  } 
  String get actionDesc {
    return Intl.message("Action Description", name: 'actionDesc');
  }
  String get welcome {
    return Intl.message("Welcome", name: 'welcome');
  }
   String get logout {
    return Intl.message("Logout", name: 'logout');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}

class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) => SynchronousFuture<_DefaultCupertinoLocalizations>(_DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;
  
  _DefaultCupertinoLocalizations(this.locale);

 
}