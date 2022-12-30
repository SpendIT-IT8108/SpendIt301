//
//  Transaction.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import Foundation
import UIKit

struct Transaction: Equatable{
    var id = UUID()
    var name: String
    var amount: Double
    var category: Category
    var date: Date
    var repeated: Bool
    var repeatingInterval : String?
    var repeatFrom : Date?
    var repeatUntil : Date?
    var note: String?
    var attachment : UIImage?
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
      }
    
    static func loadTransaction()->[Transaction]?{
        return nil
    }
    
    static func loadSampleTransacion()-> [Transaction]{
        let trans1 = Transaction(name: "Phone Bills", amount: 10.9, category:  Category(name: "Phone", symbol: "📱", spendingLimit: nil, type: "Expenses"), date: Date(), repeated: true, repeatingInterval: "Monthly", repeatFrom: Date())
        let trans2 = Transaction(name: "Talabat", amount: 15.5, category: Category(name: "Food", symbol: "🍔", spendingLimit: 55.7,type: "Expenses"), date: Date(), repeated: false)
        let trans3 = Transaction(name: "Monthly Salary", amount: 200, category: Category(name: "Salary", symbol: "💵", spendingLimit: nil, type: "Incomes"), date: Date(), repeated: true, repeatingInterval: "Monthly", repeatFrom: Date())
        let trans4 = Transaction(name: "Winter Clothes", amount: 35, category: Category(name: "Clothing", symbol: "👚", spendingLimit: nil, type: "Expenses"), date: Date(), repeated: false)
        let trans5 = Transaction(name: "Maintenance", amount: 15.7, category: Category(name: "Car", symbol: "🚘", spendingLimit: nil, type: "Expenses"), date: Date(), repeated: false)
        
        return [trans1,trans2,trans3,trans4,trans5]
    }

}
