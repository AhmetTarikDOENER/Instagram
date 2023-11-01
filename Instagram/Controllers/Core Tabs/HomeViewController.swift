//
//  ViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.cellIdentifier)
        
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(tableView)
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
}

//MARK: - UITableView Delegate and Datasource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.cellIdentifier, for: indexPath) as! FeedPostTableViewCell
        
        return cell
    }
}
