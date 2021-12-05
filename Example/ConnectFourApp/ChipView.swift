//
//  ChipView.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 30/11/2021.
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
