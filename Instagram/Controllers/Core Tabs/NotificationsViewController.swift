//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: UserFollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.cellIdentifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.cellIdentifier)
        
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        fetchNotifications()
        view.addSubview(spinner)
//        spinner.startAnimating()
        view.addSubview(tableView)
        setTableViewDelegateDatasource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    //MARK: - Private
    
    private func setTableViewDelegateDatasource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 4)
        noNotificationsView.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0...100 {
            let post = UserPost(
                identifier: "",
                postType: .photo,
                thumbnailImage: URL(string: "https://www.google.com")!,
                postURL: URL(string: "https://www.google.com")!,
                caption: nil,
                likeCount: [],
                comments: [],
                createdDate: Date(),
                taggedUsers: []
            )
            
            let model = UserNotification(
                type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                text: "Hello World",
                user: User(
                    username: "Joe",
                    bio: "",
                    name: (first: "", last: ""),
                    birthDate: Date(),
                    profilePhoto: URL(string: "https://www.google.com")!,
                    gender: .male,
                    counts: UserCount(followers: 1, following: 1, post: 1),
                    joinDate: Date()
                )
            )
            models.append(model)
        }
    }
}

//MARK: - UITableView Delegate and Dataspurce

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            // Like cell
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationLikeEventTableViewCell.cellIdentifier,
                for: indexPath
            ) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            // Follow cell
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationFollowEventTableViewCell.cellIdentifier,
                for: indexPath
            ) as! NotificationFollowEventTableViewCell
//            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

//MARK: - NotificationLikeEventTableViewCellDelegate and NotificationFollowEventTableViewCellDelegate

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    
    func didTapRelatedPostsButton(model: UserNotification) {
        print("Tapped post")
        // Open post
    }
}


extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
   
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped button")
        // Perform database update
    }
}
