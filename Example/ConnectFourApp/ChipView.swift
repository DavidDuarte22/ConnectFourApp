//
//  ChipView.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ChipView: UIView {
  
  init(rect: CGRect, backgroundColor: UIColor) {
    super.init(frame: rect)
    self.isUserInteractionEnabled = false
    self.backgroundColor = backgroundColor
    self.layer.cornerRadius = frame.size.width / 2
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
