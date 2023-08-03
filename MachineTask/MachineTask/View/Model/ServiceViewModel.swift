//
//  ServiceViewModel.swift
//  MachineTask
//
//  Created by Indreet on 03/08/23.
//

import Foundation
struct ServiceViewModel {
    
    var arr_services = [TableDataModel]()
    
    mutating func addService(txt:String, index:Int){
        self.arr_services[index].service = txt
    }
    
    mutating func addPrice(txt:String, index:Int){
       self.arr_services[index].price = txt
    }
    
    func updatePrice() -> String {
        let total = self.arr_services.reduce(0.0) { result, service in
            if let price = Double(service.price ?? "0.0") {
                return result + price
            }
            return result
        }
        return "\(total)"
    }
    
    mutating func addItem(at index:Int){
        self.arr_services.insert(TableDataModel(price: "", service: ""), at: index)
    }
    mutating func removeItem(at index:Int){
        self.arr_services.remove(at: index)
    }
}
