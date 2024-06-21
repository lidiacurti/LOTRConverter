//
//  ContentView.swift
//  LOTRConverter17
//
//  Created by ulixe on 15/04/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
//per cambiare valore  della variabile non basta var, serve un property wrapper
//     state perchè permette di dire: lascia che questa proprietà cambi lo stato della view
    @State var showExhangeInfo = false
    @State var showSelectCurrency = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    @State var leftCurrency : Currency = .silverPiece
    @State var rightCurrency : Currency = .goldPiece
    // servono per capire quando c'è focus sul textfield
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    var body: some View {
       
        ZStack {
//            background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
//                pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
//                currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                HStack {
//                    left conversion section
                    VStack {
//                        currency
                        HStack {
//                            currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
//                            currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
//                        textfield
                        // dollaro per dire che è una binding string altrimenti lo user non può cambiare valore della stringa
                        TextField("Amount",text:$leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                    }
//                    equal sign
//                    using SFSymbols for =
//                    systemName perchè non fanno parte degli asset
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
//                    right conversion section
                    VStack {
//                        currency
                        HStack {
//                            currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
//                            currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
//                        textfield
                        TextField("Amount",text:$rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
                            
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                Spacer()
//                Info button
                HStack{
                    Spacer()
                    Button {
                        showExhangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $showExhangeInfo){
                        Exchangeinfo()
                    }
                }

            }
            //.border(.blue)
        }
        .task {
            // ci permette di runnare questo codice in background quando lo schermo appare
            // try catch perchè configure potrebbe failare
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showSelectCurrency, content: {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        })
    }
}

#Preview {
    ContentView()
}
