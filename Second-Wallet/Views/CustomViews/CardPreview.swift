//
//  CardPreview.swift
//  Second-Wallet
//
//  Created by Miguel Teixeira on 03/08/2020.
//

import SwiftUI

struct CardPreview: View {
    var viewModel: CardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.firstTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(viewModel.backgroundColor.isDarkColor)
            Text(viewModel.secondTitle.uppercased())
                .font(.title3)
                .foregroundColor(viewModel.backgroundColor.isDarkColor)
        }
        
        Text(viewModel.thirdTitle.uppercased())
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(viewModel.backgroundColor.isDarkColor)
        
        HStack {
            Spacer()
            
            Text(viewModel.date)
                .font(.caption)
                .foregroundColor(viewModel.backgroundColor.isDarkColor)
        }
    }
}

struct CardPreview_Previews: PreviewProvider {
    static var previews: some View {
        CardPreview(viewModel: CardViewModel(card: cardsPreview[1]))
    }
}
