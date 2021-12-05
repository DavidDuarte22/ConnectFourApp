//
//  HomePresenter.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol HomePresenterInterface {
  var titleText: Observable<String> { get set }
  var firstPlayer: Observable<PlayerDAO?> { get set }
  var secondPlayer: Observable<PlayerDAO?> { get set }
  var startGameButtonText: Observable<String> { get set }
  
  func updatePlayerTextField(player: Int, newText: String)
  func startGame()
  
}

protocol HomePresenterInputInterface {
  func getDefaultInfo()
  func updateButtonText()
  func isPlayerEmpty(player: PlayerDAO?) -> Bool
}

class HomePresenterImpl: HomePresenterInterface {
  
  var homeRouter: HomeRouterInterface?
  var homeInteractor: HomeInteractorInterface?
  
  // MARK: View properties
  var titleText = Observable<String>("Please input the players names or play with default values")
  var startGameButtonText = Observable<String>("Get default values")
  var firstPlayer = Observable<PlayerDAO?>(nil)
  var secondPlayer = Observable<PlayerDAO?>(nil)
  
  // TODO: Optimize how is checking if the user empty (or with an empty name).
  func startGame() {
    if let firstPlayer = self.firstPlayer.value, firstPlayer.name != "",
       let secondPlayer = self.secondPlayer.value, secondPlayer.name != "" {
      homeRouter?.navigateToDashboard(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
    } else {
      getDefaultInfo()
    }
  }
  
  func updatePlayerTextField(player: Int, newText: String) {
    if player == 0 {
      if self.firstPlayer.value?.name != nil {
        self.firstPlayer.value?.updateName(newName: newText)
      } else {
        self.firstPlayer.value = PlayerDAO(color: .blue, name: newText)
      }
    }
    if player == 1 {
      if self.secondPlayer.value?.name != nil {
        self.secondPlayer.value?.updateName(newName: newText)
      } else {
        self.secondPlayer.value = PlayerDAO(color: .red, name: newText)
      }
    }
    updateButtonText()
  }
}

extension HomePresenterImpl: HomePresenterInputInterface {
  
  internal func getDefaultInfo() {
    homeInteractor?.getDefaultPlayersInfo() { [weak self] result in
      switch result {
      case .success(let players):
        self?.firstPlayer.value = players[0]
        self?.secondPlayer.value = players[1]
        self?.updateButtonText()
      case .failure(_):
        // TODO: Navigate to error page
        break
      }
    }
  }
  
  internal func updateButtonText() {
    if !isPlayerEmpty(player: firstPlayer.value) && !isPlayerEmpty(player: secondPlayer.value) {
      self.startGameButtonText.value = "Let's go!"
    } else {
      self.startGameButtonText.value = "Get default values"
    }
  }
  
  func isPlayerEmpty(player: PlayerDAO?) -> Bool {
    if player == nil || player?.name == "" { return true }
    return false
  }
}

