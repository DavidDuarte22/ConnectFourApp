//
//  Player.swift
//  ConnectFourApp
//
//  Created by David Duarte on 01/12/2021.
//

import Foundation
import GameplayKit

public struct Player: Equatable {
  public var name: String
  public var color: UIColor
  
  public init(name: String, color: UIColor) {
      self.name = name
      self.color = color
  }
}
