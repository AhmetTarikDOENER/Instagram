//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
        
        return searchBar
    }()
    
    private var models = [UserPost]()
    private var collectionView: UICollectionView?
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        configureCollectionView()
        setCollectionViewDelegateDatasource()
        searchBar.delegate = self
        view.addSubview(dimmedView)
        setGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
    }
    
    //MARK: - Private
    
    private func setGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4) / 3, height: (view.width - 4) / 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
    }
    
    private func setCollectionViewDelegateDatasource() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

}

//MARK: - UICollectionView Delegate & Datasource

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(debug: "testImage")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let model = models[indexPath.row]
        let user = User(
            username: "Joe",
            bio: "",
            name: (first: "", last: ""),
            birthDate: Date(),
            profilePhoto: URL(string: "https://www.google.com")!,
            gender: .male,
            counts: UserCount(followers: 1, following: 1, post: 1),
            joinDate: Date()
        )
        
        let post = UserPost(
            identifier: "",
            postType: .photo,
            thumbnailImage: URL(string: "https://www.google.com")!,
            postURL: URL(string: "https://www.google.com")!,
            caption: nil,
            likeCount: [],
            comments: [],
            createdDate: Date(),
            taggedUsers: [],
            owner: user
        )
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UISearchbar Delegate

extension ExploreViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.4
        }
    }
    
    
    @objc func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0
        }) {
            done in
            if done {
                self.dimmedView.isHidden = true
            }
        }
    }
    
    private func query(_ text: String) {
        // Perform the search in the backend.
    }
}
