//
//  DashboardView.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 29/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DashboardViewImpl: UIViewController {
  //
  // MARK: - Constants
  //
  let presenter: DashboardPresenterInterface
  //
  // MARK: - Variables And Properties
  //
  var stackView: UIStackView!
  
  required init(presenter: DashboardPresenterImpl) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    
    self.view.backgroundColor = .white
    self.setViewProperties()
    self.addSubviewsAndConstraints()
    self.presenter.getColumns().forEach {
      $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    self.presenter.gameResult.bind { result in
      if !result.isEmpty {
        self.showAlert(status: result)
      }
    }
    
    self.presenter.titleString.bind { title in
      self.title = title
    }
    
    self.presenter.initGame()
  }
  
  //
  // MARK: - Private Methods
  //
  private func setViewProperties(){
    
    for (index, button) in self.presenter.getColumns().enumerated() {
      button.tag = index
    }
    
    self.stackView = {
      let stackView = UIStackView (
        arrangedSubviews: self.presenter.getColumns()
      )
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      stackView.spacing = 2
      return stackView
    }()
  }
  
  private func addSubviewsAndConstraints() {
    [
      stackView
    ].forEach {
      guard let newView = $0 else { return }
      view.addSubview(newView)
      newView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    self.stackView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetBoard))
    
  }
  
  @objc private func buttonTapped(sender: UIButton) {
    if !presenter.gameResult.value.isEmpty {
      self.showAlert(status: presenter.gameResult.value)
    } else {
      guard let newChip = self.presenter.insertChip(in: sender.tag) else { return }
      self.view.addSubview(newChip)
    }
  }
  
  @objc private func resetBoard(sender: UIButton) {
    presenter.resetBoard()
  }
  
  func showAlert(status: String) {
    let alert = UIAlertController(title: "Game Over", message: "\(status)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alert, animated: true, completion: nil)
  }
}
