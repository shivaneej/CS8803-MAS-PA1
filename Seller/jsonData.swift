//
//  jsonData.swift
//  Seller
//
//  Created by Daniel Basman on 9/10/22.
//

import Foundation
struct data: Codable {
    var category: String
    var description: String
    var image_url: String?
    var mobile: Int
    var name: String
    var price: Int?
    var timestamp: Int

}

let json = """
{
        category = "Test 5";
        description = "this is a long description of the product.";
        "image_url" = "https://www.att.com/idpassets/global/devices/phones/apple/apple-iphone-12/carousel/blue/64gb/6861C-1_carousel.png";
        mobile = 4041234567;
        name = "Test 5";
        price = 1500;
        timestamp = 1662847636427;
})
""".data(using: .utf8)!



