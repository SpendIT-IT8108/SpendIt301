//
//  Category.swift
//  SpendIt301
//
//  Created by Maryam Taraif on 22/12/2022.
//
import Foundation
import UIKit
struct Category: Equatable,Codable {
    let id :UUID
    var name:String
    var symbol:String
    var spendingLimit:Float?
    var type: String
    var icon:CodableImage?
    static var mostTracked: Category?
    
    
    init(name:String, symbol:String, spendingLimit:Float?, type:String) {
        self.id = UUID()
        self.name = name
        self.symbol = symbol
        self.spendingLimit = spendingLimit
        self.type = type
        self.icon = generateImageWithText(text: symbol)
 
    }
    
    
    
    static func == (lhs:Category , rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    

    //load categories available
    static func loadCategories() -> [Category]? {
        var categories:[Category] = []
        let propertyListDecoder = PropertyListDecoder()
        
        if let retreviedCategoriesData = try? Data(contentsOf: archiveURL), let decodedCategories = try? propertyListDecoder.decode(Array<Category>.self, from: retreviedCategoriesData) {
            categories = decodedCategories
        }else{
            categories = loadSampleCategories()
        }
        return categories
        
        
    }
    
    //load sample categories from
    static func loadSampleCategories() -> [Category]{
        
        let categories:[Category] =
               //expenses
               [
                    Category(name: "Food", symbol: "🍔", spendingLimit: nil,type: "Expense"),
                    Category(name: "Phone", symbol: "📱", spendingLimit: nil, type: "Expense"),
                   Category(name: "Transportation", symbol: "🚆", spendingLimit: nil, type: "Expense"),
                   Category(name: "Health Care", symbol: "🏥", spendingLimit: nil, type: "Expense"),
                   Category(name: "Education", symbol: "🏫", spendingLimit: nil, type: "Expense"),
                   Category(name: "Gifts", symbol: "🎁", spendingLimit: nil, type: "Expense"),
                   Category(name: "Shopping", symbol: "🛍️", spendingLimit: nil, type: "Expense"),
                   Category(name: "Clothing", symbol: "👚", spendingLimit: nil, type: "Expense"),
                   Category(name: "Car", symbol: "🚘", spendingLimit: nil, type: "Expense"),
                   Category(name: "Work", symbol: "👔", spendingLimit: nil, type: "Expense"),
               
               //incomes
               
                   Category(name: "Salary", symbol: "💵", spendingLimit: nil, type: "Income"),
                   Category(name: "Investments", symbol: "📈", spendingLimit: nil, type: "Income"),
                    Category(name: "Insurance Payout", symbol: "💰", spendingLimit: nil, type: "Income"),
                    Category(name: "Refund", symbol: "🤑", spendingLimit: nil, type: "Income"),
                    

               ]
               
               
        return categories
    }
    
    //generate icon with symbol
    func generateImageWithText(text: String) -> CodableImage? {

    var image:UIImage
    if self.type == "Expense" {
        image = UIImage(named: "Expense")!
    } else {
        image = UIImage(named: "Income")!
    }
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)



        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = text

        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return CodableImage(imageWithText!)
    }
    
    
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentDirectory.appendingPathComponent("Categories").appendingPathExtension("plist")
    
    static func saveCategories(_ categories:[Category]){
         let propertListEncoder = PropertyListEncoder()
         let codedCategories = try? propertListEncoder.encode(categories)
         try? codedCategories?.write(to: Category.archiveURL, options: .noFileProtection)
     }
     

  
}
