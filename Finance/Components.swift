//
//  Components.swift
//  Finance
//
//  Created by Gautam Menon on 27/08/23.
//

import SwiftUI

struct ProfitArrow: View {
    let isUp: Bool
    var body: some View {
        if isUp {
            Image(systemName: "arrow.up")
                .foregroundColor(.green)
        } else {
            Image(systemName: "arrow.down")
                .foregroundColor(.red)
        }
    }
}

struct Components_Previews: PreviewProvider {
    static var previews: some View {
        ProfitArrow(isUp: true)
    }
}

struct TransactionTile: View {
    let transaction: TransactionModel
    let isMine: Bool
    var body: some View {
        
        HStack {
            ProfileIcon(name: transaction.name.uppercased(), backgroundColor: isMine ? appColor : secondaryColor, foregroundColor:  isMine ? .white : .black, font: .body)
                .frame(width: 50)
            VStack (alignment: .leading){
                Text("\(transaction.name)")
                    .fontWeight(.semibold)
                Text("\(transaction.reason ?? "")").multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            Spacer()
            Text(currencyy.string(from: (transaction.amount.convertToPositive() as NSNumber))!)
            ProfitArrow(isUp: isMine)
        }
        
        .foregroundColor(.black)
    }
}

struct FilterTile: View {
    let element: SortTypes
    let isSelected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10).frame(width: filterWidth, height: 40)
            .foregroundColor(isSelected ? .black : .white)
            .overlay {
                Text(element.rawValue)
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
    }
}

struct ProfitTitle: View {
    let totalAmount: Int
    var body: some View {    let isUp = totalAmount > 0
        HStack {
            Group {
                ProfitArrow(isUp: isUp)
                    .font(.largeTitle)
            }
            VStack {
                Text(currencyy.string(from: (totalAmount.convertToPositive() as NSNumber))!)
                    .fontWeight(.semibold)
                    .font(.title)
                
                if isUp {
                    Text("You Are Owed")
                        .fontWeight(.semibold)
                        .font(.body)
                        .foregroundColor(.gray)
                        .foregroundColor(isUp ? .green : .red)
                } else{
                    Text("You Owe")
                        .fontWeight(.semibold)
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
            ProfitArrow(isUp: isUp)
                .font(.largeTitle)
                .opacity(0)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(20)
        .padding()
    }
}

struct FilterView: View {
    @Binding var filter: SortTypes
    let reloadWithLoader: () async ->()
    var body: some View {
        HStack{
            ForEach(SortTypes.allCases) { element in
                let isSelected = filter == element
                Button {
                    filter = element
                   Task{
                       await reloadWithLoader()
                   }
                } label: {
                    FilterTile(element: element, isSelected: isSelected)
                }
            }
        }
    }
}

struct ProfileIcon: View {
    let name: String
    let backgroundColor: Color
    let foregroundColor: Color
    let font: Font
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(backgroundColor)
            .overlay{
                Text(name
                    .prefix(1))
                .fontWeight(.bold)
                .font(font)
                .foregroundColor(foregroundColor)
            }
    }
}
