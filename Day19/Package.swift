// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Day19",
	products: [
		// Products define the executables and libraries produced by a package, and make them visible to other packages.
		.library(
			name: "Day19",
			targets: ["Day19"]),
	],
	dependencies: [
		// Dependencies declare other packages that this package depends on.
		.package(path: "../IntCode")
	],
	targets: [
		// Targets are the basic building blocks of a package. A target can define a module or a test suite.
		// Targets can depend on other targets in this package, and on products in packages which this package depends on.
		.target(
			name: "Day19",
			dependencies: ["IntCode"]),
		.testTarget(
			name: "Day19Tests",
			dependencies: ["Day19"]),
	]
)
