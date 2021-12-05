//
//  XCTestCase.swift
//  ConnectFourApp_ExampleTests
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest

// MARK: - Helper Methods

extension XCTestCase {
  func loadStub(name: String, extension: String) -> Data {
    // Obtain Reference to Bundle
    let bundle = Bundle(for: type(of: self))
    
    // Ask Bundle for URL of Stub
    let url = bundle.url(forResource: name, withExtension: `extension`)
    
    // Use URL to Create Data Object
    return try! Data(contentsOf: url!)
  }
}


