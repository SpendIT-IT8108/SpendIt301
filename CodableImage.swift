
// COPYWRITES
// Code snippet published by Khoa Pham on July 4, 2021
// URL: https://onmyway133.com/posts/how-to-conform-uiimage-to-codable/



import Foundation
import UIKit

struct CodableImage: Codable {
    let image: UIImage?

    init(_ image: UIImage) {
        self.image = image
    }

    enum CodingKeys: CodingKey {
        case data
        case scale
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let scale = try container.decode(CGFloat.self, forKey: .scale)
        let data = try container.decode(Data.self, forKey: .data)
        self.image = UIImage(data: data, scale: scale)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = self.image {
            try container.encode(image.pngData(), forKey: .data)
            try container.encode(image.scale, forKey: .scale)
        }
    }
}
