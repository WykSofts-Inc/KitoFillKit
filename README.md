# KitoFillKit

Fills SwiftUI forms with coherent, reproducible synthetic data for QA/dev
speed — a seeded persona generator plus a lightweight field registry.
**Debug/QA tooling — never link into a release build.** See
[KitoDevKitDebug](https://github.com/WykSofts-Inc/KitoDevKitDebug).

## Install

```swift
#if DEBUG
.package(url: "https://github.com/WykSofts-Inc/KitoFillKit.git", from: "1.0.0"),
#endif
```

## Samples

**Quick random values:**
```swift
let persona = KitoFillKit.randomPersona()
emailField = persona.email
```

**Reproducible bug reports — same seed, same persona, every time:**
```swift
let persona = KitoFillKit.randomPersona(seed: 42)
// share "seed: 42" in the bug report instead of a screenshot of the data
```

**Register a sign-up form's fields, fill them all with one tap:**
```swift
struct SignUpScreen: View {
    @State private var form = KitoFillableForm()
    @State private var email = ""
    @State private var name = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name).kitoFillable("name", form: form, binding: $name)
            TextField("Email", text: $email).kitoFillable("email", form: form, binding: $email)

            #if DEBUG
            Button("Fill with test data") {
                form.fill(withPersona: .randomPersona(), mapping: [
                    "name": \.fullName,
                    "email": \.email,
                ])
            }
            #endif
        }
    }
}
```

## License

MIT
