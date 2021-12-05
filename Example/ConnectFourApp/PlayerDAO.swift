//
//  PlayerDAO.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 02/12/2021.
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
