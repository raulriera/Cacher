//
//  Cacher.swift
//  Cacher
//
//  Created by Raul Riera on 2017-07-08.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import Foundation

final public class Cacher {
	let destination: URL
	private let queue = OperationQueue()
	
	public enum CacheDestination {
		case temporary
		case atFolder(String)
	}
	
	// MARK: Initialization
	
	public init(destination: CacheDestination) {
		switch destination {
		case .temporary:
			self.destination = URL(fileURLWithPath: NSTemporaryDirectory())
		case .atFolder(let folder):
			let documentFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
			self.destination = URL(fileURLWithPath: documentFolder).appendingPathComponent(folder, isDirectory: true)
		}
		
		try? FileManager.default.createDirectory(at: self.destination, withIntermediateDirectories: true, attributes: nil)
	}
	
	// MARK
	
	public func persist(item: Cachable, completion: @escaping (_ url: URL?) -> Void) {
		var url: URL?
		
		// Create an operation to process the request.
		let operation = BlockOperation {
			url = self.persist(data: item.transform(), at: self.destination.appendingPathComponent(item.fileName, isDirectory: false))
		}
		
		// Set the operation's completion block to call the request's completion handler.
		operation.completionBlock = {
			completion(url)
		}
		
		// Add the operation to the queue to start the work.
		queue.addOperation(operation)
	}
	
	
	/// Load cached data from the directory
	///
	/// - Parameter fileName: of the cached data stored in the file system
	/// - Returns: the decoded cached data (if any)
	public func load<T: Cachable & Codable>(fileName: String) -> T? {
		guard
			let data = try? Data(contentsOf: destination.appendingPathComponent(fileName, isDirectory: false)),
			let decoded = try? JSONDecoder().decode(T.self, from: data)
			else { return nil }
		return decoded
	}
	
	// MARK: Private
	
	private func persist(data: Data, at url: URL) -> URL? {
		do {
			try data.write(to: url, options: [.atomicWrite])
			return url
		} catch {
			return nil
		}
	}
}

public protocol Cachable {
	var fileName: String { get }
	func transform() -> Data
}

extension Cachable where Self: Codable {
	public func transform() -> Data {
		guard let encoded = try? JSONEncoder().encode(self) else {
			fatalError("Unable to encode object")
		}
		return encoded
	}
}
