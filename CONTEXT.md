# Raylib Haskell Wrapper

This project gives Haskell programs access to Raylib while preserving Raylib's vocabulary and making resource lifetimes explicit.

## Language

### Rendering

**Window**:
Raylib's single process-global graphical window and drawing context. It is not a native handle returned by Raylib.

**Drawing**:
One frame bounded by Raylib's `BeginDrawing` and `EndDrawing` operations.
_Avoid_: Render session, drawing session

**Mode**:
A temporary Raylib rendering context nested inside Drawing, such as 2D, 3D, texture, shader, blend, or scissor mode.

**Color**:
An RGBA value whose channels are 8-bit red, green, blue, and alpha components.

### API layers

**Public API**:
The idiomatic Haskell interface used by applications. It owns marshalling and offers scoped operations where Raylib requires balanced lifecycles.
_Avoid_: Safe bindings

**Raw binding**:
An internal, mechanically named Haskell declaration corresponding directly to a Raylib C operation.
_Avoid_: Public FFI

**Shim**:
A small C adapter for a Raylib macro or a C signature that Haskell FFI cannot represent portably, such as a structure passed by value.
_Avoid_: Wrapper

**Domain**:
A cohesive area of Raylib functionality—Core, Input, Shapes, Textures, Text, Models, Audio, or Math—that owns both public operations and raw bindings.

### Lifetimes

**Resource**:
A Raylib value acquired by a load or initialization operation and released by its matching unload or close operation.

**Lifecycle operation**:
A Haskell operation that starts or ends a Raylib lifecycle, such as `initWindow`, `closeWindow`, `beginDrawing`, or `endDrawing`. The caller is responsible for balancing lifecycle operations.

**Lifecycle half**:
One operation from a balanced Raylib pair, such as begin/end, load/unload, or initialize/close. A lifecycle half places balancing responsibility on its caller.
