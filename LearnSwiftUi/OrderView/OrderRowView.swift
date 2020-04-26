//
//  OrderRowView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/25/20.
//

import SwiftUI

struct OrderRowView: View {
    var orderItem: OrderItem
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Image(systemName: "\(orderItem.id).square")
                Text(orderItem.description)
                    .fontWeight(.bold)
                Spacer()
                Text(orderItem.formattedExtendedPrice)
                    .bold()
            }
            
            Text(orderItem.comments)
        }
        .animation(.none)
    }
}


struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(orderItem: testOrderItem)
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
