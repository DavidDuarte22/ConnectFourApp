//
//  DashboardInteractorTests.swift
//  ConnectFourApp_ExampleTests
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import ConnectFourApp_Example

// TODO: Mock Board.
class DashboardInteractorTests: XCTestCase {

  var interactor: DashboardInteractorInterface?
  
  let mockPlayers = [
    PlayerDAO(color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), name: "Sue"),
    PlayerDAO(color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), name: "Henry")
  ]
  
  override func setUp() {
    interactor = DashboardInteractorImpl(firstPlayer: mockPlayers[0], secondPlayer: mockPlayers[1])
    super.setUp()
  }
  
  func testGetCurrentPlayer_OK() {
    let result = interactor?.getCurrentPlayer()
    let expected = mockPlayers[0]
    XCTAssertEqual(expected, result)
  }
  
  func testGetCurrentUser_afterMove_OK() {
    interactor?.board.updateCurrentPlayer()
    let result = interactor?.getCurrentPlayer()
    let expected = mockPlayers[1]
    XCTAssertEqual(expected, result)
  }
  
  func testInsertChip_firstMove_OK() {
    let nextPlayerColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
    if let (row, color) = interactor?.insertChip(in: 0) {
      XCTAssertEqual(row, 0)
      XCTAssertEqual(color, nextPlayerColor)
    }
  }
  
  func testInsertChip_firstMove_NotOK() {
    if let (row, color) = interactor?.insertChip(in: 8),
       row != nil, color != nil
    {
      XCTFail()
    } else {
      XCTAssert(true, "Pass")
    }
  }
  
  func testGetBoardSize_OK() {
    XCTAssertEqual(interactor?.getBoardSize(), 7)
  }
  
  func testResetBoard_OK() {
    let _ = interactor?.insertChip(in: 0)
    let _ = interactor?.insertChip(in: 0)
    let _ = interactor?.insertChip(in: 0)

    interactor?.resetBoard()
      
    if let (row, color) = interactor?.insertChip(in: 0) {
      XCTAssertEqual(row, 0)
      XCTAssertEqual(color, mockPlayers[1].color)
    } else {
      XCTFail()
    }
  }
  
  // TODO: Improve with stubs
  func testHasFinished_OK1() {
    if let _ = interactor?.hasFinished() { XCTFail() }
    
    let _ = [interactor?.insertChip(in: 0), interactor?.insertChip(in: 1),
           interactor?.insertChip(in: 0), interactor?.insertChip(in: 1),
           interactor?.insertChip(in: 0), interactor?.insertChip(in: 1),
           interactor?.insertChip(in: 0) ]
    
    if let result = interactor?.hasFinished() {
      XCTAssertEqual(result, "\(mockPlayers[0].name) wins")
    }
  }
  
  func testHasFinished_O2() {
    if let _ = interactor?.hasFinished() { XCTFail() }
    
    let _ = [interactor?.insertChip(in: 2), interactor?.insertChip(in: 1),
           interactor?.insertChip(in: 0), interactor?.insertChip(in: 1),
           interactor?.insertChip(in: 0), interactor?.insertChip(in: 1),
           interactor?.insertChip(in: 0), interactor?.insertChip(in: 1) ]
    
    if let result = interactor?.hasFinished() {
      XCTAssertEqual(result, "\(mockPlayers[1].name) wins")
    }
  }
  
  func testHasFinished_Draw_OK() {
    let _ = [interactor?.insertChip(in: 0), interactor?.insertChip(in: 0),
             interactor?.insertChip(in: 0), interactor?.insertChip(in: 0),
             interactor?.insertChip(in: 0), interactor?.insertChip(in: 0),
             
             interactor?.insertChip(in: 1), interactor?.insertChip(in: 1),
             interactor?.insertChip(in: 1), interactor?.insertChip(in: 1),
             interactor?.insertChip(in: 1), interactor?.insertChip(in: 1),
             
             interactor?.insertChip(in: 2), interactor?.insertChip(in: 2),
             interactor?.insertChip(in: 2), interactor?.insertChip(in: 2),
             interactor?.insertChip(in: 2), interactor?.insertChip(in: 2),
             
             interactor?.insertChip(in: 4),
             
             interactor?.insertChip(in: 3), interactor?.insertChip(in: 3),
             interactor?.insertChip(in: 3), interactor?.insertChip(in: 3),
             interactor?.insertChip(in: 3), interactor?.insertChip(in: 3),
             
             interactor?.insertChip(in: 4), interactor?.insertChip(in: 4),
             interactor?.insertChip(in: 4), interactor?.insertChip(in: 4),
             interactor?.insertChip(in: 4),
             
             interactor?.insertChip(in: 5), interactor?.insertChip(in: 5),
             interactor?.insertChip(in: 5), interactor?.insertChip(in: 5),
             interactor?.insertChip(in: 5), interactor?.insertChip(in: 5),
             
             interactor?.insertChip(in: 6), interactor?.insertChip(in: 6),
             interactor?.insertChip(in: 6), interactor?.insertChip(in: 6),
             interactor?.insertChip(in: 6), interactor?.insertChip(in: 6),
    ]
    
    if let result = interactor?.hasFinished() {
      XCTAssertEqual(result, "It's a draw!")
    }
  }
}
