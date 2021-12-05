//
//  DashboardMockInteractor.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ConnectFourApp

class DashboardMockInteractor: DashboardInteractorInterface {
  
  let mockPlayers = [
    Player(name: "Sue", color: UIColor(red: 1, green: 0, blue: 0, alpha: 1)),
    Player(name: "Henry", color: UIColor(red: 0, green: 0, blue: 1, alpha: 1))
  ]
  
  let mockDAOPlayers = [
    PlayerDAO(color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), name: "Sue"),
    PlayerDAO(color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), name: "Henry")
  ]
  
  var board: BoardInterface
  
  init() {
    board = Board(firstPlayer: mockPlayers[0], secondPlayer: mockPlayers[1])
  }
  
  func insertChip(in column: Int) -> (row: Int?, color: UIColor?) {
    return (0, mockPlayers[1].color)
  }
  
  func getBoardSize() -> Int {
    return 7
  }
  
  func hasFinished() -> String? {
    return "\(mockPlayers[0].name) wins"
  }
  
  func getCurrentPlayer() -> PlayerDAO {
    return PlayerDAO(color: mockPlayers[0].color, name: mockPlayers[0].name)
  }
  
  func resetBoard() {
    board = Board(firstPlayer: mockPlayers[0], secondPlayer: mockPlayers[1])
  }
}
