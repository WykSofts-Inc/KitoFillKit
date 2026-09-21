// swift-tools-version: 5.9
//
//  Package.swift
//  KitoFillKit
//
//  Created by Wycliff on 9/20/26.
//  Copyright © 2026 wyksoftsinc.com. All rights reserved.
//


import PackageDescription

let package = Package(
    name: "KitoFillKit",
    platforms: [.iOS(.v17)],
    products: [.library(name: "KitoFillKit", targets: ["KitoFillKit"])],
    targets: [
        .target(name: "KitoFillKit"),
        .testTarget(name: "KitoFillKitTests", dependencies: ["KitoFillKit"]),
    ]
)
