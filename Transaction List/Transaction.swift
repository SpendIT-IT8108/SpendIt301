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
    var nextDate : Date?
    
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
      }
    
    init(name: String, amount: Double, category: Category, date: Date, repeated: Bool, repeatingInterval: String? = nil, repeatFrom: Date? = nil, repeatUntil: Date? = nil, note: String? = nil, attachment: UIImage? = nil, nextDate: Date? = nil) {
        self.name = name
        self.amount = amount
        self.category = category
        self.date = date
        self.repeated = repeated
        self.repeatingInterval = repeatingInterval
        self.repeatFrom = repeatFrom
        self.nextDate = nextDate
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
            transactions = decodedTransactions.sorted(by: { $0.date > $1.date })
        }
        else {
            transactions = loadSampleTransacion()
        }
        return transactions
        
    }
    
    static func loadSampleTransacion()-> [Transaction]{
        let isoDate = "2023-01-03T00:00:00+0000"
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        let next = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        
        let isoDate2 = "2023-01-08T00:00:00+0000"
        let end = dateFormatter.date(from:isoDate2)!
        
        let trans1 = Transaction(name: "Phone Bills", amount: 10.9, category:  Category(name: "Phone", symbol: "📱", spendingLimit: nil, type: "Expense"), date: Date(), repeated: true, repeatingInterval: "Monthly", repeatFrom: Date())
        let trans2 = Transaction(name: "Talabat", amount: 15.5, category: Category(name: "Food", symbol: "🍔", spendingLimit: 55.7,type: "Expense"), date: Date(), repeated: false)
        let trans3 = Transaction(name: "Monthly Salary", amount: 200, category: Category(name: "Salary", symbol: "💵", spendingLimit: nil, type: "Income"), date: Date(), repeated: true, repeatingInterval: "Monthly", repeatFrom: Date())
        let trans4 = Transaction(name: "Winter Clothes", amount: 35, category: Category(name: "Clothing", symbol: "👚", spendingLimit: nil, type: "Expense"), date: Date(), repeated: false)
        let trans5 = Transaction(name: "Maintenance", amount: 15.7, category: Category(name: "Car", symbol: "🚘", spendingLimit: nil, type: "Expense"), date: Date(), repeated: false)
        let trans6 = Transaction(name: "Karak", amount: 0.2, category: Category(name: "Food", symbol: "🍔", spendingLimit: nil, type: "Expense"), date: date, repeated: true, repeatingInterval: "Daily", repeatFrom: date, repeatUntil: nil, nextDate: next)

        return [trans1,trans2,trans3,trans4,trans5,trans6]
    }
    
    
    
    //MARK: REPEAT PROCESS
    //function to update repeated sequences
    static func updateRepeated(){
        var trans = Transaction.loadTransactions()
        for tran in trans {
            var record = tran
            //if it has a nextDate (the original transaction of a repeated one only has this value)
            if tran.nextDate != nil , let interval = tran.repeatingInterval {
                var nextDate = tran.nextDate
                var valid = validate(nextTime: nextDate)
                //repeat while validated
                while valid {
                    //add new transaction
                    let newTran = Transaction(name: tran.name, amount: tran.amount,category: tran.category, date: nextDate!,  repeated: tran.repeated, repeatingInterval: tran.repeatingInterval, repeatFrom: tran.repeatFrom, repeatUntil: tran.repeatUntil, note: tran.note, attachment: tran.attachment?.image, nextDate: nil)
                    trans.append(newTran)
                    //calculate the next transaction date and update the original transaction record
                    nextDate = calculateNext(interval: interval, nextTime: nextDate!, endDate: tran.repeatUntil)
                    record.nextDate = nextDate
                    //reaplce the old record with the new one in the array, and save to files
                    if let index = trans.firstIndex(of: tran) {
                        trans[index] = record
                        Transaction.saveTransactions(trans)
                    }
                    //check validity using the new calculated nextDate to decide if we continue adding or stop
                    valid = validate(nextTime: nextDate)
                }
            }
        }
    }
    
    
    //a function to calculate next repeated transaction date
    static func calculateNext(interval:String, nextTime:Date, endDate:Date? ) -> Date? {
        var next : Date?
        switch interval {
        case "Monthly":
            next = Calendar.current.date(byAdding: .month, value: 1, to: nextTime)!
            next = Calendar.current.startOfDay(for: next!)
        case "Weekly":
            next = Calendar.current.date(byAdding: .day, value: 7, to: nextTime)!
            next = Calendar.current.startOfDay(for: next!)
        case "Daily":
            next = Calendar.current.date(byAdding: .day, value: 1, to: nextTime)!
            next = Calendar.current.startOfDay(for: next!)
        default:
            next = nil
        }
        
        //take the end date into consedaration if it's specified
        if let endDate = endDate {
            //if the calculated next date is less or equal then the end, return the date, otherwise return nil to end the repeat
            if next! <= endDate {
                return next
            }
            else {
                return nil
            }
        }
        else {
            return next
        }
    }
    
    
    //function to check if the next transaction is valid to be added at the moment
    static func validate(nextTime: Date?) -> Bool {
        var valid = false
        if let nextTime = nextTime {
            if nextTime <= Date() {
                valid = true
            }
        }
        return valid
    }
    
}

