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
    
    
    
    init(name:String, symbol:String, spendingLimit:Float?) {
        self.name = name
        self.symbol = symbol
        self.spendingLimit = spendingLimit
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
                   Category(name: "Food", symbol: "🍔", spendingLimit: nil),
                   Category(name: "Transportaion", symbol: "🚆", spendingLimit: nil),
                   Category(name: "Health Care", symbol: "🏥", spendingLimit: nil),
                   Category(name: "Education", symbol: "🏫", spendingLimit: nil),
                   Category(name: "Gifts", symbol: "🎁", spendingLimit: nil),
                   Category(name: "Shopping", symbol: "🛍️", spendingLimit: nil),
                   Category(name: "Clothing", symbol: "👚", spendingLimit: nil),
                   Category(name: "Car", symbol: "🚘", spendingLimit: nil),
                   Category(name: "Work", symbol: "👔", spendingLimit: nil),
               ] ,
               //incomes
               [
                   Category(name: "Salary", symbol: "💵", spendingLimit: nil),
                   Category(name: "Investments", symbol: "📈", spendingLimit: nil),

               ]
               
               ]
        return categories
    }
}
