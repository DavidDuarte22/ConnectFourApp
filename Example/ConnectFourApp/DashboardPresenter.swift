//
//  DashboardPresenter.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

// Protocol for View Layer
protocol DashboardPresenterInterface {
  var currentPlayerName: Observable<String> { get set }
  var gameResult: Observable<String> { get set }
  var titleString: Observable<String> { get set }
  func getColumns() -> [ChipButton]
  func insertChip(in column: Int) -> UIView?
  func initGame()
  func resetBoard()
}

protocol DashboardPresenterInputInterface {
  var placedChips: [[UIView]] { get set }
  var columns: [ChipButton] { get set }
  var dashboardRouter: DashboardRouterInterface? { get set }
  var dashboardInteractor: DashboardInteractorInterface? { get set }
  
  func insertChipInLogic(in column: Int) -> (row: Int?, color: UIColor?)
  func insertChipInView(inColumn column: Int, row: Int, color: UIColor) -> UIView?
}

class DashboardPresenterImpl: DashboardPresenterInterface {
  
  var currentPlayerName = Observable<String>("")
  var gameResult = Observable<String>("")
  var titleString = Observable<String>("")
  
  // Internal properties
  var placedChips = [[UIView]]()
  var columns = [
    ChipButton(), ChipButton(), ChipButton(),
    ChipButton(), ChipButton(), ChipButton(), ChipButton()
  ]
  
  var dashboardRouter: DashboardRouterInterface?
  var dashboardInteractor: DashboardInteractorInterface?
  
  func initGame() {
    setTitle()
    guard let size = dashboardInteractor?.getBoardSize() else { return }
    for _ in 0 ..< size {
      placedChips.append([UIView]())
    }
  }
  
  func getColumns() -> [ChipButton] {
    return self.columns
  }
  
  func resetBoard() {
    dashboardInteractor?.resetBoard()
    self.gameResult.value = ""
    
    for i in 0 ..< placedChips.count {
      for chip in placedChips[i] {
        chip.removeFromSuperview()
      }
      
      placedChips[i].removeAll(keepingCapacity: true)
    }
  }
  
  func insertChip(in column: Int) -> UIView? {
    let (row, chip) = insertChipInLogic(in: column)
    if let row = row, let chip = chip,
       let newChipView = insertChipInView(inColumn: column, row: row, color: chip) {
      return newChipView
    }
    return nil
  }
}

extension DashboardPresenterImpl: DashboardPresenterInputInterface {
  
  func insertChipInLogic(in column: Int) -> (row: Int?, color: UIColor?) {
    guard self.gameResult.value.isEmpty else { return (nil, nil) }
    if let (row, color) = dashboardInteractor?.insertChip(in: column) {
      return (row, color)
    }
    return (nil, nil)
  }
  
  func insertChipInView(inColumn column: Int, row: Int, color: UIColor) -> UIView? {
    let button = self.columns[column]
    let size = min(button.frame.width, button.frame.height / 6)
    let rect = CGRect(x: 0, y: 0, width: size - 15, height: size - 15)
    
    let newChip = ChipView(rect: rect, backgroundColor: color)
    newChip.center = positionForChip(inColumn: column, row: row)

    if (placedChips[column].count < row + 1) {
      placedChips[column].append(newChip)
      hasFinished()
      return newChip
    }
    
    return nil
  }
  
  private func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
    let button = self.columns[column]
    let size = min(button.frame.width, button.frame.height / 6)
    
    let xOffset = button.frame.midX
    var yOffset = button.frame.maxY + 10
    yOffset -= (size - 10) * CGFloat(row)
    return CGPoint(x: xOffset, y: yOffset)
  }
  
  private func setTitle() {
    guard let name = dashboardInteractor?.getCurrentPlayer().name else { return }
    self.currentPlayerName.value = name
    self.titleString.value = "\(currentPlayerName.value)'s turn"
  }
  
  private func hasFinished() {
    if let gameResult = dashboardInteractor?.hasFinished() {
      self.gameResult.value = gameResult
      self.titleString.value = gameResult
    } else {
      setTitle()
    }
  }
}
