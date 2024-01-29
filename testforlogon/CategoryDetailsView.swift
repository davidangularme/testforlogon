//
//  CategoryDetailsView.swift
//  testforlogon
//
//  Created by David Blum on 29/01/2024.
//

import Foundation
import SwiftUI

// Second Screen - Category Details
struct CategoryDetailsView: View {
    let category: Category
    @State private var products: [Product] = [] // Products within selected category
    
    var body: some View {
        List(products) { product in
            ProductItemView(product: product)
        }
        .navigationTitle(category.name)
        .onAppear {
            // Fetch products for the selected category
            fetchDataForCategory()
        }
    }
    
    func fetchDataForCategory() {
        if let cachedData = UserDefaults.standard.data(forKey: "cachedProducts"),
           let cachedProducts = try? JSONDecoder().decode([Product].self, from: cachedData) {
            let categoryProducts = cachedProducts.filter { $0.category == category.name }
            self.products = categoryProducts
        }

    }
}


struct ProductItemView: View {
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.title)
            RemoteImage(url: product.thumbnail)
                           .aspectRatio(contentMode: .fit)
                           .frame(height: 100)
            Text("Price: \(product.price)")
            Text("Stock: \(product.stock)")
        }
        .padding()
        .border(Color.gray)
        .cornerRadius(10)
    }
}
