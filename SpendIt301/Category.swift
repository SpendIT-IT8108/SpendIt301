//
//  Category.swift
//  SpendIt301
//
//  Created by Maryam Taraif on 22/12/2022.
//

import Foundation

struct Category: Equatable{
        let id = UUID()
        var name:String
        var symbol:String
        var spendingLimit:Float?
        var type: String
        
        
        
        init(name:String, symbol:String, spendingLimit:Float?, type:String) {
          
            self.name = name
            self.symbol = symbol
            self.spendingLimit = spendingLimit
            self.type = type
        }
        
        
        
        static func == (lhs:Category , rhs: Category) -> Bool {
            return lhs.id == rhs.id
        }
        
        
        //load categories available
        static func loadCategories() -> [[Category]]? {
            return nil
        }
        
        //load sampple categories from
        static func loadSampleCategories() -> [[Category]]{
            
            let categories:[[Category]] = [
                   //expenses
                   [
                    Category(name: "Food", symbol: "🍔", spendingLimit: nil,type: "Expense"),
                       Category(name: "Transportaion", symbol: "🚆", spendingLimit: nil, type: "Expense"),
                       Category(name: "Health Care", symbol: "🏥", spendingLimit: nil, type: "Expense"),
                       Category(name: "Education", symbol: "🏫", spendingLimit: nil, type: "Expense"),
                       Category(name: "Gifts", symbol: "🎁", spendingLimit: nil, type: "Expense"),
                       Category(name: "Shopping", symbol: "🛍️", spendingLimit: nil, type: "Expense"),
                       Category(name: "Clothing", symbol: "👚", spendingLimit: nil, type: "Expense"),
                       Category(name: "Car", symbol: "🚘", spendingLimit: nil, type: "Expense"),
                       Category(name: "Work", symbol: "👔", spendingLimit: nil, type: "Expense"),
                   ] ,
                   //incomes
                   [
                       Category(name: "Salary", symbol: "💵", spendingLimit: nil, type: "Income"),
                       Category(name: "Investments", symbol: "📈", spendingLimit: nil, type: "Income"),

                   ]
                   
                   ]
            return categories
        }
    }

