//
//  PlayerDAO.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

struct PlayerDAO: Equatable {
  let color: UIColor
  var name: String
  
  mutating func updateName(newName: String) {
    self.name = newName
  }
}
