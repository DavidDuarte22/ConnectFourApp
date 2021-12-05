//
//  HomeRouter.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol HomeRouterInterface {
  func navigateToDashboard(firstPlayer: PlayerDAO, secondPlayer: PlayerDAO)
}

class HomeRouterImpl: HomeRouterInterface {
  
  weak var viewController: UIViewController?
  
  func navigateToDashboard(firstPlayer: PlayerDAO, secondPlayer: PlayerDAO) {
    viewController?.navigationController?.pushViewController(DashboardModule.build(firstPlayer: firstPlayer, secondPlayer: secondPlayer), animated: true)
  }
}
