//
//  DashboardInteractor.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ConnectFourApp

protocol DashboardInteractorInterface {
  var board: BoardInterface { get set }
  func insertChip(in column: Int) -> (row: Int?, color: UIColor?)
  func getBoardSize() -> Int
  func hasFinished() -> String?
  func getCurrentPlayer() -> PlayerDAO
  func resetBoard()
}

class DashboardInteractorImpl: DashboardInteractorInterface {
  
  var board: BoardInterface
  
  private var firstPlayer: Player
  private var secondPlayer: Player
  
  // TODO: I.D.
  init(firstPlayer: PlayerDAO, secondPlayer: PlayerDAO) {
    self.firstPlayer = Player(name: firstPlayer.name, color: firstPlayer.color)
    self.secondPlayer = Player(name: secondPlayer.name, color: secondPlayer.color)
    
    self.board = Board(
      firstPlayer: self.firstPlayer,
      secondPlayer: self.secondPlayer)
  }
  
  func getBoardSize() -> Int {
    return Board.width
  }
  
  func getCurrentPlayer() -> PlayerDAO {
    let playerBoard = board.getCurrentPlayer()
    let playerDAO = PlayerDAO(color: playerBoard.color, name: playerBoard.name)
    return playerDAO
  }
  
  func insertChip(in column: Int) -> (row: Int?, color: UIColor?) {
    guard let row = board.add(chip: board.getCurrentPlayer().color, in: column) else {
      return (row: nil, color: nil)
    }
    
    // TO DO: Function change turn
    board.updateCurrentPlayer()
    return (row, board.getCurrentPlayer().color)
  }
  
  func hasFinished() -> String? {
    let result = board.hasFinished()
    switch result {
    case .playerAWin:
      return "\(firstPlayer.name) wins"
    case .playerBWin:
      return "\(secondPlayer.name) wins"
    case .draw:
      return "It's a draw!"
    case .none:
      return nil
    }
  }
  
  func resetBoard() {
    board = Board(firstPlayer: self.firstPlayer, secondPlayer: self.secondPlayer)
  }
}
