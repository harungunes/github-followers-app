//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Harun Gunes on 15/12/2021.
//
import UIKit

class FollowerListVC: UIViewController {
  
  enum Section { case main }
  
  var username: String!
  var followers: [Follower] = []
  var page = 1
  var hasMoreFollowers = true
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    configureCollectionView()
    getFollowers(username: username, page: page)
    configureDataSource()
  }
  
  private func configure() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    collectionView.delegate = self
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }
  
  func getFollowers(username: String, page: Int) {
    showLoadingView()
    
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      
      #warning("Call dismiss")
      guard let self = self else { return }
      
      switch result {
      case .success(let followers):
        if followers.count < 100 {
          self.hasMoreFollowers = false
        }
        self.followers = followers
        self.updateData()
        
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad stuff happened here", message: error.rawValue, buttonTitle: "Ok")
      }
      
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
      cell.set(follower: follower)
      return cell
    })
  }
  
  func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
}

extension FollowerListVC: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.height
    
    if offsetY > contentHeight - height {
      guard hasMoreFollowers else { return }
      
      page += 1
      getFollowers(username: username, page: page)
    }
  }
}
