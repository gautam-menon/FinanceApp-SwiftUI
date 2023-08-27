//
//  Widgets.swift
//  Finance_example
//
//  Created by Gautam on 15/12/22.
//
import SwiftUI

struct PersonTile: View {
    @Binding var selectedId: String
    let color: Color
    let name: String
    
    var body: some View {
        let isSelected: Bool = name == selectedId
        Button {
            withAnimation {
                selectedId = name
            }
        } label: {
            VStack{
                Text(name.uppercased().prefix(1))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(color)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(name.capitalized)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            .scaleEffect(isSelected ? 1.5 : 1.2)
            .padding(50)
            .overlay{
                if isSelected {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color, lineWidth: 4)
                }
            }
        }
    }
    
}
struct AddTransactionViw_Previews: PreviewProvider {
    static var previews: some View {
        PersonTile(selectedId: Binding(get: {
            return "otherId"
        }, set: { Value, Transaction in
            ""
        }), color:  secondaryColor, name: "otherId")
    }
}
