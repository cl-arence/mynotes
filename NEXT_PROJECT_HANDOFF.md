# Next Project Handoff

This file exists so the next project can reuse the best parts of `mynotes` without needing to rediscover them from scratch.

## Next project

- A dog daycare staff scheduling app for Puptown Girls Dog Lounge & Spa.
- Theme reference: https://www.puptowngirls.ca/
- Intended tone: warm, playful, friendly, service-oriented, dog-focused, approachable for staff, but still practical for scheduling managers.

## Expected product shape

- Staff submit their availability for a month.
- Managers create and adjust schedules from that availability.
- Likely roles: staff, manager, admin.
- Likely features: auth, availability entry, monthly schedule view, shift assignment, shift edits, notifications, and Firebase-backed real-time updates.

## Reuse from mynotes

Use `mynotes` as the reference architecture unless there is a clear reason not to.

- Folder structure:
  - `lib/views` for screens
  - `lib/services/auth` for auth abstractions and provider code
  - `lib/services/auth/bloc` for auth BLoC, events, and states
  - `lib/services/cloud` for Firestore services and models
  - `lib/constants` for routes and shared constants
  - `lib/utilities/dialogs` or `lib/helpers` for reusable UI helpers
- Firebase patterns:
  - Firebase initialization in `main.dart`
  - auth provider abstraction instead of coupling UI directly to Firebase Auth
  - Firestore stream-based data flow instead of custom local stream plumbing where Firebase already provides snapshots
- UI direction worth reusing:
  - polished auth screens
  - cohesive branding/theme setup
  - better empty/loading/error states
  - release-ready Android app identity and bundle workflow

## Best checkpoint references

- `dd40333` (`step-10`): reusable Firebase auth baseline before SQLite CRUD
- `c986fbc` (`step-18`): completed local CRUD architecture reference
- `a747c44` (`step-19`): start of Firebase cloud notes
- `6a80179` (`step-27`): BLoC-based auth-flow baseline
- `5f226c0` (`step-32`): official course-complete checkpoint
- `ef6260d`: MindPad UI revamp and improved verification flow
- `mindpad-revamp-v1`: tag for the post-course modernization milestone
- `mindpad-v1.2.0-build4`: tag for the first tester build after the revamp

## Recommended starting point for the new repo

Scaffold the generic reusable app shell first, then add scheduling-specific features.

Start with:

- Firebase project setup
- login/register/logout/forgot-password/email-verification flow
- auth provider abstraction
- auth BLoC
- loading/error dialog helpers
- app theme and branded auth screens
- Firestore service/model pattern

Then add:

- staff profile and role model
- availability submission model
- monthly scheduling model
- manager scheduling tools
- shift swap / approval flow if needed

## Important migration note

The new project will likely live in a different folder, repo, and Firebase project. A future Codex chat may not automatically have filesystem access to this `mynotes` repo.

If that happens, do one of these at the start of the new chat:

1. Tell the agent to read this file from the `mynotes` repo if the workspace can see it.
2. Copy this file into the new repo.
3. Paste the relevant parts of this file into the new chat.

## Guidance for future agents

- Default to a `mynotes`-like architecture for the scheduling app.
- Reuse and adapt proven auth and Firebase patterns instead of inventing a new structure.
- Keep explanations beginner-friendly and maintainable.
- Preserve momentum and keep simple operational tasks lightweight.
