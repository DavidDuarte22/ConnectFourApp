//
//  DashboardPresenterTests.swift
//  ConnectFourApp_ExampleTests
//
//  Created by David Duarte on 05/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import ConnectFourApp_Example

// TODO: Improve tests. Error/Failed responses
class DashboardPresenterTests: XCTestCase {
  
  let presenter = DashboardPresenterImpl()
  let interactor = DashboardMockInteractor()
  
  override func setUpWithError() throws {
    presenter.dashboardInteractor = interactor
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  func testInsertChipInView_OK() {
    presenter.initGame()
    let _ = presenter.insertChipInView(inColumn: 0, row: 0, color: interactor.getCurrentPlayer().color)
    let _ = presenter.insertChipInView(inColumn: 0, row: 1, color: interactor.getCurrentPlayer().color)
    XCTAssertEqual(presenter.placedChips[0].count, 2)
  }
  
  func testInsertChipInLogic_OK() {
    let (row, color) = presenter.insertChipInLogic(in: 0)
    
    XCTAssertEqual(row, 0)
    XCTAssertEqual(color, interactor.mockDAOPlayers[1].color)
    
  }
  
  func testInsertChipInLogic_NotOK() {
    // TODO: Mock interactor to send a failed response
  }
  
  func testInsertChip_OK() {
    presenter.initGame()
    let view = presenter.insertChip(in: 0)
    XCTAssertTrue(view != nil)
  }
  
  func testInsertChip_NotOK() {
    // TODO: Mock interactor to send a failed response
  }
  
  func testDashboardInitGame_OK() {
    presenter.initGame()
    XCTAssertEqual(presenter.placedChips.count, 7)
  }
  
  func testGetColumns_OK() {
    XCTAssertEqual(presenter.getColumns().count, 7)
  }
}
