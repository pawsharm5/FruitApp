//
//  HomeViewController.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import UIKit
import PromiseKit
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAllFruits: UIButton!
    @IBOutlet weak var btnFruitByFamily: UIButton!
    @IBOutlet weak var btnFruitByGenus: UIButton!
    @IBOutlet weak var btnFruitByOrder: UIButton!

    
    var viewModel = HomeViewModel()
    var resonseAvailabel = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindData()
    }
    
    
    func setupUI() {
        self.tableView.separatorStyle = .none
        let fruitListTblCell = UINib(nibName: "FruitListTblCell", bundle: nil)
        self.tableView.register(fruitListTblCell, forCellReuseIdentifier: "FruitListTblCell")
    }
    
    func bindData() {
        self.viewModel.getAllFruits()
        
        self.viewModel.errorMessage.bind { [weak self] in
            guard let _ = $0 else { return }
            self?.viewModel.errorMessage.value = nil
        }
        
        self.viewModel.filteredResponse.bind { [weak self] in
            guard let _ = $0 else { return }
            self?.resonseAvailabel = true
            self?.tableView.reloadData()
        }
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.resonseAvailabel ? self.viewModel.filteredResponse.value?.count ?? 0 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredResponse.value?[section].1.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.filteredResponse.value?[section].0.description ?? ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FruitListTblCell", for: indexPath) as! FruitListTblCell
        cell.selectionStyle = .none
        cell.accessibilityIdentifier = "Cell_\(indexPath.row)"
        var dataV:FruitsListModelElement?
        switch self.viewModel.selectdCategory {
        case .AllFruits:
            dataV = self.viewModel.filteredResponse.value?[indexPath.section].1[indexPath.row]
            cell.setUpData(name: dataV?.name ?? "", typeName: "")
        case .FruitsByFamily, .FruitsByGenus, .FruitsByOrder:
            dataV = self.viewModel.filteredResponse.value?[indexPath.section].1[indexPath.row]
            cell.setUpData(name: dataV?.name ?? "", typeName: dataV?.family ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dataV:FruitsListModelElement?
        switch self.viewModel.selectdCategory {
        case .AllFruits:
            dataV = self.viewModel.filteredResponse.value?[indexPath.section].1[indexPath.row]
        case .FruitsByFamily, .FruitsByGenus, .FruitsByOrder:
            dataV = self.viewModel.filteredResponse.value?[indexPath.section].1[indexPath.row]
        }
        let storyboard = UIStoryboard(storyboard: .Main)
        let destination:FruitDetailsViewController = storyboard.instantiateViewController()
        let VM = FruitDetailViewModel.init()
        VM.fruitData = dataV
        destination.viewModel = VM
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:  {
                self.viewModel.filterByFamily(type: self.viewModel.selectdCategory)
                searchBar.resignFirstResponder()
            })
        }
        if searchText.count > 2 {
            self.resonseAvailabel = false
            self.tableView.reloadData()
            self.viewModel.searchFruit(searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count ?? 0 > 2 {
            self.resonseAvailabel = false
            self.tableView.reloadData()
            self.viewModel.searchFruit(searchText: searchBar.text ?? "")
        }
    }
}

//MARK: - IBActions
extension HomeViewController {
    
    @IBAction func btnCategoryClick(_ sender: UIButton) {
        self.searchBar.resignFirstResponder()
        switch sender.tag {
        case 0:
            self.viewModel.selectdCategory = .AllFruits
        case 1:
            self.viewModel.selectdCategory = .FruitsByFamily
        case 2:
            self.viewModel.selectdCategory = .FruitsByGenus
        case 3:
            self.viewModel.selectdCategory = .FruitsByOrder
        default:
            print("No Data")
        }
        self.viewModel.filterByFamily(type: self.viewModel.selectdCategory)
        self.tableView.reloadData()
    }
}
