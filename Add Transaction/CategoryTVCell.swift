//
//  CategoryTVCell.swift
//  SpendIt301
//
//  Created by A'laa Alekri on 28/12/2022.
//

import UIKit

class CategoryTVCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with category: Category) {
        categoryNameLabel.text = category.name
        symbolImageView.image = generateImageWithText(symbol: category.symbol, type: category.type)
    }
    
    
    func generateImageWithText(symbol: String, type: String) -> UIImage? {

        var image:UIImage
        if type == "Expense" {
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
            label.text = symbol

            UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
            imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
            label.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return imageWithText
        }
}
