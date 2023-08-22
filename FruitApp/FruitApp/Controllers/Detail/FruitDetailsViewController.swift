//
//  FruitDetailsViewController.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import UIKit

class FruitDetailsViewController: UIViewController {
    @IBOutlet weak var labelFruitName: UILabel!
    @IBOutlet weak var labelFruitFamily: UILabel!
    @IBOutlet weak var labelFruitGenus: UILabel!
    @IBOutlet weak var labelFruitOrder: UILabel!
    
    @IBOutlet weak var labelFruitCarbohydrates: UILabel!
    @IBOutlet weak var labelFruitProtein: UILabel!
    @IBOutlet weak var labelFruitFat: UILabel!
    @IBOutlet weak var labelFruitCalories: UILabel!
    @IBOutlet weak var labelFruitsugar: UILabel!

    private var viewModel: FruitDetailsViewModelProtocol
    
    init?(coder: NSCoder,
          viewModel: FruitDetailsViewModelProtocol) {
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
    }
    

    func setupUI() {
        self.labelFruitName.text = self.viewModel.getFruitData()?.name ?? ""
        self.labelFruitFamily.text = self.viewModel.getFruitData()?.family ?? ""
        self.labelFruitGenus.text = self.viewModel.getFruitData()?.genus ?? ""
        self.labelFruitOrder.text = self.viewModel.getFruitData()?.order ?? ""
        
        self.labelFruitCarbohydrates.text = "\(self.viewModel.getFruitData()?.nutritions?.carbohydrates ?? 0.0)"
        self.labelFruitProtein.text = "\(self.viewModel.getFruitData()?.nutritions?.protein ?? 0.0)"
        self.labelFruitFat.text = "\(self.viewModel.getFruitData()?.nutritions?.fat ?? 0.0)"
        self.labelFruitCalories.text = "\(self.viewModel.getFruitData()?.nutritions?.calories ?? 0)"
        self.labelFruitsugar.text = "\(self.viewModel.getFruitData()?.nutritions?.sugar ?? 0.0)"
    }

}

//MARK: - IBActions
extension FruitDetailsViewController {
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

