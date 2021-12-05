//
//  HomeView.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 29/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewImpl: UIViewController {
  
  let presenter: HomePresenterInterface
  
  required init(presenter: HomePresenterImpl) {
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
    
    self.startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    
    self.presenter.firstPlayer.bind { player in
      guard let playerName = player?.name else { return }
      DispatchQueue.main.async {
        self.userATextField.text = playerName
      }
    }
    
    self.presenter.secondPlayer.bind { player in
      guard let playerName = player?.name else { return }
      DispatchQueue.main.async {
        self.userBTextField.text = playerName
      }
    }
    
    self.presenter.startGameButtonText.bind { newText in
      DispatchQueue.main.async {
        self.startButton.setTitle(newText, for: .normal)
      }
    }
  }
  
  @objc private func startTapped(sender: UIButton) {
    self.presenter.startGame()
  }
  
  // MARK: View properties
  var viewTitle: UILabel!
  var userATextField: UITextField!
  var userBTextField: UITextField!
  var startButton: UIButton!
  
  func setViewProperties() {
    
    self.viewTitle = {
      let titleLabel = UILabel ()
      titleLabel.numberOfLines = 2
      titleLabel.text = self.presenter.titleText.value
      return titleLabel
    }()
    
    self.userATextField = {
      let textField = UITextField()
      textField.placeholder = "Insert name or play with default"
      textField.backgroundColor = .groupTableViewBackground
      textField.addTarget(self, action: #selector(textFieldADidChange(_:)), for: .editingChanged)
      return textField
    }()
    
    self.userBTextField = {
      let textField = UITextField()
      textField.placeholder = "Insert name or play with default"
      textField.backgroundColor = .groupTableViewBackground
      textField.addTarget(self, action: #selector(textFieldBDidChange(_:)), for: .editingChanged)
      return textField
    }()
    
    self.startButton = {
      let button = UIButton()
      button.backgroundColor = .lightGray
      button.titleLabel?.font = .systemFont(ofSize: 14)
      button.setTitle(self.presenter.startGameButtonText.value, for: .normal)
      button.setTitleColor(.black, for: .normal)
      return button
    }()
  }
  
  func addSubviewsAndConstraints() {
    [
      self.viewTitle,
      self.userATextField,
      self.userBTextField,
      self.startButton].forEach {
        guard let newView = $0 else { return }
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
      }
    
    self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
    self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    
    self.userATextField.anchor(top: self.viewTitle.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: 400, height: 40))
    self.userATextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    
    self.userBTextField.anchor(top: self.userATextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 400, height: 40))
    self.userBTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    
    self.startButton.anchor(top: self.userBTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 400, height: 40))
    self.startButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    
  }
  
  @objc func textFieldADidChange(_ textField: UITextField) {
    guard let newText = self.userATextField.text else { return }
    self.presenter.updatePlayerTextField(player: 0, newText: newText)
  }
  
  @objc func textFieldBDidChange(_ textField: UITextField) {
    guard let newText = self.userBTextField.text else { return }
    self.presenter.updatePlayerTextField(player: 1, newText: newText)
  }
}
