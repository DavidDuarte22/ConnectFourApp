//
//  ChipButton.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 30/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ChipButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    layer.borderWidth = 1
  }
}
