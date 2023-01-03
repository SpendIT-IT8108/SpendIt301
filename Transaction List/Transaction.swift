//
//  Transaction.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import Foundation
import UIKit

struct Transaction: Equatable, Codable{
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
    var attachment : CodableImage?
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
      }
    
    init(name: String, amount: Double, category: Category, date: Date, repeated: Bool, repeatingInterval: String? = nil, repeatFrom: Date? = nil, repeatUntil: Date? = nil, note: String? = nil, attachment: UIImage? = nil) {
        self.name = name
        self.amount = amount
        self.category = category
        self.date = date
        self.repeated = repeated
        self.repeatingInterval = repeatingInterval
        self.repeatFrom = repeatFrom
        self.repeatUntil = repeatUntil
        self.note = note
        if let attachment = attachment {
            self.attachment = CodableImage(attachment)
        } else {
            self.attachment = nil
        }
        
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL  = documentsDirectory.appendingPathComponent("Transactions").appendingPathExtension("plist")
    
    static func saveTransactions(_ transactions: [Transaction]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedTransactions = try? propertyListEncoder.encode(transactions)
        
        try? encodedTransactions?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadTransactions() -> [Transaction] {
        var transactions : [Transaction] = []
        let propertyListDecoder = PropertyListDecoder()
        if let retreivedTransactionsData = try? Data(contentsOf: archiveURL), let decodedTransactions = try? propertyListDecoder.decode(Array<Transaction>.self, from: retreivedTransactionsData) {
            transactions = decodedTransactions
        }
        else {
            transactions = loadSampleTransacion()
        }
        return transactions
        
    }
    
    static func loadSampleTransacion()-> [Transaction]{
        let trans1 = Transaction(name: "Phone Bills", amount: 10.9, category:  Category(name: "Phone", symbol: "📱", spendingLimit: nil, type: "Expense"), date: Date(), repeated: true, repeatingInterval: "Monthly", repeatFrom: Date())
        let trans2 = Transaction(name: "Talabat", amount: 15.5, category: Category(name: "Food", symbol: "🍔", spendingLimit: 55.7,type: "Expense"), date: Date(), repeated: false)
        let trans3 = Transaction(name: "Monthly Salary", amount: 200, category: Category(name: "Salary", symbol: "💵", spendingLimit: nil, type: "Income"), date: Date(), repeated: true, repeatingInterval: "Monthly", repeatFrom: Date())
        let trans4 = Transaction(name: "Winter Clothes", amount: 35, category: Category(name: "Clothing", symbol: "👚", spendingLimit: nil, type: "Expense"), date: Date(), repeated: false)
        let trans5 = Transaction(name: "Maintenance", amount: 15.7, category: Category(name: "Car", symbol: "🚘", spendingLimit: nil, type: "Expense"), date: Date(), repeated: false)
        
        return [trans1,trans2,trans3,trans4,trans5]
    }

}
