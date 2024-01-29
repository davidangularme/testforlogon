//
//  RemoteImage.swift
//  testforlogon
//
//  Created by David Blum on 29/01/2024.
//

import Foundation
import SwiftUI

struct RemoteImage: View {
    private var url: String
    
    init(url: String) {
        self.url = url
    }
    
    @State private var imageData: Data? = nil
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            // Placeholder image or activity indicator
            Image(systemName: "photo")
                .resizable()
                .onAppear {
                    // Load image asynchronously
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        guard let imageUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            } else {
                // Handle error or use a placeholder
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
