# Mynotes Learning Context

- This is a Flutter course project based on the approximately 37-hour freeCodeCamp Flutter video on YouTube: https://youtu.be/VPvVD8t02U8
- The learner was at roughly the 18-hour mark on June 20, 2026.
- The purpose of this project is to learn Flutter and prepare to build original apps in Visual Studio Code.
- Git reference for reusable login and Firebase authentication code: commit `dd40333` (`step-10`) is the last commit before SQLite/local CRUD functionality was introduced. Commit `6a7a0fb` (`step-11`) begins the SQLite work.
- Git reference for the completed local SQLite CRUD phase: commit `c986fbc` (`step-18`) is the clean checkpoint immediately before the course begins moving notes from local CRUD storage to Firebase. Preserve this reference for future explanations and reuse of the CRUD architecture.
- As of after `step-18`, the course is transitioning from local SQLite CRUD notes to Firebase-backed notes. The learner expects to revisit the CRUD code later and may need a thorough conceptual explanation of how its database, cache, streams, models, and views work together.
- Key Firebase transition noted by the learner: the Firestore implementation no longer needs the manually managed notes `StreamController` used by the SQLite CRUD service. Firestore supplies real-time data streams directly through snapshot listeners, reducing the need for a separate local cache-and-broadcast layer.
- Next planned learning task as of June 22, 2026: begin the next session with an explanation of the Firebase cloud-storage code introduced in `step-19`, especially `firebase_cloud_storage.dart`, `cloud_note.dart`, the storage constants, and the cloud-storage exceptions.
- Git reference `abc9192` (`step-22`) is a deliberate course deviation/detour to test BLoC by implementing a counter. Treat it as a learning checkpoint for BLoC concepts rather than the main notes-app architecture.
- Treat the existing course code and architecture as intentional unless there is a clear bug.
- Preserve the learner's work and the course's direction. Do not redesign or rewrite large sections unless explicitly requested.
- Explain errors, fixes, and Flutter/Dart concepts in beginner-friendly language so the learner understands what changed and why.
- For explanations, use a concise high-level picture or small diagram only when it materially helps show how pieces relate; do not force one into every answer. For larger explanations, continue section by section and explain each section's purpose, connection to the overall flow, and why it matters. Avoid dry inventories of methods and line-by-line code paraphrasing.
- When suggesting a code fix, keep the natural explanation and amount of surrounding code appropriate to the problem. Use a `diff` block with green `+` lines to clearly highlight additions or changes. Do not repeat the entire function unless it is genuinely needed.
- When implementing a fix, keep it focused and avoid introducing concepts far beyond the learner's current stage without explanation.
- Track useful project-specific context from future questions when it will help maintain learning continuity.
