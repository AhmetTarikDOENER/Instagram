//
//  PostViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

/*
        - Header Model
 Section
        - Post Cell Model
 Section
        - Action Buttons Cell Model
 Section
        - n Number of general models for comments
 */

import UIKit

/// States of rendered cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComments])
}

/// Model of rendered Posts
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.cellIdentifier)
        table.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.cellIdentifier)
        table.register(FeedPostActionsTableViewCell.self, forCellReuseIdentifier: FeedPostActionsTableViewCell.cellIdentifier)
        table.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.cellIdentifier)
        
        return table
    }()
    
    
    
    //MARK: - Init
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        setTableDelegateDatasource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Private
    private func setTableDelegateDatasource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else { return }
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // 4 Comments
        var comments = [PostComments]()
        for x in 0..<4 {
            comments.append(PostComments(identifier: "123_\(x)", username: "@dave", text: "Great Post", createdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
}

//MARK: - UItableView Delegate and Datasource

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .header(_):
            return 1
        case .primaryContent(_):
            return 1
        case .actions(_):
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header(let user):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FeedPostHeaderTableViewCell.cellIdentifier,
                for: indexPath
            ) as! FeedPostHeaderTableViewCell
            
            return cell
        case .primaryContent(let posts):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FeedPostTableViewCell.cellIdentifier,
                for: indexPath
            ) as! FeedPostTableViewCell
            
            return cell
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FeedPostActionsTableViewCell.cellIdentifier,
                for: indexPath
            ) as! FeedPostActionsTableViewCell
            
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FeedPostGeneralTableViewCell.cellIdentifier,
                for: indexPath
            ) as! FeedPostGeneralTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header(_): return 70
        case .primaryContent(_): return tableView.width
        case .actions(_): return 60
        case .comments(_): return 50
        }
    }
}
