//
//  CardPrinting.swift
//  Lab3Card
//
//  Created by Pranav Mittal on 9/16/23.
//

import SwiftUI

struct CardPrinting: View {
        
//    @Binding var newVarCard: CardDetails
    var holdName: String = ""
    var body: some View {
        Text("\(holdName)")
    }
}
struct CardPrinting_Previews: PreviewProvider {
    static var previews: some View {
        CardPrinting()
    }
}
