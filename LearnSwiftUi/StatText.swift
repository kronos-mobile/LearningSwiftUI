//
//  StatText.swift
//  LearnSwiftUi
//
//  Created by Vanessa Milagros on 5/26/20.
//

import SwiftUI

struct StatText: View {
    var statName: String
    var statValue: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(statName + ":")
                .font(.system(size: 45))
                .fontWeight(.bold)
                .padding(.leading, 30)
            Text(statValue).font(.system(size: 40))
                .fontWeight(.light)
            Spacer()
        }
    }
}

struct StatText_Previews: PreviewProvider {
    static var previews: some View {
        StatText(statName: "Age", statValue: "32")
    }
}
