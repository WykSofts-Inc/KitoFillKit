//
//  KitoFillKitTests.swift
//  KitoFillKit
//
//  Created by Wycliff on 9/20/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//

import XCTest
@testable import KitoFillKit

final class KitoFillKitTests: XCTestCase {
    func testSameSeedProducesSamePersona() {
        let a = KitoFillKit.randomPersona(seed: 42)
        let b = KitoFillKit.randomPersona(seed: 42)
        XCTAssertEqual(a.email, b.email)
        XCTAssertEqual(a.phone, b.phone)
    }

    func testDifferentSeedsProduceVariety() {
        // Two arbitrary small seeds CAN legitimately collide by chance on an
        // 8-element name list (~1/8 per list) — that's not a generator bug,
        // it's the birthday problem on a tiny sample. Assert variety across
        // enough seeds that the only way this fails is a real flaw (e.g. the
        // generator ignoring its seed entirely).
        let emails = Set((0..<20).map { KitoFillKit.randomPersona(seed: UInt64($0)).email })
        XCTAssertGreaterThan(emails.count, 1, "20 different seeds produced only one distinct persona")
    }

    func testGeneratorDiffusesAdjacentSeeds() {
        // A real correctness check of the RNG itself, independent of name-list
        // size: two adjacent seeds must not produce the same raw 64-bit output.
        var a = SeededGenerator(seed: 1)
        var b = SeededGenerator(seed: 2)
        XCTAssertNotEqual(a.next(), b.next())
    }

    func testPersonaEmailDerivedFromName() {
        let persona = KitoFillKit.randomPersona(seed: 7)
        XCTAssertTrue(persona.email.contains(persona.firstName.lowercased()))
    }
}
