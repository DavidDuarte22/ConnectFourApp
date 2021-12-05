//
//  ConnectFourApp_ExampleTests.swift
//  ConnectFourApp_ExampleTests
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import ConnectFourApp_Example

class HomeInteractorTests: XCTestCase {

  var interactor: HomeInteractorInterface?
  var networkManagerMock: NetworkManagerInterface?
  
  override func setUp() {
    interactor = HomeInteractorImpl(networkManager: NetworkManagerMock())
    super.setUp()
  }
  
  func testParseIntoDAO_Ok() {
    let mockData = [DefaultInfo(id: 123, color1: "#FF0000", color2: "#0000FF", name1: "Sue", name2: "Henry")]
    let result = interactor?.parseIntoDao(defaultInfo: mockData)

    let expectedResult = [
      PlayerDAO(color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), name: "Sue"),
      PlayerDAO(color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), name: "Henry")
    ]

    XCTAssertEqual(result, expectedResult)
  }
  
  func testParseIntoDAO_NotOK_emptyName1Service() {
    let mockData = [DefaultInfo(id: 123, color1: "#FF0000", color2: "#0000FF", name1: nil, name2: "Henry")]
    let result = interactor?.parseIntoDao(defaultInfo: mockData)

    XCTAssertEqual(result, nil)
  }
  
  func testParseIntoDAO_NotOK_emptyName2Service() {
    let mockData = [DefaultInfo(id: 123, color1: "#FF0000", color2: "#0000FF", name1: "Sue", name2: nil)]
    let result = interactor?.parseIntoDao(defaultInfo: mockData)

    XCTAssertEqual(result, nil)
  }
  
  func testParseIntoDAO_NotOK_emptyColor1Service() {
    let mockData = [DefaultInfo(id: 123, color1: nil, color2: "#0000FF", name1: "Sue", name2: "Henry")]
    let result = interactor?.parseIntoDao(defaultInfo: mockData)

    XCTAssertEqual(result, nil)
  }
  
  func testParseIntoDAO_NotOK_emptyColorService() {
    let mockData = [DefaultInfo(id: 123, color1: "#FF0000", color2: nil, name1: "Sue", name2: "Henry")]
    let result = interactor?.parseIntoDao(defaultInfo: mockData)

    XCTAssertEqual(result, nil)
  }
  
  // TODO: Define when the name and/or color could be invalidate
  /// i.e. if the name is empty or with spaces.

  //
  // Testing with network mocked
  func testGetDefaultPlayersInfo_OK() {
    let expectation = self.expectation(description: "Fetching")
    var result: Result<[PlayerDAO], NetworkError>?
    interactor?.getDefaultPlayersInfo() { res in
      result = res
      expectation.fulfill()
    }
    waitForExpectations(timeout: 2, handler: nil)

    switch result {
    case .success(let players):
      XCTAssertEqual(players.count, 2)
    
    case .failure(_):
        XCTFail()
      
    case .none:
      XCTFail()
    }
  }
  
  // TODO: Test Error closure.
}
