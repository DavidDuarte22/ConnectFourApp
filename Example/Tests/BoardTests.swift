import XCTest
import ConnectFourApp
@testable import ConnectFourApp_Example

// TODO: Test Logic Framework
class BoardTests: XCTestCase {
    
  var board: BoardInterface!
  let players = [Player(name: "Sue", color: UIColor(red: 1, green: 0, blue: 0, alpha: 1)),
                 Player(name: "Henry", color: UIColor(red: 0, green: 0, blue: 1, alpha: 1))
  ]

  override func setUp() {
    
    board = Board(firstPlayer: players[0], secondPlayer: players[1])
//    interactor = HomeInteractorImpl()
    super.setUp()
  }
  
  func testGetCurrentPlayer_OK() {
    let currentPlayer = board.getCurrentPlayer()
    XCTAssertEqual(currentPlayer, players[0])
  }

  func testAddChip_OK() {
    var row = board.add(chip: players[0].color, in: 0)
    XCTAssertEqual(row, 0)
    row = board.add(chip: players[1].color, in: 0)
    XCTAssertEqual(row, 1)
  }
  
  func testFullColumn_OK() {
    var row = board.add(chip: players[0].color, in: 0)
    row = board.add(chip: players[1].color, in: 0)
    row = board.add(chip: players[0].color, in: 0)
    row = board.add(chip: players[1].color, in: 0)
    row = board.add(chip: players[0].color, in: 0)
    row = board.add(chip: players[1].color, in: 0)
    XCTAssertEqual(row, 5)
    row = board.add(chip: players[1].color, in: 0)
    XCTAssertEqual(row, nil)
  }
  
  func testUpdateCurrentPlayer_OK() {
    board.updateCurrentPlayer()
    var currentOpponent = board.getCurrentPlayer()
    XCTAssertEqual(currentOpponent, players[1])
    
    board.updateCurrentPlayer()
    currentOpponent = board.getCurrentPlayer()
    XCTAssertEqual(currentOpponent, players[0])
  }
  
  func testGetOpponent_OK() {
    var currentOpponent = board.getOpponent()
    XCTAssertEqual(currentOpponent, players[1])
    board.updateCurrentPlayer()
    currentOpponent = board.getOpponent()
    XCTAssertEqual(currentOpponent, players[0])
  }
  
  func testHasFinished_NotOK() {
    let _ = board.add(chip: players[0].color, in: 0)
    XCTAssertNil(board.hasFinished())
  }
  
  func testHasFinished_WinA_Vertical_OK() {
    let _ = board.add(chip: players[0].color, in: 0)
    let _ = board.add(chip: players[0].color, in: 0)
    let _ = board.add(chip: players[0].color, in: 0)
    let _ = board.add(chip: players[0].color, in: 0)
    board.updateCurrentPlayer()
    XCTAssertEqual(GameResult.playerAWin, board.hasFinished())
  }
  
  func testHasFinished_WinB_Vertical_OK() {
    board.updateCurrentPlayer()
    let _ = board.add(chip: players[1].color, in: 0)
    let _ = board.add(chip: players[1].color, in: 0)
    let _ = board.add(chip: players[1].color, in: 0)
    let _ = board.add(chip: players[1].color, in: 0)
    board.updateCurrentPlayer()
    XCTAssertEqual(GameResult.playerBWin, board.hasFinished())
  }
  
  func testHasFinished_WinA_Horizontal_OK() {
    let _ = board.add(chip: players[0].color, in: 0)
    let _ = board.add(chip: players[0].color, in: 1)
    let _ = board.add(chip: players[0].color, in: 2)
    let _ = board.add(chip: players[0].color, in: 3)
    board.updateCurrentPlayer()
    XCTAssertEqual(GameResult.playerAWin, board.hasFinished())
  }
  
  func testHasFinished_WinB_Horizontal_OK() {
    board.updateCurrentPlayer()
    let _ = board.add(chip: players[1].color, in: 0)
    let _ = board.add(chip: players[1].color, in: 1)
    let _ = board.add(chip: players[1].color, in: 2)
    let _ = board.add(chip: players[1].color, in: 3)
    board.updateCurrentPlayer()
    XCTAssertEqual(GameResult.playerBWin, board.hasFinished())
  }
  
  func testHasFinished_WinA_Diagonal_OK() {
    let _ = board.add(chip: players[0].color, in: 0)
    let _ = board.add(chip: players[1].color, in: 1)
    let _ = board.add(chip: players[0].color, in: 1)
    let _ = board.add(chip: players[1].color, in: 2)
    let _ = board.add(chip: players[1].color, in: 2)
    let _ = board.add(chip: players[0].color, in: 2)
    let _ = board.add(chip: players[0].color, in: 3)
    let _ = board.add(chip: players[1].color, in: 3)
    let _ = board.add(chip: players[0].color, in: 3)
    let _ = board.add(chip: players[0].color, in: 3)
    //       X
    //     X X
    //   X O O
    // X O O X
    board.updateCurrentPlayer()
    XCTAssertEqual(GameResult.playerAWin, board.hasFinished())
  }
  
  func testHasFinished_WinB_Diagonal_OK() {
    let _ = board.add(chip: players[1].color, in: 0)
    let _ = board.add(chip: players[0].color, in: 1)
    let _ = board.add(chip: players[1].color, in: 1)
    let _ = board.add(chip: players[0].color, in: 2)
    let _ = board.add(chip: players[0].color, in: 2)
    let _ = board.add(chip: players[1].color, in: 2)
    let _ = board.add(chip: players[1].color, in: 3)
    let _ = board.add(chip: players[0].color, in: 3)
    let _ = board.add(chip: players[1].color, in: 3)
    let _ = board.add(chip: players[1].color, in: 3)
    //       O
    //     O O
    //   O X X
    // O X X O
    board.updateCurrentPlayer()
    XCTAssertEqual(GameResult.playerAWin, board.hasFinished())
  }
  
  func testHasFinished_Draw_OK() {
    for _ in 0...5 {
     let _ = board.add(chip: players[0].color, in: 0)
     let _ = board.add(chip: players[1].color, in: 0)
    }
    
    for _ in 0...5 {
     let _ = board.add(chip: players[0].color, in: 1)
     let _ = board.add(chip: players[1].color, in: 1)
    }
    
    // O O
    // X X
    // O O
    // X X
    // O O
    // X X
    
    for _ in 0...5 {
     let _ = board.add(chip: players[1].color, in: 2)
     let _ = board.add(chip: players[0].color, in: 2)
    }
    
    for _ in 0...5 {
     let _ = board.add(chip: players[1].color, in: 3)
     let _ = board.add(chip: players[0].color, in: 3)
    }
    
    // O O X X
    // X X O O
    // O O X X
    // X X O O
    // O O X X
    // X X O O
    
    for _ in 0...5 {
     let _ = board.add(chip: players[0].color, in: 4)
     let _ = board.add(chip: players[1].color, in: 4)
    }
    
    for _ in 0...5 {
     let _ = board.add(chip: players[0].color, in: 5)
     let _ = board.add(chip: players[1].color, in: 5)
    }
    
    for _ in 0...5 {
     let _ = board.add(chip: players[0].color, in: 6)
     let _ = board.add(chip: players[1].color, in: 6)
    }
    
    // O O X X O O O
    // X X O O X X X
    // O O X X O O O
    // X X O O X X X
    // O O X X O O O
    // X X O O X X X
    
    XCTAssertEqual(GameResult.draw, board.hasFinished())

  }
}
