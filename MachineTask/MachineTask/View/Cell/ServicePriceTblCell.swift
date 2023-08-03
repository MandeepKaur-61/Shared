//
//  ServicePriceTblCell.swift
//  MachineTask
//
//  Created by Indreet Singh on 23/07/22.
//

import UIKit
protocol CellDelegate : AnyObject {
    func addItem(at cell:ServicePriceTblCell)
    func removeItem(at cell:ServicePriceTblCell)
    func serviceUpdated(with txt:String, at cell:ServicePriceTblCell)
    func priceUpdated(with txt:String, at cell:ServicePriceTblCell)
}

class ServicePriceTblCell: UITableViewCell, UITextFieldDelegate {

    static let cellId = "ServicePriceTblCell"
    
    //MARK: - Outlets
    @IBOutlet weak var txtF_Service : UITextField!
    @IBOutlet weak var txtF_Price   : UITextField!
    @IBOutlet weak var btn_add      : UIButton!
    @IBOutlet weak var btn_remove   : UIButton!
    
    weak var delegate : CellDelegate?
    
    //MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.txtF_Price.delegate = self
        
        self.txtF_Service.addTarget(self, action: #selector(self.txtServiceChanged(_:)), for: .editingChanged)
        self.txtF_Price.addTarget(self, action: #selector(self.txtPriceChanged(_:)), for: .editingChanged)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func txtServiceChanged(_ sender:UITextField){
        self.delegate?.serviceUpdated(with: sender.text ?? "", at: self)
    }
    
    @objc func txtPriceChanged(_ sender:UITextField){
        self.delegate?.priceUpdated(with: sender.text ?? "", at: self)

    }
    
    //MARK: - Action
    @IBAction func btn_add(_ sender:UIButton) {
        self.delegate?.addItem(at: self)
    }
    
    @IBAction func btn_remove(_ sender:UIButton) {
        self.delegate?.removeItem(at: self)
    }
}
extension ServicePriceTblCell {
    /*
     The regular expression pattern ^(\\d*\\.?\\d{0,2})$ breaks down as follows:

     ^: Start of the string
     \\d*: Zero or more digits
     \\.?: An optional dot (escaped as \\ is required for Swift strings)
     \\d{0,2}: Between 0 to 2 digits
     $: End of the string
     
     With this regular expression, the user will be allowed to enter digits and a single dot while restricting any other characters or multiple dots.
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtF_Price {
            
            // Get the full text with the replacement string
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            // Define the regular expression pattern
            let pattern = "^(\\d*\\.?\\d{0,2})$"
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let matches = regex?.matches(in: updatedText, options: [], range: NSRange(location: 0, length: updatedText.utf16.count))
            
            // Allow input if the updated text matches the pattern
            return matches?.count ?? 0 > 0
        }
        return true
    }
}
