//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    //MARK: - Private
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
}
