// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'न्यूट्रिशनिस्ट';

  @override
  String get logFood => 'खाना लॉग करें';

  @override
  String get dashboard => 'डैशबोर्ड';

  @override
  String get yourProfile => 'आपकी प्रोफ़ाइल';

  @override
  String get commonFoods => 'आम खाद्य पदार्थ';

  @override
  String get searchFoods => 'खाने खोजें...';

  @override
  String today(Object kcal) {
    return 'आज: $kcal कैलोरी';
  }

  @override
  String remaining(Object kcal) {
    return 'शेष: $kcal कैलोरी';
  }

  @override
  String get newDayMessage => 'नया दिन शुरू हुआ — कैलोरी 0 पर रीसेट';

  @override
  String get loggedToday => 'आज लॉग किया गया';

  @override
  String get noFoodToday => 'आज अभी तक कोई खाना लॉग नहीं किया गया';

  @override
  String get addFood => 'खाना जोड़ें';

  @override
  String get foodName => 'खाने का नाम';

  @override
  String get caloriesPerServing => 'प्रति सर्विंग कैलोरी';

  @override
  String get quantity => 'मात्रा';

  @override
  String get mealCategory => 'भोजन श्रेणी';

  @override
  String get done => 'पूर्ण';

  @override
  String get manualModeActive => 'मैनुअल मोड सक्रिय';

  @override
  String get manualModeDesc =>
      'आप बिना व्यक्तिगत लक्ष्य के कैलोरी ट्रैक कर रहे हैं।\nखाने स्वतंत्र रूप से लॉग करें — आप कभी भी सर्वे लेकर व्यक्तिगत लक्ष्य प्राप्त कर सकते हैं।';

  @override
  String get logFoodButton => 'खाना लॉग करें';

  @override
  String get switchToPersonalized => 'व्यक्तिगत मोड पर स्विच करें (सर्वे लें)';

  @override
  String get dailyProgress => 'दैनिक प्रगति';

  @override
  String get goodPace => 'अच्छी गति — जारी रखें!';

  @override
  String get almostThere => 'लगभग पहुँच गए — सावधान रहें';

  @override
  String get overTarget => 'लक्ष्य से अधिक — हल्के विकल्प चुनें';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get startFresh => 'नया शुरू करें (प्रोफ़ाइल साफ़ करें)';

  @override
  String get personalizeJourney => 'अपनी यात्रा को व्यक्तिगत बनाएं';

  @override
  String get takeSurvey => 'प्रोफ़ाइल सर्वे लें';

  @override
  String get continueManual => 'मैनुअल मोड में जारी रखें';

  @override
  String get foodAdded => 'खाना जोड़ दिया गया!';

  @override
  String get all => 'सभी';

  @override
  String get breakfast => 'नाश्ता';

  @override
  String get lunch => 'दोपहर का भोजन';

  @override
  String get dinner => 'रात का खाना';

  @override
  String get snack => 'हल्का नाश्ता';

  @override
  String get fruit => 'फल';

  @override
  String get dessert => 'मिठाई';

  @override
  String get drink => 'पेय';

  @override
  String get allRegions => 'सभी क्षेत्र';

  @override
  String get pakistan => 'पाकिस्तान';

  @override
  String get india => 'भारत';

  @override
  String get saudiArabia => 'सऊदी अरब';

  @override
  String get uae => 'संयुक्त अरब अमीरात';

  @override
  String get usa => 'संयुक्त राज्य अमेरिका';

  @override
  String get uk => 'यूनाइटेड किंगडम';

  @override
  String get germany => 'जर्मनी';

  @override
  String get france => 'फ्रांस';

  @override
  String get spain => 'स्पेन';

  @override
  String get indonesia => 'इंडोनेशिया';

  @override
  String get turkey => 'तुर्की';

  @override
  String get required => 'आवश्यक';

  @override
  String get positiveNumber => 'सकारात्मक संख्या';

  @override
  String get positive => 'सकारात्मक';

  @override
  String get entryDeleted => 'एंट्री हटाई गई';

  @override
  String get unknown => 'अज्ञात';

  @override
  String get kcal => 'कैलोरी';

  @override
  String get caloriesHelper =>
      'अनुमान ठीक है — ऊपर दिए गए विकल्पों का उपयोग करें';

  @override
  String get target => 'लक्ष्य';

  @override
  String get goal => 'उद्देश्य';

  @override
  String get activity => 'गतिविधि';

  @override
  String get targetWeight => 'लक्ष्य वजन';

  @override
  String get dietaryPreference => 'आहार प्राथमिकता';

  @override
  String get restrictions => 'प्रतिबंध';

  @override
  String get clearProfileTitle => 'प्रोफ़ाइल साफ़ करें?';

  @override
  String get clearProfileDesc =>
      'यह सभी सहेजी गई प्रोफ़ाइल जानकारी और कैलोरी लॉग हटा देगा। आप नया शुरू करने के लिए फिर से सर्वे ले सकते हैं।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get profileCleared => 'प्रोफ़ाइल और लॉग साफ़ कर दिए गए';

  @override
  String ofTarget(Object kcal) {
    return '$kcal कैलोरी में से';
  }

  @override
  String get kcalDay => 'कैलोरी/दिन';

  @override
  String get takeSurveyDesc =>
      'कस्टम कैलोरी लक्ष्य और बेहतर सुझावों के लिए त्वरित प्रोफ़ाइल पूरी करें।';

  @override
  String dailyTargetLabel(Object kcal) {
    return '$kcal कैलोरी में से';
  }

  @override
  String get age => 'आयु';

  @override
  String get gender => 'लिंग';

  @override
  String get heightCm => 'ऊँचाई (सेमी)';

  @override
  String get currentWeightKg => 'वर्तमान वजन (किलोग्राम)';

  @override
  String get targetWeightKgOptional => 'लक्ष्य वजन (किलोग्राम) — वैकल्पिक';

  @override
  String get targetWeightHelper =>
      'यदि अभी सुनिश्चित नहीं हैं तो खाली छोड़ दें';

  @override
  String get mainGoal => 'मुख्य लक्ष्य';

  @override
  String get activityLevel => 'गतिविधि स्तर';

  @override
  String get restrictionsLabel =>
      'क्या कोई एलर्जी, असहिष्णुता या चिकित्सीय स्थिति है?';

  @override
  String get restrictionsHelper =>
      'जैसे लैक्टोज असहिष्णुता, मधुमेह, नट एलर्जी… (वैकल्पिक)';

  @override
  String get guidanceQuestion => 'आप कितनी मार्गदर्शन चाहते हैं?';

  @override
  String get guidanceLow => 'मुझे बुनियादी जानकारी है';

  @override
  String get guidanceMedium => 'बीच में कहीं';

  @override
  String get guidanceHigh => 'मुझे सख्ती से मार्गदर्शन करें';

  @override
  String get regionCountry => 'क्षेत्र / देश';

  @override
  String get regionHelper =>
      'स्थानीय खाद्य पदार्थों और सुझावों को दिखाने में मदद करता है';

  @override
  String get saveContinue => 'सहेजें और जारी रखें';

  @override
  String get skipManual => 'छोड़ें → मैनुअल मोड';

  @override
  String get updateProfileTitle => 'प्रोफ़ाइल अपडेट करें?';

  @override
  String get updateProfileDesc =>
      'आपकी प्रोफ़ाइल पहले से सहेजी गई है। अपडेट करने से पुरानी जानकारी बदल जाएगी। जारी रखें?';

  @override
  String get update => 'अपडेट';

  @override
  String get profileSaved => 'प्रोफ़ाइल सफलतापूर्वक सहेजी गई';

  @override
  String get basicInfo => 'मूल जानकारी';

  @override
  String get goalsAndLifestyle => 'लक्ष्य और जीवनशैली';

  @override
  String get preferences => 'पसंद';

  @override
  String get location => 'स्थान';

  @override
  String get next => 'आगे';
}
