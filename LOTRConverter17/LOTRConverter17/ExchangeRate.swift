//
//  ExchangeRate.swift
//  LOTRConverter17
//
//  Created by ulixe on 15/04/24.
//
import SwiftUI

struct ExhangeRate: View {
    let leftImage : ImageResource
    let rightImage : ImageResource
    let text : String
    
    var body: some View {
        HStack {
            // left currency image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            // exhange rate text
            Text(text)
            // right currency image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExhangeRate(leftImage: .silverpiece, rightImage: .copperpenny, text: "1 Gold Piece = 4 Gold Pennies")
}
