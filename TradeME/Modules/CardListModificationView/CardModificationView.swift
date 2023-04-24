//
//  CardModificationView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/22/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardModificationView: View {
    @State var count = 1 // initial value

    let card: CardContainer
    
    var body: some View {
        HStack {
            HStack {
                Button("-") {
                    self.count -= 1
                }
                .frame(width: 50, height: 50)
                .padding()

                Text("\(count)")
                    .padding()

                Button("+") {
                    self.count += 1
                }
                .frame(width: 50, height: 50)
                .padding()
                // Display the image with a cache key
                WebImage(url: APIS.CardImage.name(name: card.name).url)
                    .resizable()
                    .scaledToFit()
            }
            
            VStack(alignment: .leading) {
                Text("\(card.name)")
                    .font(.headline)
                    .padding(.bottom, 2)

                Text("\(card.card.printTag)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)

                Text("\(card.total.formatted(.currency(code: "USD")))")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
            }
        }
        .padding()
    }
}

