# ``KitoFillKit``

Fills SwiftUI forms with coherent, reproducible synthetic data for development and QA.

## Overview

KitoFillKit generates a ``KitoPersona`` — a synthetic identity whose values agree
with each other, so the email is derived from the name and the phone number
matches the locale. Pass a seed to ``KitoFillKit/KitoFillKit/randomPersona(seed:)`` and the
same persona comes back every time, which lets a bug report quote a seed instead
of a screenshot of the data.

A ``KitoFillableForm`` is a lightweight registry of string bindings. Register
each field with the `kitoFillable(_:form:binding:)` modifier, then fill every
field at once from a debug button, a shake gesture or a UI test.

```swift
struct SignUpScreen: View {
    @State private var form = KitoFillableForm()
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name).kitoFillable("name", form: form, binding: $name)
            TextField("Email", text: $email).kitoFillable("email", form: form, binding: $email)

            #if DEBUG
            Button("Fill with test data") {
                form.fill(withPersona: KitoFillKit.randomPersona(seed: 42), mapping: [
                    "name": \.fullName,
                    "email": \.email,
                ])
            }
            #endif
        }
    }
}
```

KitoFillKit is debug and QA tooling. Add the package dependency inside
`#if DEBUG` and never link it into a release build.

## Topics

### Generating Data

- ``KitoFillKit/KitoFillKit``
- ``KitoPersona``

### Filling Forms

- ``KitoFillableForm``
