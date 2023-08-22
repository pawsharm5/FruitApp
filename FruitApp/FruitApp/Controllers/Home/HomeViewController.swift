//
//  HomeViewController.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAllFruits: UIButton!
    @IBOutlet weak var btnFruitByFamily: UIButton!
    @IBOutlet weak var btnFruitByGenus: UIButton!
    @IBOutlet weak var btnFruitByOrder: UIButton!

    private(set) var viewModel:HomeViewModelProtocol
    private var resonseAvailabel = false
    
    // MARK: Initializers

    init?(coder: NSCoder,
          viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindData()
    }
    
    
    func setupUI() {
        self.tableView.separatorStyle = .none
        let fruitListTblCell = UINib(nibName: "FruitListTblCell", bundle: nil)
        self.tableView.register(fruitListTblCell, forCellReuseIdentifier: FruitListTblCell.cellIdentifier)
        
        self.btnAllFruits.addShadow()
        self.btnFruitByFamily.addShadow()
        self.btnFruitByGenus.addShadow()
        self.btnFruitByOrder.addShadow()
    }
    
    func bindData() {
        self.viewModel.selectdCategory = .AllFruits
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: FruitListTblCell.cellIdentifier, for: indexPath) as? FruitListTblCell {
            cell.selectionStyle = .none
            cell.accessibilityIdentifier = "Cell_\(indexPath.row)"
            cell.LabelFruitName.text = self.viewModel.getFruitName(forIndex: indexPath.row, section: indexPath.section)
            cell.LabelFruitCategory.text = self.viewModel.getFruitFamilyName(forIndex: indexPath.row, section: indexPath.section, type: self.viewModel.selectdCategory)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.redirectToFruitDetails(forIndex: indexPath.row, section: indexPath.section)
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
        if searchText.count > 0 {
            self.resonseAvailabel = false
            self.tableView.reloadData()
            self.viewModel.searchFruit(searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count ?? 0 > 0 {
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
            sender.backgroundColor = .blue
            self.btnFruitByFamily.backgroundColor = .red
            self.btnFruitByGenus.backgroundColor = .red
            self.btnFruitByOrder.backgroundColor = .red
            self.viewModel.selectdCategory = .AllFruits
        case 1:
            sender.backgroundColor = .blue
            self.btnAllFruits.backgroundColor = .red
            self.btnFruitByGenus.backgroundColor = .red
            self.btnFruitByOrder.backgroundColor = .red
            self.viewModel.selectdCategory = .FruitsByFamily
        case 2:
            sender.backgroundColor = .blue
            self.btnAllFruits.backgroundColor = .red
            self.btnFruitByFamily.backgroundColor = .red
            self.btnFruitByOrder.backgroundColor = .red
            self.viewModel.selectdCategory = .FruitsByGenus
        case 3:
            sender.backgroundColor = .blue
            self.btnAllFruits.backgroundColor = .red
            self.btnFruitByFamily.backgroundColor = .red
            self.btnFruitByGenus.backgroundColor = .red
            self.viewModel.selectdCategory = .FruitsByOrder
        default:
            print("No Data")
        }
        self.viewModel.filterByFamily(type: self.viewModel.selectdCategory)
        self.tableView.reloadData()
    }
}
