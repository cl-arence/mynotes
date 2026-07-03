import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
    : super(const AuthStateUninitialized(isLoading: true)) {
    // Register
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(exception: null, isLoading: false));
    });

    // Forgot password
    on<AuthEventForgotPassword>((event, emit) async {
      emit(
        const AuthStateForgotPassword(
          exception: null,
          hasSentEmail: false,
          isLoading: false,
        ),
      );
      final email = event.email;
      if (email == null) {
        return; // user just wants to go to forgot-password screen
      }

      // user wants to actually send a forgot-password email
      emit(
        const AuthStateForgotPassword(
          exception: null,
          hasSentEmail: false,
          isLoading: true,
        ),
      );

      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendPasswordReset(toEmail: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }

      emit(
        AuthStateForgotPassword(
          exception: exception,
          hasSentEmail: didSendEmail,
          isLoading: false,
        ),
      );
    });

    // Send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      final currentState = state;
      final user = currentState is AuthStateLoggedIn
          ? currentState.user
          : provider.currentUser;

      if (user == null || user.isEmailVerified || user.isAnonymous) {
        return;
      }

      emit(
        AuthStateLoggedIn(
          user: user,
          isLoading: true,
          loadingText: 'Sending verification email...',
        ),
      );

      try {
        await provider.sendEmailVerification();
        emit(
          AuthStateLoggedIn(
            user: user,
            isLoading: false,
            hasSentEmailVerification: true,
          ),
        );
      } on Exception catch (e) {
        emit(
          AuthStateLoggedIn(
            user: user,
            isLoading: false,
            verificationException: e,
          ),
        );
      }
    });

    on<AuthEventRefreshCurrentUser>((event, emit) async {
      final currentState = state;
      final user = currentState is AuthStateLoggedIn
          ? currentState.user
          : provider.currentUser;

      if (user == null) {
        return;
      }

      emit(
        AuthStateLoggedIn(
          user: user,
          isLoading: true,
          loadingText: 'Checking verification...',
        ),
      );

      try {
        await provider.refreshCurrentUser();
        final refreshedUser = provider.currentUser;
        if (refreshedUser == null) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        } else {
          emit(
            AuthStateLoggedIn(
              user: refreshedUser,
              isLoading: false,
              hasCheckedEmailVerification: true,
            ),
          );
        }
      } on Exception catch (e) {
        emit(
          AuthStateLoggedIn(
            user: user,
            isLoading: false,
            verificationException: e,
          ),
        );
      }
    });

    // Register
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      late final AuthUser user;
      try {
        user = await provider.createUser(email: email, password: password);
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
        return;
      }

      try {
        await provider.sendEmailVerification();
        emit(
          AuthStateLoggedIn(
            user: user,
            isLoading: false,
            hasSentEmailVerification: true,
          ),
        );
      } on Exception catch (e) {
        emit(
          AuthStateLoggedIn(
            user: user,
            isLoading: false,
            verificationException: e,
          ),
        );
      }
    });

    // Initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      try {
        await provider.refreshCurrentUser();
      } catch (_) {
        // No signed-in user yet, so there is nothing to refresh.
      }
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    });

    // Log in
    on<AuthEventLogIn>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait while I log you in...',
        ),
      );
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    // Log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
