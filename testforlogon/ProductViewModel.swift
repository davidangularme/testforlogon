//
//  ProductViewModel.swift
//  testforlogon
//
//  Created by David Blum on 29/01/2024.
//

import Foundation
// ViewModel to handle data
/*
class ProductViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        // Fetch data from API
        if let url = URL(string: "https://dummyjson.com/products?limit=100") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let products = try JSONDecoder().decode(ProductList.self, from: data)
                        self.updateCategories(products: products.products)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }
    
    func updateCategories(products: [Product]) {
        // Process data to create unique categories
        let uniqueCategories = Array(Set(products.map { $0.category }))
        
        for category in uniqueCategories {
            let categoryProducts = products.filter { $0.category == category }
            let totalProducts = categoryProducts.count
            let totalStock = categoryProducts.map { $0.stock }.reduce(0, +)
            
            if let firstProduct = categoryProducts.first {
                let categoryItem = Category(name: category,
                                           thumbnail: firstProduct.thumbnail,
                                           totalProducts: totalProducts,
                                           totalStock: totalStock)
               // categories.append(categoryItem)
                DispatchQueue.main.async {
                               self.categories.append(categoryItem)
                           }
            }
        }
    }
}
*/

class ProductViewModel: ObservableObject {
    @Published var categories: [Category] = []

    init() {
        // Try to load data from cache
        if let cachedData = UserDefaults.standard.data(forKey: "cachedProducts"),
           let cachedProducts = try? JSONDecoder().decode([Product].self, from: cachedData) {
            self.updateCategories(products: cachedProducts)
        }
        
        fetchData()
    }

    func fetchData() {
        if let url = URL(string: "https://dummyjson.com/products?limit=100") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let productsResponse = try JSONDecoder().decode(ProductList.self, from: data)
                        self.updateCategories(products: productsResponse.products)
                        
                        // Cache the data locally
                        if let encodedData = try? JSONEncoder().encode(productsResponse.products) {
                            UserDefaults.standard.set(encodedData, forKey: "cachedProducts")
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }

    func updateCategories(products: [Product]) {
        let uniqueCategories = Array(Set(products.map { $0.category }))
        
        for category in uniqueCategories {
            let categoryProducts = products.filter { $0.category == category }
            let totalProducts = categoryProducts.count
            let totalStock = categoryProducts.map { $0.stock }.reduce(0, +)
            
            if let firstProduct = categoryProducts.first {
                let categoryItem = Category(name: category,
                                           thumbnail: firstProduct.thumbnail,
                                           totalProducts: totalProducts,
                                           totalStock: totalStock)
                
                DispatchQueue.main.async {
                    self.categories.append(categoryItem)
                }
            }
        }
    }
}

