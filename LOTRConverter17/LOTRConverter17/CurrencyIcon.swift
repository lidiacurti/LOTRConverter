//
//  CurrencyIcon.swift
//  LOTRConverter17
//
//  Created by ulixe on 16/04/24.
//

import SwiftUI

struct CurrencyIcon: View {
    let currencyImage : ImageResource
    let label : String
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(currencyImage)
                .resizable()
                .scaledToFit()
            
            Text(label)
                .padding(3)
                .font(.caption)
            //infinity prende tutto il bordo del parent
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
        }
        .padding(3)
        .frame(width: 100, height:100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    CurrencyIcon(currencyImage: .copperpenny, label: "Copper Penny")
}
