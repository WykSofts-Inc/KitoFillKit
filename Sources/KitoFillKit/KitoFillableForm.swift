//
//  KitoFillableForm.swift
//  KitoFillKit
//
//  Created by Wycliff on 9/20/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//

import SwiftUI

/// A `String`-keyed binding registry a form exposes, and a keypath-free way
/// for FillKit to write into arbitrary `@State`/ViewModel fields without the
/// form author writing per-field glue for the debug tool. Register once,
/// fill from anywhere (a debug button, a shake gesture, a UI test).
@Observable
public final class KitoFillableForm {
    private var fields: [String: Binding<String>] = [:]

    public init() {}

    public func register(_ key: String, binding: Binding<String>) {
        fields[key] = binding
    }

    public func fill(with values: [String: String]) {
        for (key, value) in values {
            fields[key]?.wrappedValue = value
        }
    }

    public func fill(withPersona persona: KitoPersona, mapping: [String: KeyPath<KitoPersona, String>]) {
        var values: [String: String] = [:]
        for (key, path) in mapping {
            values[key] = persona[keyPath: path]
        }
        fill(with: values)
    }

    public func clearAll() {
        for key in fields.keys { fields[key]?.wrappedValue = "" }
    }
}

public extension View {
    /// Registers this text field's binding under `key` in `form`, so FillKit
    /// can write to it later without the field itself knowing FillKit exists.
    func kitoFillable(_ key: String, form: KitoFillableForm, binding: Binding<String>) -> some View {
        onAppear { form.register(key, binding: binding) }
    }
}
