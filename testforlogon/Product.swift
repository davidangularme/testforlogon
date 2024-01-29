//
//  Product.swift
//  testforlogon
//
//  Created by David Blum on 29/01/2024.
//

import Foundation
import SwiftUI

// Model for Product and Category
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

struct ProductList: Decodable  {
    let products: [Product]
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let thumbnail: String
    let totalProducts: Int
    let totalStock: Int
}
