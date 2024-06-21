//
//  Currency.swift
//  LOTRConverter17
//
//  Created by ulixe on 16/04/24.
//
import SwiftUI

enum Currency : Double, CaseIterable, Identifiable, Codable {
    //id perchè per usare Identifiable lo richiede
    var id: Currency { self }
    
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var image : ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny :
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name : String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    //se non vogliamo per forza mettere il nome del parametro quando richiamiamo la funzione
    // basta mettere _ di fianco al nome del parametro che è il label name mi pare, diverso dal
    // parameter name che ci deve sempre essere
    func convert(_ amountString : String, to currency : Currency) -> String {
        // guard perchè se vengono inserite parole o altre cose al posto di numeri non crasha la conversione
        guard let doubleAmount = Double(amountString) else {
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        // per troncare la stringa alle prime due cifre dopo la virgola
        return String(format: "%.2f", convertedAmount)
    }
}
