//
//  AnswerView.swift
//  MatrixCalc
//
//  Created by Максим on 12.05.22.
//

import SwiftUI

struct AnswerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var matrix: [Int]
    @Binding var columns: Int
    var body: some View {
        VStack{
            ScrollView([.vertical,.horizontal], showsIndicators: false, content: {
                let gridItemLayoutA: [GridItem] = Array(repeating: .init(.fixed(30)), count: columns)
                LazyVGrid(columns: gridItemLayoutA, spacing: 10) {
                    ForEach(matrix.indices, id: \.self){ cell in
                        Text(String(matrix[cell]))
                    }
                }
            })
            .padding([.top, .horizontal])
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
                    .padding(.bottom, 10)
            }
            .buttonStyle(.borderless)
        }
        .frame(width: 300, height: 180)
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(matrix: .constant([1]), columns: .constant(1))
    }
}
