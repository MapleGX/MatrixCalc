//
//  RowSelector.swift
//  MatrixCalc
//
//  Created by Максим on 5.05.22.
//

import SwiftUI

struct RowSelector: View {
    @Binding var MatrixAValues: [String]
    @Binding var MatrixBValues: [String]
    @Binding var leftStepperValue: Int
    @Binding var rightStepperValue: Int
    @Binding var bottomLeftStepperValue: Int
    @Binding var bottomRightStepperValue: Int
    let geometry: GeometryProxy
    let rightside:Bool
    var body: some View {
        HStack(spacing: 0){
            if !rightside {
                Divider()
                    .padding([.leading, .top, .bottom], 5)
            }
            VStack{
                Divider()
                    .padding(.top, 5)
                    .padding(.bottom, 40)
                Divider()
                Spacer()
                if rightside {
                    StepperView(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: true, bottom: false, geo: geometry)
                } else {
                    StepperView(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: false, bottom: false, geo: geometry)
                }
                Button {
                    if rightside{
                        rightStepperValue = 0
                        bottomRightStepperValue = 0
                        MatrixBValues.removeAll()
                    } else {
                        leftStepperValue = 0
                        bottomLeftStepperValue = 0
                        MatrixAValues.removeAll()
                    }
                } label: {
                    ZStack {
                        Text("Clear")
                            .padding(.all, 5)
                            .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.05: geometry.size.height * 0.05))
                            .lineLimit(1)
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .padding(.all, 5)
                            .frame(maxHeight: geometry.size.height * 0.2)
                    }
                }
                .buttonStyle(.borderless)
                Divider()
                    .padding(.bottom, 5)
            }
            if rightside {
                Divider()
                    .padding([.top, .trailing, .bottom], 5)
            }
        }
        .frame(width: geometry.size.width * 0.1, height: geometry.size.height)
    }
}

struct RowSelector_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            HStack{
                RowSelector(MatrixAValues: .constant([]), MatrixBValues: .constant([]), leftStepperValue: .constant(0), rightStepperValue: .constant(0), bottomLeftStepperValue: .constant(0), bottomRightStepperValue: .constant(0), geometry: geo, rightside: false)
                Spacer()
                RowSelector(MatrixAValues: .constant([]), MatrixBValues: .constant([]), leftStepperValue: .constant(0), rightStepperValue: .constant(0), bottomLeftStepperValue: .constant(0), bottomRightStepperValue: .constant(0), geometry: geo, rightside: true)
            }
        }
    }
}
