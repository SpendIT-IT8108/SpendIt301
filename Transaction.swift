//
//  Transaction.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import Foundation
import UIKit

struct Transaction: Equatable{
    var transactionName: String
    var amount: Double
    var date: Date
    var repeatedTransaction: Bool
    var transactionType: String
    var note: String?
    var categoryType: UIImage?
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.transactionName == rhs.transactionName
        && lhs.transactionType == rhs.transactionType
      }
    
    static func loadTransaction()->[Transaction]?{
        return nil
    }
    static func loadSampleTransacion()-> [Transaction]{
        let trans1=Transaction(transactionName: "Phone Bills", amount: 10.9, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        let trans2=Transaction(transactionName: "Talabat", amount: 30.9, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        let trans3=Transaction(transactionName: "Savings", amount: 20.6, date: Date(), repeatedTransaction: true, transactionType: "Incomes", note: nil)
        let trans4=Transaction(transactionName: "Shopping", amount: 20, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        let trans5=Transaction(transactionName: "summer vacation", amount: 80.6, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        return [trans1,trans2,trans3,trans4,trans5]
    }

}
