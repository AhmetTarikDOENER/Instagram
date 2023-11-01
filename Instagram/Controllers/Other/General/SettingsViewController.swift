//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit
import SafariServices

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
        data.append([
            SettingsCellModel(title: "Edit Profile") {
                [weak self] in
                self?.didTapEditProfile()
            },
            SettingsCellModel(title: "Invite Friends") {
                [weak self] in
                self?.didTapInviteFriends()
            },
            SettingsCellModel(title: "Save Original Post") {
                [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Terms of Service") {
                [weak self] in
                self?.openURL(type: .terms)
            },
            SettingsCellModel(title: "Privacy Policy") {
                [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingsCellModel(title: "Help / Feedback") {
                [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Log Out") {
                [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    @objc private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    @objc private func didTapInviteFriends() {
        
    }
    
    @objc private func didTapSaveOriginalPosts() {
        
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms:
            return urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            return urlString = "https://help.instagram.com/196883487377501"
        case .help:
            return urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
