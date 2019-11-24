// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Cacher",
	platforms: [
		.iOS(.v9)
	],
	products: [
		.library(
			name: "Cacher",
			targets: [
				"Cacher"
		]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "Cacher",
			dependencies: []),
		.testTarget(
			name: "CacherTests",
			dependencies: [
				"Cacher"
		]),
	]
)
