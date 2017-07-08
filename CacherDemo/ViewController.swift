//
//  ViewController.swift
//  CacherDemo
//
//  Created by Raul Riera on 2017-07-08.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import UIKit
import Cacher

class ViewController: UIViewController {
	@IBOutlet weak var textField: UITextField!
	
	// Create a cacher and use the temporary directory
	let cacher: Cacher = Cacher(destination: .temporary)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		if let cachedText: CachableText = cacher.load(fileName: "text") {
			// Replace the current text with the cached one
			textField.text = cachedText.value
		}
	}
	
	@IBAction func didPressCache(_ sender: UIButton) {
		let cachableText = CachableText(value: textField.text ?? "")
		cacher.persist(item: cachableText) { url in
			print("Text persisted in \(String(describing: url))")
		}
	}
}

// Use Codable for an implicient implementation of `transform`
fileprivate struct CachableText: Cachable, Codable {
	let fileName: String = "text"
	let value: String
}
