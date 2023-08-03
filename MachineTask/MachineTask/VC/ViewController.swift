//
//  ViewController.swift
//  MachineTask
//
//  Created by Indreet Singh on 23/07/22.
//

import UIKit

class ViewController : UIViewController {
    
    var tblCell: ServicePriceTblCell?
    var viewModel = ServiceViewModel()
    
    //MARK: -
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbl_totatAmount : UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.arr_services.append(TableDataModel.empty)
    }
    
}

//MARK: - Extension
//MARK: - Table View
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arr_services.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServicePriceTblCell.cellId) as? ServicePriceTblCell ?? ServicePriceTblCell()
        
        cell.delegate = self
        let arrCount = self.viewModel.arr_services.count
        cell.btn_add.isHidden = indexPath.row != (arrCount - 1)
        let service = self.viewModel.arr_services[indexPath.row]
        cell.txtF_Price.text = service.price
        cell.txtF_Service.text = service.service
        
        return cell
    }
    
}
extension ViewController : CellDelegate {
    func addItem(at cell: ServicePriceTblCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.viewModel.addItem(at: indexPath.row + 1)
        }
        self.tableView.reloadData()
    }
    
    func removeItem(at cell: ServicePriceTblCell) {
        guard self.viewModel.arr_services.count > 1 else { return }
        if let indexPath = tableView.indexPath(for: cell) {
            self.viewModel.removeItem(at: indexPath.row)
        }
        self.tableView.reloadData()
        self.lbl_totatAmount.text = self.viewModel.updatePrice()
    }
    
    func serviceUpdated(with txt: String, at cell: ServicePriceTblCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.viewModel.addService(txt: txt, index: indexPath.row)
        }
    }
    
    func priceUpdated(with txt: String, at cell: ServicePriceTblCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.viewModel.addPrice(txt: txt, index: indexPath.row)
        }
        self.lbl_totatAmount.text = self.viewModel.updatePrice()
    }
    
}

