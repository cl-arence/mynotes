import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('sv'),
    Locale('en'),
  ];

  /// No description provided for @logout_button.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout_button;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @sharing.
  ///
  /// In en, this message translates to:
  /// **'Sharing'**
  String get sharing;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify email'**
  String get verify_email;

  /// No description provided for @verify_email_short.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify_email_short;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @notes_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search your thoughts'**
  String get notes_search_hint;

  /// No description provided for @notes_new_note.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get notes_new_note;

  /// No description provided for @notes_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get notes_empty_title;

  /// No description provided for @notes_empty_body.
  ///
  /// In en, this message translates to:
  /// **'Tap New note to catch your first thought.'**
  String get notes_empty_body;

  /// No description provided for @notes_no_search_results.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get notes_no_search_results;

  /// No description provided for @notes_no_search_results_body.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or clear the field.'**
  String get notes_no_search_results_body;

  /// No description provided for @notes_delete_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete note'**
  String get notes_delete_tooltip;

  /// No description provided for @note_editor_saves_automatically.
  ///
  /// In en, this message translates to:
  /// **'Saving as you write'**
  String get note_editor_saves_automatically;

  /// No description provided for @verification_banner_title.
  ///
  /// In en, this message translates to:
  /// **'Verify your email when you can'**
  String get verification_banner_title;

  /// No description provided for @verification_banner_body.
  ///
  /// In en, this message translates to:
  /// **'You can keep using MindPad, but verification helps protect your account. If the email is missing, check Junk, Spam, Promotions, or search your inbox for MindPad.'**
  String get verification_banner_body;

  /// No description provided for @verification_banner_sent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent. Check your inbox and junk folder.'**
  String get verification_banner_sent;

  /// No description provided for @verification_banner_still_pending.
  ///
  /// In en, this message translates to:
  /// **'Still not verified yet. Open the email link, then tap check again.'**
  String get verification_banner_still_pending;

  /// No description provided for @verification_banner_verified.
  ///
  /// In en, this message translates to:
  /// **'Email verified. You\'re all set.'**
  String get verification_banner_verified;

  /// No description provided for @verification_banner_error.
  ///
  /// In en, this message translates to:
  /// **'Could not update verification right now. Please try again.'**
  String get verification_banner_error;

  /// No description provided for @verification_banner_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get verification_banner_resend;

  /// No description provided for @verification_banner_check.
  ///
  /// In en, this message translates to:
  /// **'I verified'**
  String get verification_banner_check;

  /// No description provided for @start_typing_your_note.
  ///
  /// In en, this message translates to:
  /// **'Write what\'s on your mind...'**
  String get start_typing_your_note;

  /// No description provided for @delete_note_prompt.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get delete_note_prompt;

  /// No description provided for @cannot_share_empty_note_prompt.
  ///
  /// In en, this message translates to:
  /// **'Cannot share an empty note!'**
  String get cannot_share_empty_note_prompt;

  /// No description provided for @generic_error_prompt.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get generic_error_prompt;

  /// No description provided for @logout_dialog_prompt.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logout_dialog_prompt;

  /// No description provided for @password_reset.
  ///
  /// In en, this message translates to:
  /// **'Password reset'**
  String get password_reset;

  /// No description provided for @password_reset_dialog_prompt.
  ///
  /// In en, this message translates to:
  /// **'We have now sent you a password reset link. Please check your email for more information.'**
  String get password_reset_dialog_prompt;

  /// No description provided for @login_error_cannot_find_user.
  ///
  /// In en, this message translates to:
  /// **'Cannot find a user with the entered credentials!'**
  String get login_error_cannot_find_user;

  /// No description provided for @login_error_wrong_credentials.
  ///
  /// In en, this message translates to:
  /// **'Wrong credentials'**
  String get login_error_wrong_credentials;

  /// No description provided for @login_error_auth_error.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get login_error_auth_error;

  /// No description provided for @login_view_prompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep your ideas close and synced.'**
  String get login_view_prompt;

  /// No description provided for @login_view_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'I forgot my password'**
  String get login_view_forgot_password;

  /// No description provided for @login_view_not_registered_yet.
  ///
  /// In en, this message translates to:
  /// **'Not registered yet? Register here!'**
  String get login_view_not_registered_yet;

  /// No description provided for @email_text_field_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your email here'**
  String get email_text_field_placeholder;

  /// No description provided for @password_text_field_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your password here'**
  String get password_text_field_placeholder;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @forgot_password_view_generic_error.
  ///
  /// In en, this message translates to:
  /// **'We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.'**
  String get forgot_password_view_generic_error;

  /// No description provided for @forgot_password_view_prompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send a reset link so you can get back to your notes.'**
  String get forgot_password_view_prompt;

  /// No description provided for @forgot_password_view_send_me_link.
  ///
  /// In en, this message translates to:
  /// **'Send me password reset link'**
  String get forgot_password_view_send_me_link;

  /// No description provided for @forgot_password_view_back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to login page'**
  String get forgot_password_view_back_to_login;

  /// No description provided for @register_error_weak_password.
  ///
  /// In en, this message translates to:
  /// **'This password is not secure enough. Please choose another password!'**
  String get register_error_weak_password;

  /// No description provided for @register_error_email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered to another user. Please choose another email!'**
  String get register_error_email_already_in_use;

  /// No description provided for @register_error_generic.
  ///
  /// In en, this message translates to:
  /// **'Failed to register. Please try again later!'**
  String get register_error_generic;

  /// No description provided for @register_error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'The email address you entered appears to be invalid. Please try another email address!'**
  String get register_error_invalid_email;

  /// No description provided for @register_view_prompt.
  ///
  /// In en, this message translates to:
  /// **'Create your account and start collecting notes, sparks, and plans.'**
  String get register_view_prompt;

  /// No description provided for @register_view_already_registered.
  ///
  /// In en, this message translates to:
  /// **'Already registered? Login here!'**
  String get register_view_already_registered;

  /// No description provided for @verify_email_view_prompt.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you an email verification. You can keep using MindPad while you verify. If it is missing, check Junk, Spam, Promotions, or search for MindPad.'**
  String get verify_email_view_prompt;

  /// No description provided for @verify_email_send_email_verification.
  ///
  /// In en, this message translates to:
  /// **'Send email verification'**
  String get verify_email_send_email_verification;

  /// No description provided for @notes_title.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No notes yet} =1{1 note} other{{count} notes}}'**
  String notes_title(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['sv', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'sv':
      return AppLocalizationsSv();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
