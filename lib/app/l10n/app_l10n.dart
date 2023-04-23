import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_l10n_en.dart';
import 'app_l10n_tr.dart';

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
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
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password'**
  String get forgotPasswordSubTitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @alreadySendCode.
  ///
  /// In en, this message translates to:
  /// **'Have you already sent the code?'**
  String get alreadySendCode;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @loginSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get loginSubTitle;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your account safe'**
  String get newPasswordSubTitle;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordBlankError.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be left blank'**
  String get passwordBlankError;

  /// No description provided for @passwordMatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordMatchError;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordRules.
  ///
  /// In en, this message translates to:
  /// **'Password rules'**
  String get passwordRules;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @allPasswordRules.
  ///
  /// In en, this message translates to:
  /// **'At least 1 digit \nAt least 1 lowercase letter \nAt least 1 uppercase letter \nAt least 1 special character like . or *\nAt least 8 characters long'**
  String get allPasswordRules;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'One Time Password'**
  String get otpTitle;

  /// No description provided for @otpSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP code to reset'**
  String get otpSubTitle;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @waitSendAgain.
  ///
  /// In en, this message translates to:
  /// **'Wait 5 minutes to send code again.'**
  String get waitSendAgain;

  /// No description provided for @passwordChangedSuccesfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully.'**
  String get passwordChangedSuccesfully;

  /// No description provided for @pleaseSignIn.
  ///
  /// In en, this message translates to:
  /// **'Please sign in!'**
  String get pleaseSignIn;

  /// No description provided for @signUpSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your new account'**
  String get signUpSubTitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have you an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @plans.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get plans;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @noMission.
  ///
  /// In en, this message translates to:
  /// **'No missions for this day'**
  String get noMission;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @run.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get run;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @onboardingAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to continue without creating the account?'**
  String get onboardingAlertTitle;

  /// No description provided for @onboardingAlertContent.
  ///
  /// In en, this message translates to:
  /// **'You can also register while using the app.'**
  String get onboardingAlertContent;

  /// No description provided for @continueAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Or Continue as Anonymous'**
  String get continueAnonymous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @planOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Create your daily plan and stay organized.'**
  String get planOnboarding;

  /// No description provided for @runOnboarding.
  ///
  /// In en, this message translates to:
  /// **'You can stop or complete a task anytime.'**
  String get runOnboarding;

  /// No description provided for @doneOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Get things done and achieve your goals.'**
  String get doneOnboarding;

  /// No description provided for @loginOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save your progress and settings.'**
  String get loginOnboarding;

  /// No description provided for @notificationPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications to remind you of your important tasks throughout the day.'**
  String get notificationPermission;

  /// No description provided for @allowNotification.
  ///
  /// In en, this message translates to:
  /// **'Allow Notification'**
  String get allowNotification;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @dateCantEmpty.
  ///
  /// In en, this message translates to:
  /// **'Date can\'t be empty'**
  String get dateCantEmpty;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @timeCantEmpty.
  ///
  /// In en, this message translates to:
  /// **'Time can\'t be empty'**
  String get timeCantEmpty;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @priorityCantEmpty.
  ///
  /// In en, this message translates to:
  /// **'Priority can\'t be empty'**
  String get priorityCantEmpty;

  /// No description provided for @categoryCantEmpty.
  ///
  /// In en, this message translates to:
  /// **'Category can\'t be empty'**
  String get categoryCantEmpty;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @planCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories appear here'**
  String get planCategories;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this category?'**
  String get deleteCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Do you want to edit this category?'**
  String get editCategory;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @showFilterPart.
  ///
  /// In en, this message translates to:
  /// **'You can use this part to filter'**
  String get showFilterPart;

  /// No description provided for @showPlansPart.
  ///
  /// In en, this message translates to:
  /// **'The plans you have made will appear here'**
  String get showPlansPart;

  /// No description provided for @showCreatePart.
  ///
  /// In en, this message translates to:
  /// **'Click here to create a plan'**
  String get showCreatePart;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @changeNotification.
  ///
  /// In en, this message translates to:
  /// **'You can change app permissions by going to settings.'**
  String get changeNotification;

  /// No description provided for @goSettings.
  ///
  /// In en, this message translates to:
  /// **'Go settings'**
  String get goSettings;

  /// No description provided for @mainColor.
  ///
  /// In en, this message translates to:
  /// **'Main Color'**
  String get mainColor;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @chooseColor.
  ///
  /// In en, this message translates to:
  /// **'Choose your color'**
  String get chooseColor;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @archives.
  ///
  /// In en, this message translates to:
  /// **'Archives'**
  String get archives;

  /// No description provided for @unarchive.
  ///
  /// In en, this message translates to:
  /// **'Unarchive'**
  String get unarchive;

  /// No description provided for @noArchive.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any mission in the archive'**
  String get noArchive;

  /// No description provided for @archiveMessage.
  ///
  /// In en, this message translates to:
  /// **'Quests added to the archive are not evaluated in statistics'**
  String get archiveMessage;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @worksDays.
  ///
  /// In en, this message translates to:
  /// **'Works - Days'**
  String get worksDays;

  /// No description provided for @timeSpentCat.
  ///
  /// In en, this message translates to:
  /// **'Time Spent(Hours) - Categories'**
  String get timeSpentCat;

  /// No description provided for @noStatistics.
  ///
  /// In en, this message translates to:
  /// **'You did not complete a task this month'**
  String get noStatistics;

  /// No description provided for @userSettings.
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get userSettings;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @anonymousUser.
  ///
  /// In en, this message translates to:
  /// **'Anonymous User'**
  String get anonymousUser;

  /// No description provided for @cantChangePassword.
  ///
  /// In en, this message translates to:
  /// **'You can\'t change password.'**
  String get cantChangePassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteAccount;

  /// No description provided for @deleteAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Deletion Warning'**
  String get deleteAlertTitle;

  /// No description provided for @deleteAlertContent.
  ///
  /// In en, this message translates to:
  /// **'This action will permanently delete your account and cannot be undone. All your data will be erased. \n\nAre you sure?'**
  String get deleteAlertContent;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @starAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Continuity:'**
  String get starAlertTitle;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @starAlertContent.
  ///
  /// In en, this message translates to:
  /// **'When you complete at least one task every day, your strike score on your profile increases. \n\nIf you fail to complete a task even for one day, your strike score resets back to zero and starts again.'**
  String get starAlertContent;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shareDialogFront.
  ///
  /// In en, this message translates to:
  /// **'I would like to share with you the achievement that I have accomplished through the use of Assume App. \nFor the past'**
  String get shareDialogFront;

  /// No description provided for @shareDialogEnd.
  ///
  /// In en, this message translates to:
  /// **'days, I have been continuously completing my tasks without any interruptions. \n\nYou can access Assume App by clicking on this link: https://sites.google.com/view/assumeapp.'**
  String get shareDialogEnd;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// No description provided for @logOutAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logOutAlertTitle;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @logOutAlertContent.
  ///
  /// In en, this message translates to:
  /// **'Caution: If you are an anonymous user, your data will be lost.'**
  String get logOutAlertContent;

  /// No description provided for @privacyLink.
  ///
  /// In en, this message translates to:
  /// **'https://sites.google.com/view/assumeapp/privacy'**
  String get privacyLink;

  /// No description provided for @privacyLinkError.
  ///
  /// In en, this message translates to:
  /// **'Could not launch'**
  String get privacyLinkError;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @dayUpper.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayUpper;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @sec.
  ///
  /// In en, this message translates to:
  /// **'Sec'**
  String get sec;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @timeSpent.
  ///
  /// In en, this message translates to:
  /// **'Time Spent'**
  String get timeSpent;

  /// No description provided for @updateTime.
  ///
  /// In en, this message translates to:
  /// **'Updated Time'**
  String get updateTime;

  /// No description provided for @notUpdated.
  ///
  /// In en, this message translates to:
  /// **'Not Updated'**
  String get notUpdated;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @emailEmptyVal.
  ///
  /// In en, this message translates to:
  /// **'Email address cannot be left blank'**
  String get emailEmptyVal;

  /// No description provided for @emailVal.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailVal;

  /// No description provided for @passwordEmptyVal.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be left blank'**
  String get passwordEmptyVal;

  /// No description provided for @passwordRuleVal.
  ///
  /// In en, this message translates to:
  /// **'Your password must be at least 8 characters'**
  String get passwordRuleVal;

  /// No description provided for @passwordVal.
  ///
  /// In en, this message translates to:
  /// **'Your password not valid'**
  String get passwordVal;

  /// No description provided for @nameEmptyVal.
  ///
  /// In en, this message translates to:
  /// **'Full name cannot be left blank'**
  String get nameEmptyVal;

  /// No description provided for @nameRuleVal.
  ///
  /// In en, this message translates to:
  /// **'Write your full name corectly'**
  String get nameRuleVal;

  /// No description provided for @defaultEmptyVal.
  ///
  /// In en, this message translates to:
  /// **'cannot be left blank'**
  String get defaultEmptyVal;

  /// No description provided for @defaultEmptyValFront.
  ///
  /// In en, this message translates to:
  /// **'must be at least'**
  String get defaultEmptyValFront;

  /// No description provided for @defaultEmptyValFront2.
  ///
  /// In en, this message translates to:
  /// **'must be at most'**
  String get defaultEmptyValFront2;

  /// No description provided for @defaultEmptyValEnd.
  ///
  /// In en, this message translates to:
  /// **'characters'**
  String get defaultEmptyValEnd;

  /// No description provided for @emailOrPasswordWrong.
  ///
  /// In en, this message translates to:
  /// **'Email or password is wrong'**
  String get emailOrPasswordWrong;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @anErrorOccured.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get anErrorOccured;

  /// No description provided for @successfullyLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Successfully logged in'**
  String get successfullyLoggedIn;

  /// No description provided for @codeIsCorrect.
  ///
  /// In en, this message translates to:
  /// **'Code is correct'**
  String get codeIsCorrect;

  /// No description provided for @codeNotCorrect.
  ///
  /// In en, this message translates to:
  /// **'Code is not correct'**
  String get codeNotCorrect;

  /// No description provided for @emailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email not found'**
  String get emailNotFound;

  /// No description provided for @passwordsNotSame.
  ///
  /// In en, this message translates to:
  /// **'Passwords are not same'**
  String get passwordsNotSame;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @codeSentEmailSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Code sent to email successfully'**
  String get codeSentEmailSuccessfully;

  /// No description provided for @errorResetPassword.
  ///
  /// In en, this message translates to:
  /// **'An error occured while trying to send password reset email'**
  String get errorResetPassword;

  /// No description provided for @assumeMissionTime.
  ///
  /// In en, this message translates to:
  /// **'Assume: Mission Time'**
  String get assumeMissionTime;

  /// No description provided for @missionTitle.
  ///
  /// In en, this message translates to:
  /// **'Title:'**
  String get missionTitle;

  /// No description provided for @successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully:'**
  String get successfully;

  /// No description provided for @missionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Missions not found:'**
  String get missionNotFound;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return L10nEn();
    case 'tr': return L10nTr();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
