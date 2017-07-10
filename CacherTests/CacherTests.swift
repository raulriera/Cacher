//
//  CacherTests.swift
//  CacherTests
//
//  Created by Raul Riera on 2017-07-08.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import XCTest
@testable import Cacher

class CacherTests: XCTestCase {
	func testPersistCachableItemAtTemporaryFolder() {
		let expectation = self.expectation(description: "Wrote file in folder")
		
		Cacher(destination: .temporary)?.persist(item: CachableText(text: "Raul Riera")) { url, _ in
			#if os(OSX)
				let tempFolder = "T"
			#else
				let tempFolder = "tmp"
			#endif
						
			if url!.absoluteString.contains("/\(tempFolder)/testFile.txt") {
				expectation.fulfill()
			}
		}
		
		waitForExpectations(timeout: 1, handler: nil)
	}
	
	func testPersistCachableItemAtCustomFolder() {
		let expectation = self.expectation(description: "Wrote file in folder")
		
		Cacher(destination: .atFolder("/test-folder"))?.persist(item: CachableText(text: "Raul Riera")) { url, _ in
			if url!.absoluteString.contains("/test-folder/testFile.txt") {
				expectation.fulfill()
			}
		}
		
		waitForExpectations(timeout: 1, handler: nil)
	}
}

private class CachableText: Cachable {
	let text: String
	var fileName: String {
		return "testFile.txt"
	}
	
	init(text: String) {
		self.text = text
	}
	
	func transform() -> Data {
		return text.data(using: .utf8)!
	}
}
