//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

struct SettingsCellModel {
    let title: String
    let handler: (() -> Void)
}

/// View Controller to show user settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[SettingsCellModel]]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureModels()
        setTableViewDelegateDatasource()
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
    
    private func configureModels() {
        let section = [
            SettingsCellModel(title: "Log Out") {
                [weak self] in
                self?.didTapLogOut()
            }
        ]
        data.append(section)
    }
    
    @objc private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {
            _ in
            DispatchQueue.main.async {
                AuthManager.shared.logOut {
                    [weak self] success in
                    DispatchQueue.main.async {
                        if success {
                            let loginVC = LoginViewController()
                            loginVC.modalPresentationStyle = .fullScreen
                            self?.present(loginVC, animated: true, completion: {
                                self?.navigationController?.popToRootViewController(animated: false)
                                self?.tabBarController?.selectedIndex = 0
                            })
                        } else {
                            fatalError("Could not log out user")
                        }
                    }
                }
            }
            
        }))
        // Actionsheet doenst know how to present itself
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
    
}

//MARK: - UITableView Delegate & DataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
