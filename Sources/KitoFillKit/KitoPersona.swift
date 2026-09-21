//
//  KitoPersona.swift
//  KitoFillKit
//
//  Created by Wycliff on 9/20/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//

/// A coherent synthetic identity — the values it holds agree with each
/// other (the email is derived from the name, the phone matches the locale)
/// so a filled form looks like a real person, not a grid of random tokens.
public struct KitoPersona: Sendable {
    public var firstName: String
    public var lastName: String
    public var email: String
    public var phone: String
    public var addressLine: String
    public var city: String

    public var fullName: String { "\(firstName) \(lastName)" }

    public init(firstName: String, lastName: String, email: String, phone: String, addressLine: String, city: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.addressLine = addressLine
        self.city = city
    }
}
