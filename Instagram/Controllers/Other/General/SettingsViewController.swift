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
        configureModels()
        view.addSubview(tableView)
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Private
    
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
                    
                }
            }
        }
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
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
