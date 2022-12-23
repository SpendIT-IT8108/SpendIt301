//
//  Transaction.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import Foundation
import UIKit

struct Transaction{
    var transactionName: String
    var amount: Double
    var date: Date
    var repeatedTransaction: Bool
    var transactionType: Bool
    var note: String?
    var categoryType: UIImage?
    
    static func loadTransaction()->[Transaction]?{
        return nil
    }
    static func loadSampleTransacion()-> [Transaction]{
        let trans1=Transaction(transactionName: "Phone Bills", amount: 3.9, date: Date.now, repeatedTransaction: true, transactionType: true, note: nil)
        let trans2=Transaction(transactionName: "Talabat", amount: 30.9, date: Date.now, repeatedTransaction: true, transactionType: true, note: nil)
        let trans3=Transaction(transactionName: "Savings", amount: 8.6, date: Date.now, repeatedTransaction: true, transactionType: true, note: nil)
        return [trans1,trans2,trans3]
    }

}
