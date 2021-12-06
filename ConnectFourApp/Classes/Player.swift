//
//  Player.swift
//  ConnectFourApp
//
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
