//
//  HomePresenterTests.swift
//  ConnectFourApp_ExampleTests
//
//  Created by David Duarte on 05/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import ConnectFourApp_Example


class HomePresenterTests: XCTestCase {
  
  var firstPlayer = Observable<PlayerDAO?>(nil)
  var secondPlayer = Observable<PlayerDAO?>(nil)
  
  var presenter: HomePresenterImpl!
  
  override func setUp() {
    presenter = HomePresenterImpl()
    presenter.homeInteractor = HomeMockInteractor(networkManager: NetworkManagerMock())
    super.setUp()
  }
  
  func testGetDefaultInfo_OK() {
    presenter.getDefaultInfo()
    
    let firstPlayer = self.presenter.firstPlayer.value
    let secondPlayer = self.presenter.secondPlayer.value
    
    XCTAssertEqual(firstPlayer?.name, "Sue")
    XCTAssertEqual(secondPlayer?.name, "Henry")
  }
  
  func testEmptyPlayer_OK() {
    var player = PlayerDAO(color: .red, name: "Sue")
    var result = presenter.isPlayerEmpty(player: player)
    XCTAssertFalse(result)
    player.updateName(newName: "")
    result = presenter.isPlayerEmpty(player: player)
    XCTAssertTrue(result)
  }
  
  func testDefaultButtonText_OK() {
    XCTAssertEqual(presenter.startGameButtonText.value, "Get default values")
  }
  
  func testUpdateButtonText_OK() {
    presenter.getDefaultInfo()
    XCTAssertEqual(presenter.startGameButtonText.value, "Let's go!")
  }
  
  func testUpdatePlayerTextField_OK() {
    presenter.getDefaultInfo()
    presenter.updatePlayerTextField(player: 0, newText: "David")
    presenter.updatePlayerTextField(player: 1, newText: "Susan")
    XCTAssertEqual(presenter.firstPlayer.value?.name, "David")
    XCTAssertEqual(presenter.secondPlayer.value?.name, "Susan")
  }
  
  func testUpdatePlayerTextField_updateButtonText_OK() {
    presenter.getDefaultInfo()
    presenter.updatePlayerTextField(player: 0, newText: "")
    XCTAssertEqual(presenter.startGameButtonText.value, "Get default values")
  }
}
