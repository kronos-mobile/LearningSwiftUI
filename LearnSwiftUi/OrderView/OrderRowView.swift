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
        HStack(alignment: .firstTextBaseline) {
            Text(orderItem.description)
                .fontWeight(.bold)
            Spacer()
            Text(orderItem.formattedExtendedPrice)
                .bold()
        }
    }
}


struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(orderItem: testOrderItem)
            .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
    }
}
