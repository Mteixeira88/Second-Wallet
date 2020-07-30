//
//  AddNewCard.swift
//  Second-Wallet
//
//  Created by Miguel Teixeira on 30/07/2020.
//

import SwiftUI

struct AddNewCard: View {
    @State var showNewCard = false
    
    var body: some View {
        VStack {
            Button("\(Image(systemName: "plus")) Add new card", action: {
                showNewCard.toggle()
            })
        }
        .sheet(isPresented: $showNewCard, content: {
            NewCardFormView()
        })
    }
}

struct AddNewCard_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCard()
    }
}
