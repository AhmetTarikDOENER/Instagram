//
//  ViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.cellIdentifier)
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.cellIdentifier)
        tableView.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.cellIdentifier)
        tableView.register(FeedPostActionsTableViewCell.self, forCellReuseIdentifier: FeedPostActionsTableViewCell.cellIdentifier)
        tableView.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.cellIdentifier)
        
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(tableView)
        createMockModels()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Private
    
    private func setTableViewDelegateDatasource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
    private func createMockModels() {
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
        
        var comments = [PostComments]()
        for x in 0..<2 {
            comments.append(PostComments(identifier: "\(x)", username: "@jenny", text: "this is the best post i have seen", createdDate: Date(), likes: []))
        }
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                comments: PostRenderViewModel(renderType: .comments(comments: comments))
            )
            feedRenderModels.append(viewModel)
        }
    }
}

//MARK: - UITableView Delegate and Datasource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0 {
            // Header
            return 1
        } else if subSection == 1 {
            // Post
            return 1
        } else if subSection == 2 {
            // Actions
            return 1
        } else if subSection == 3 {
            // Comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0 {
            // Header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.cellIdentifier, for: indexPath) as! FeedPostHeaderTableViewCell
                return cell
            case .comments, .actions, .primaryContent:
                return UITableViewCell()
            }
            
        } else if subSection == 1 {
            // Post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.cellIdentifier, for: indexPath) as! FeedPostTableViewCell
                return cell
            case .comments, .actions, .header:
                return UITableViewCell()
            }
        } else if subSection == 2 {
            // Actions
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.cellIdentifier, for: indexPath) as! FeedPostActionsTableViewCell
                return cell
            case .comments, .header, .primaryContent:
                return UITableViewCell()
            }
        } else if subSection == 3 {
            // Comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.cellIdentifier, for: indexPath) as! FeedPostGeneralTableViewCell
                return cell
            case .actions, .header, .primaryContent:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            // Header
            return 70
        } else if subSection == 1 {
            // Post
            return tableView.width
        } else if subSection == 2 {
            // Actions
            return 60
        } else if subSection == 3 {
            // Comment row
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
