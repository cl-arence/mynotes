// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get logout_button => 'Log out';

  @override
  String get note => 'Note';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get delete => 'Delete';

  @override
  String get sharing => 'Sharing';

  @override
  String get ok => 'OK';

  @override
  String get login => 'Login';

  @override
  String get verify_email => 'Verify email';

  @override
  String get verify_email_short => 'Verify';

  @override
  String get register => 'Register';

  @override
  String get restart => 'Restart';

  @override
  String get notes_search_hint => 'Search your thoughts';

  @override
  String get notes_new_note => 'New note';

  @override
  String get notes_empty_title => 'No notes yet';

  @override
  String get notes_empty_body => 'Tap New note to catch your first thought.';

  @override
  String get notes_no_search_results => 'No matches';

  @override
  String get notes_no_search_results_body =>
      'Try a different search or clear the field.';

  @override
  String get notes_delete_tooltip => 'Delete note';

  @override
  String get note_editor_saves_automatically => 'Saving as you write';

  @override
  String get verification_banner_title => 'Verify your email when you can';

  @override
  String get verification_banner_body =>
      'You can keep using MindPad, but verification helps protect your account. If the email is missing, check Junk, Spam, Promotions, or search your inbox for MindPad.';

  @override
  String get verification_banner_sent =>
      'Verification email sent. Check your inbox and junk folder.';

  @override
  String get verification_banner_still_pending =>
      'Still not verified yet. Open the email link, then tap check again.';

  @override
  String get verification_banner_verified => 'Email verified. You\'re all set.';

  @override
  String get verification_banner_error =>
      'Could not update verification right now. Please try again.';

  @override
  String get verification_banner_resend => 'Resend email';

  @override
  String get verification_banner_check => 'I verified';

  @override
  String get start_typing_your_note => 'Write what\'s on your mind...';

  @override
  String get delete_note_prompt => 'Are you sure you want to delete this note?';

  @override
  String get cannot_share_empty_note_prompt => 'Cannot share an empty note!';

  @override
  String get generic_error_prompt => 'An error occurred';

  @override
  String get logout_dialog_prompt => 'Are you sure you want to log out?';

  @override
  String get password_reset => 'Password reset';

  @override
  String get password_reset_dialog_prompt =>
      'We have now sent you a password reset link. Please check your email for more information.';

  @override
  String get login_error_cannot_find_user =>
      'Cannot find a user with the entered credentials!';

  @override
  String get login_error_wrong_credentials => 'Wrong credentials';

  @override
  String get login_error_auth_error => 'Authentication error';

  @override
  String get login_view_prompt =>
      'Sign in to keep your ideas close and synced.';

  @override
  String get login_view_forgot_password => 'I forgot my password';

  @override
  String get login_view_not_registered_yet =>
      'Not registered yet? Register here!';

  @override
  String get email_text_field_placeholder => 'Enter your email here';

  @override
  String get password_text_field_placeholder => 'Enter your password here';

  @override
  String get forgot_password => 'Forgot Password';

  @override
  String get forgot_password_view_generic_error =>
      'We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.';

  @override
  String get forgot_password_view_prompt =>
      'Enter your email and we\'ll send a reset link so you can get back to your notes.';

  @override
  String get forgot_password_view_send_me_link => 'Send me password reset link';

  @override
  String get forgot_password_view_back_to_login => 'Back to login page';

  @override
  String get register_error_weak_password =>
      'This password is not secure enough. Please choose another password!';

  @override
  String get register_error_email_already_in_use =>
      'This email is already registered to another user. Please choose another email!';

  @override
  String get register_error_generic =>
      'Failed to register. Please try again later!';

  @override
  String get register_error_invalid_email =>
      'The email address you entered appears to be invalid. Please try another email address!';

  @override
  String get register_view_prompt =>
      'Create your account and start collecting notes, sparks, and plans.';

  @override
  String get register_view_already_registered =>
      'Already registered? Login here!';

  @override
  String get verify_email_view_prompt =>
      'We\'ve sent you an email verification. You can keep using MindPad while you verify. If it is missing, check Junk, Spam, Promotions, or search for MindPad.';

  @override
  String get verify_email_send_email_verification => 'Send email verification';

  @override
  String notes_title(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes',
      one: '1 note',
      zero: 'No notes yet',
    );
    return '$_temp0';
  }
}
