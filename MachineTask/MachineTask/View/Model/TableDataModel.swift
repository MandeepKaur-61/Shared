//
//  TableDataModel.swift
//  MachineTask
//
//  Created by Indreet Singh on 23/07/22.
//

import Foundation
struct TableDataModel {
    var price : String?
    var service:String?
    
    static let empty = TableDataModel(price: "", service: "")
}
