//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Harun Gunes on 14/12/2021.
//

import UIKit

class SearchVC: UIViewController {
  
  // MARK: - Properties
  
  let logoImageView = UIImageView()
  let usernameTextField = GFTextField()
  let searchButton = GFButton(backgroungColor: .systemGreen, title: "Get Followers")
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoImageView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  // MARK: - Helpers
  
  func configureLogoImageView() {
    view.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = UIImage(named: "gh-logo")
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
}
