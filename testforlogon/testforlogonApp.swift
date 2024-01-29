//
//  testforlogonApp.swift
//  testforlogon
//
//  Created by David Blum on 29/01/2024.
//

import SwiftUI

@main
struct testforlogonApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesOverviewView(viewModel: ProductViewModel())
        }
    }
}

