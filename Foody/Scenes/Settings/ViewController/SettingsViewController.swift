//
//  SettingsViewController.swift
//  Foody
//
//  Created by halil yılmaz on 28.06.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        tvMain.delegate = self
        tvMain.dataSource = self
        setupUI()
        registerCell()
        setupNavigationBar()
    }
    
    func setupUI(){
        view.addSubview(tvMain)
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func registerCell() {}
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
