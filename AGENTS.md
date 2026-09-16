# Haskell rules

Use these language extensions as project defaults:

- `DuplicateRecordFields`
- `NoFieldSelectors`
- `OverloadedRecordDot`
- `OverloadedStrings`
- `LambdaCase`
- `MultiWayIf`
- `DerivingVia`
- `NamedFieldPuns`
- `TypeApplications`

Use these compiler options as project defaults:

- `-Wno-name-shadowing`
- `-Wno-type-defaults`

Keep these configured even when unused.

# Raylib binding conventions

Public ergonomic wrappers are intentional API features. Keep helpers such as `unlessWindowShouldClose` when they make common Raylib control flow easier to use; judge them by caller ergonomics, not by implementation size or the number of current call sites.

When adding a Raylib domain such as Input, follow this structure:

1. Add `src/Raylib/<Domain>.hs` for the public API. Export explicitly, use lower camel case names matching Raylib (`isKeyDown` for `IsKeyDown`), accept ordinary Haskell types, and perform all C marshalling here.
2. Implement an operation entirely in Haskell whenever ordinary Haskell values can provide it without Raylib runtime state. Omit the raw declaration and FFI in that case; the pure `textSubtext` implementation is intentional.
3. Add `src/Raylib/Internal/Foreign/<Domain>.hs` for operations that require raw declarations. Keep C types internal and name new declarations `c<RaylibName>`, such as `cIsKeyDown`.
4. Put shared public data types and their `Storable` instances in `Raylib.Types`. Marshal C integer fields with their exact `C*` types; do not peek or poke a C `unsigned int` as Haskell `Word`.
5. Call representable Raylib functions directly with `foreign import capi`. Add a C shim only for macros or unsupported signatures such as structs passed or returned by value.
6. Name every C shim `HS<RaylibName>` with no underscore, for example `HSPlayAudioStream`. The Haskell `foreign import ccall` symbol must match it exactly.
7. Register the public module under `exposed-modules`, the raw module under `other-modules`, and re-export the public module from `Raylib`.
8. Finish when `cabal build all` and `git diff --check` both pass and every requested operation is exported from `Raylib`.

Use explicit imports and export lists. Format Haskell with four-space indentation and trailing commas in multiline lists; format C with four-space indentation and opening braces on the declaration line. Bind only named operations when the request lists them. A bare “implement `<Domain>` module” request means bind every operation in that domain's section of the installed `raylib.h`.
