//
//  Board.swift
//  ConnectFourApp
//
//

import Foundation

public protocol BoardInterface {
  func add(chip: UIColor, in column: Int) -> Int?
  func hasFinished() -> GameResult?
  func getOpponent() -> Player
  func getCurrentPlayer() -> Player
  func updateCurrentPlayer()
}

public class Board: NSObject {
  public static var height = 6
  public static var width = 7
  
  public var slots = [UIColor]()
  
  public var players: [Player]
  public var currentPlayer: Player // 2
  
  public init(firstPlayer: Player, secondPlayer: Player) {
    for _ in 0 ..< Board.width * Board.height {
      slots.append(.clear)
    }
    
    self.players = [firstPlayer, secondPlayer]
    currentPlayer = firstPlayer
    
    super.init()
  }
  
  func nextEmptySlot(in column: Int) -> Int? {
    for row in 0 ..< Board.height {
      if chip(inColumn: column, row: row) == .clear {
        return row
      }
    }
    
    return nil
  }
  
  func chip(inColumn column: Int, row: Int) -> UIColor? {
    return slots[safe: (row + column * Board.height)]
  }
  
  func set(chip: UIColor, in column: Int, row: Int) {
    slots[row + column * Board.height] = chip
  }
  
  func isFull() -> Bool {
    for column in 0 ..< Board.width {
      if canMove(in: column) {
        return false
      }
    }
    
    return true
  }
  
  func canMove(in column: Int) -> Bool {
    return nextEmptySlot(in: column) != nil
  }
  
  func hasPreviousMovedWin() -> Player? {
    let chip = getOpponent().color
    
    for row in 0 ..< Board.height {
      for col in 0 ..< Board.width {
        if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 0) {
          return getOpponent()
        } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 0, moveY: 1) {
          return getOpponent()
        } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 1) {
          return getOpponent()
        } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: -1) {
          return getOpponent()
        }
      }
    }
    
    return nil
  }
  
  func squaresMatch(initialChip: UIColor, row: Int, col: Int, moveX: Int, moveY: Int) -> Bool {
    // bail out early if we can't win from here
    if row + (moveY * 3) < 0 { return false }
    if row + (moveY * 3) >= Board.height { return false }
    if col + (moveX * 3) < 0 { return false }
    if col + (moveX * 3) >= Board.width { return false }
    
    // still here? Check every square
    if chip(inColumn: col, row: row) != initialChip { return false }
    if chip(inColumn: col + moveX, row: row + moveY) != initialChip { return false }
    if chip(inColumn: col + (moveX * 2), row: row + (moveY * 2)) != initialChip { return false }
    if chip(inColumn: col + (moveX * 3), row: row + (moveY * 3)) != initialChip { return false }
    
    return true
  }
}

public enum GameResult: String {
  case playerAWin
  case playerBWin
  case draw
}

extension Board: BoardInterface {
  public func updateCurrentPlayer() {
    if currentPlayer == players[0] {
      self.currentPlayer = players[1]
    } else {
      self.currentPlayer = players[0]
    }
  }
  
  public func getCurrentPlayer() -> Player {
    return currentPlayer
  }
  
  public func hasFinished() -> GameResult? {
    if let winner = hasPreviousMovedWin() {
      return (winner == players[0]) ? GameResult.playerAWin : GameResult.playerBWin
    } else if isFull() {
      return GameResult.draw
    }
    return nil
  }
  
  public func add(chip: UIColor, in column: Int) -> Int? {
    if let row = nextEmptySlot(in: column) {
      set(chip: chip, in: column, row: row)
      return row
    }
    return nil
  }
  
  public func getOpponent() -> Player {
    return (currentPlayer == players[0]) ? players[1] : players[0]
  }
}

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
