//
//  CategoriesOverviewView.swift
//  testforlogon
//
//  Created by David Blum on 29/01/2024.
//

import Foundation
import SwiftUI
// First Screen - Categories Overview
struct CategoriesOverviewView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: CategoryDetailsView(category: category)) {
                    CategoryCardView(category: category)
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryCardView: View {
    let category: Category
    
    var body: some View {
        VStack {
            Text(category.name)
            RemoteImage(url: category.thumbnail)
                           .aspectRatio(contentMode: .fit)
                           .frame(height: 100)
            Text("Total Products: \(category.totalProducts)")
            Text("Total Stock: \(category.totalStock)")
        }
        .padding()
        .border(Color.gray)
        .cornerRadius(10)
    }
}
