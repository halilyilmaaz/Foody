//
//  MaterialSelectionPresentVC.swift
//  Foody
//
//  Created by halil yılmaz on 12.07.2023.
//

import UIKit
import SnapKit

protocol MaterialSelectionPresentVCDelegate: AnyObject {
    func didSelectMaterials(selectedItems: [String])
}

class MaterialSelectionPresentVC: UIViewController {
    
    weak var delegate: MaterialSelectionPresentVCDelegate?
    
    var viewModel: MaterialSelectionPresentVM = {
        .init()
    }()

    let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    let searchButton = CustomButton(title: "Ekle", fontSize: .med, backgroundColor: .systemBlue)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        definesPresentationContext = true
        title = "Kullanılan malzemeleri işaretle"
        tvMain.delegate = self
        tvMain.dataSource = self
        tvMain.reloadData()
        setupUI()
        registerCell()
    }
    
    func setupUI() {
        view.addSubview(tvMain)
        view.addSubview(searchButton)
        
        tvMain.snp.makeConstraints { make in
              make.top.equalToSuperview().offset(20)
              make.leading.equalToSuperview().offset(15)
              make.trailing.equalToSuperview().offset(-15)
          }
          
          searchButton.snp.makeConstraints { make in
              make.top.equalTo(tvMain.snp.bottom).offset(20)
              make.leading.equalToSuperview().offset(20)
              make.trailing.equalToSuperview().offset(-20)
              make.bottom.equalToSuperview().offset(-30)
              make.height.equalTo(46)
          }
        
        searchButton.addTarget(self, action: #selector(didTapSearchBtn), for: .touchUpInside)
 
    }
    
    func registerCell(){
        tvMain.register(MaterialListCell.self, forCellReuseIdentifier: MaterialListCell.identifier)
    }
    
    @objc func didTapSearchBtn(){
        print("tapped search")
        delegate?.didSelectMaterials(selectedItems: viewModel.selectedItems)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension MaterialSelectionPresentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.materialsTools.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.materialsTools[section].learnType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.materialsTools[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaterialListCell.identifier, for: indexPath) as! MaterialListCell
        cell.sectionLabel.text = viewModel.materialsTools[indexPath.section].list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .gray.withAlphaComponent(0.9)
        view.layer.cornerRadius = 6
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerCurve = .circular
        view.clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .secondarySystemBackground
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let selectedValue = viewModel.materialsTools[indexPath.section].list[indexPath.row]
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            if let index = viewModel.selectedItems.firstIndex(of: selectedValue) {
                viewModel.selectedItems.remove(at: index)
            }
        } else {
            cell?.accessoryType = .checkmark
            if !viewModel.selectedItems.contains(selectedValue) {
                viewModel.selectedItems.append(selectedValue)
            }
        }
        
        print(viewModel.selectedItems)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
