//
//  HomeRouter.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 29/11/2021.
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
