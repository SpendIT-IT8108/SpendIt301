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
      }
    static func compareName(transactionName: String)->Bool{
       return transactionName == transactionName.self
    }
    
    static func loadTransaction()->[Transaction]?{
        return nil
    }
    static func loadSampleTransacion()-> [Transaction]{
        let trans1=Transaction(transactionName: "Phone Bills", amount: 3.9, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        let trans2=Transaction(transactionName: "Talabat", amount: 30.9, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        let trans3=Transaction(transactionName: "Savings", amount: 8.6, date: Date(), repeatedTransaction: true, transactionType: "Income", note: nil)
        let trans4=Transaction(transactionName: "Shopping", amount: 8.6, date: Date(), repeatedTransaction: true, transactionType: "Expenses", note: nil)
        let trans5=Transaction(transactionName: "summer vacation", amount: 8.6, date: Date(), repeatedTransaction: true, transactionType: "expenses", note: nil)
        return [trans1,trans2,trans3,trans4,trans5]
    }

}//test
//var transactionss:[Transaction]=[
//     Transaction(transactionName: "Phone Bills", amount: 3.9, date: Date.now, repeatedTransaction: true, transactionType: true, note: nil),
//    Transaction(transactionName: "Talabat", amount: 30.9, date: Date.now, repeatedTransaction: true, transactionType: true, note: nil),
//     Transaction(transactionName: "Savings", amount: 8.6, date: Date.now, repeatedTransaction: true, transactionType: true, note: nil)
//]
