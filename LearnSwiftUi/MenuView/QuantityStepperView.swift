//
//  QuantityStepperView.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 4/26/20.
//

import SwiftUI

struct QuantityStepperView: View {
    @Binding var quantity: Int
    var body: some View {
        Stepper(value: $quantity, in: 1...10) {
            Text("Quantity: \(quantity)")
                .bold()
        }
        .padding()
    }
}

struct QuantityStepperView_Previews: PreviewProvider {
    static var previews: some View {
        QuantityStepperView(quantity: .constant(1))
    }
}
