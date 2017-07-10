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
	
	public init?(destination: CacheDestination) {
		switch destination {
		case .temporary:
			self.destination = URL(fileURLWithPath: NSTemporaryDirectory())
		case .atFolder(let folder):
			let documentFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
			self.destination = URL(fileURLWithPath: documentFolder).appendingPathComponent(folder, isDirectory: true)
		}
		
		do {
			try FileManager.default.createDirectory(at: self.destination, withIntermediateDirectories: true, attributes: nil)
		} catch {
			return nil
		}
	}
	
	// MARK
	
	public func persist(item: Cachable, completion: @escaping (_ url: URL?, _ error: Error?) -> Void) {
		var url: URL?
		var error: Error?
		
		// Create an operation to process the request.
		let operation = BlockOperation {
			do {
				url = try self.persist(data: item.transform(), at: self.destination.appendingPathComponent(item.fileName, isDirectory: false))
			} catch let persistError {
				error = persistError
			}
		}
		
		// Set the operation's completion block to call the request's completion handler.
		operation.completionBlock = {
			completion(url, error)
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
	
	private func persist(data: Data, at url: URL) throws -> URL {
		do {
			try data.write(to: url, options: [.atomicWrite])
			return url
		} catch let error {
			throw error
		}
	}
}

public protocol Cachable {
	var fileName: String { get }
	func transform() -> Data
}

extension Cachable where Self: Codable {
	public func transform() -> Data {
		do {
			let encoded = try JSONEncoder().encode(self)
			return encoded
		} catch let error {
			fatalError("Unable to encode object: \(error)")
		}
	}
}
