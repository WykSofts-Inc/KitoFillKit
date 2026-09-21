//
//  KitoFillKit.swift
//  KitoFillKit
//
//  Created by Wycliff on 9/20/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//

import Foundation

/// Generates coherent synthetic form data for development/QA speed.
/// Debug/QA tooling — never link into a release build.
public enum KitoFillKit {
    private static let firstNames = ["Amara", "Brian", "Chiara", "David", "Esther", "Felix", "Grace", "Hassan"]
    private static let lastNames = ["Mwangi", "Otieno", "Kamau", "Njeri", "Wanjiru", "Kariuki", "Achieng", "Barasa"]
    private static let cities = ["Nairobi", "Mombasa", "Kisumu", "Nakuru", "Eldoret"]

    /// A deterministic seeded generator lets a flaky-form bug report include
    /// a seed instead of a screenshot — reproduce the exact same "random"
    /// persona by reusing it.
    public static func randomPersona(seed: UInt64? = nil) -> KitoPersona {
        var generator: RandomNumberGenerator = seed.map { SeededGenerator(seed: $0) } ?? SystemRandomNumberGenerator()
        let first = firstNames.randomElement(using: &generator) ?? "Amara"
        let last = lastNames.randomElement(using: &generator) ?? "Mwangi"
        let city = cities.randomElement(using: &generator) ?? "Nairobi"
        let phoneSuffix = String(format: "%07d", Int.random(in: 0...9_999_999, using: &generator))

        return KitoPersona(
            firstName: first,
            lastName: last,
            email: "\(first.lowercased()).\(last.lowercased())@example.com",
            phone: "+254 7\(phoneSuffix.prefix(2)) \(phoneSuffix.suffix(6))",
            addressLine: "\(Int.random(in: 1...999, using: &generator)) Kenyatta Ave",
            city: city
        )
    }

    public static func randomEmail(seed: UInt64? = nil) -> String {
        randomPersona(seed: seed).email
    }

    public static func randomPhone(seed: UInt64? = nil) -> String {
        randomPersona(seed: seed).phone
    }
}

/// A tiny deterministic PRNG (splitmix64) — not cryptographic, and not meant
/// to be; the only requirement is "the same seed always produces the same
/// persona," for reproducible bug reports.
struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}
