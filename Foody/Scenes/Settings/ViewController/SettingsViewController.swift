//
//  SettingsViewController.swift
//  Foody
//
//  Created by halil yılmaz on 28.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModel = SettingsViewModel()
    
    var sections: [[SettingsSectionModel]] {
        return [
            [.aboutUs],
            [.buttons]
        ]
    }
    
    let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        tvMain.delegate = self
        tvMain.dataSource = self
        tvMain.reloadData()
        setupNavigationBar()
        registerCell()
        setupUI()
        
    }
    
    func setupUI(){
        view.addSubview(tvMain)
        tvMain.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func registerCell() {
        tvMain.register(LogOutAndDeleteTableViewCell.self, forCellReuseIdentifier: LogOutAndDeleteTableViewCell.identifier)
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton

        navigationItem.title = "Settings"
    }

    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionId = self.sections[indexPath.section][indexPath.row]
        
        switch sectionId {
        case .aboutUs:
            return UITableViewCell()
        case .buttons:
            let cell = tableView.dequeueReusableCell(withIdentifier: LogOutAndDeleteTableViewCell.identifier, for: indexPath) as! LogOutAndDeleteTableViewCell
            cell.delegate = self
            cell.lbl.text = "denemedeneme??"
            return cell
        }
    }
}

extension SettingsViewController: LogOutAndDeleteTableViewCellDelegate {
    func didTapLogOut() {
        viewModel.didTapLogOut()
    }
    
    func didTapDeleteAccount() {
    
        viewModel.didDeleteAccountCallBack = {
            self.viewModel.didTapLogOut()
        }
        viewModel.deleteAccount()
        
    }
}
