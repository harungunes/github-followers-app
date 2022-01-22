//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Harun Gunes on 22/01/2022.
//

import UIKit

class GFItemInfoVC: UIViewController {
  
  let stackView = UIStackView()
  
  let itemOne = GFItemInfoView()
  let itemTwo = GFItemInfoView()
  let actionButton = GFButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBackgroundView()
    layoutUI()
    configureStackView()
  }
  
  func configureBackgroundView() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
    
    
  }
  
  private func configureStackView() {
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    
    stackView.addArrangedSubview(itemOne)
    stackView.addArrangedSubview(itemTwo)
  }
  
  private func layoutUI() {
    view.addSubview(stackView)
    view.addSubview(actionButton)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
