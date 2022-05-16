//
//  StepperView.swift
//  MatrixCalc
//
//  Created by Максим on 5.05.22.
//

import SwiftUI

struct StepperView: View {
    @Binding var MatrixAValues: [String]
    @Binding var MatrixBValues: [String]
    @Binding var leftStepperValue: Int
    @Binding var rightStepperValue: Int
    @Binding var bottomLeftStepperValue: Int
    @Binding var bottomRightStepperValue: Int
    let rightSide:Bool
    let bottom:Bool
    let geo: GeometryProxy
    private func increase(topStep: Int, bottomStep: Int, Matrix: [String]) -> [String] {
        var matrix = Matrix
        guard bottom else {
            while matrix.count < topStep * bottomStep { matrix.append("") }
            return matrix
        }
        for i in stride(from: bottomStep - 1, to: topStep * bottomStep, by: bottomStep) { matrix.insert("", at: i) }
        return matrix
    }
    func decrease(topStep: Int, bottomStep: Int, Matrix: [String]) -> [String] {
        var matrix = Matrix
        guard topStep > 0 && bottomStep > 0 else { return [] }
        guard bottom else {
            matrix.removeSubrange((topStep - 1) * bottomStep...Matrix.count - 1)
            return matrix
        }
        for i in stride(from: Matrix.count - 1, to: bottomStep - 2, by: -bottomStep) { matrix.remove(at: i) }
        return matrix
    }
    var body: some View {
        VStack(spacing: 2){
            Divider()
            if rightSide {
                HStack(spacing: 5){
                    Text(bottom ? "Column's: " + String(bottomRightStepperValue) : "Row's: " + String(rightStepperValue))
                        .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.035: geo.size.height * 0.035))
                        .lineLimit(1)
                        .padding(.leading, 5)
                    Stepper {
                        EmptyView()
                    } onIncrement: {
                        if bottom { bottomRightStepperValue += 1 } else { rightStepperValue += 1 }
                        MatrixBValues = increase(topStep: rightStepperValue, bottomStep: bottomRightStepperValue, Matrix: MatrixBValues)
                    } onDecrement: {
                        MatrixBValues = decrease(topStep: rightStepperValue, bottomStep: bottomRightStepperValue, Matrix: MatrixBValues)
                        if bottom {
                            guard bottomRightStepperValue > 0 else { return }
                            bottomRightStepperValue -= 1
                        } else {
                            guard rightStepperValue > 0 else { return }
                            rightStepperValue -= 1
                        }
                    }
                }
                .padding(.vertical)
            } else {
                HStack(spacing: 5){
                    Stepper {
                        EmptyView()
                    } onIncrement: {
                        if bottom { bottomLeftStepperValue += 1 } else { leftStepperValue += 1 }
                        MatrixAValues = increase(topStep: leftStepperValue, bottomStep: bottomLeftStepperValue, Matrix: MatrixAValues)
                    } onDecrement: {
                        MatrixAValues = decrease(topStep: leftStepperValue, bottomStep: bottomLeftStepperValue, Matrix: MatrixAValues)
                        if bottom {
                            guard bottomLeftStepperValue > 0 else { return }
                            bottomLeftStepperValue -= 1
                        } else {
                            guard leftStepperValue > 0 else { return }
                            leftStepperValue -= 1
                        }
                    }
                    Text(bottom ? "Column's: " + String(bottomLeftStepperValue) : "Row's: " + String(leftStepperValue))
                        .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.035: geo.size.height * 0.035))
                        .lineLimit(1)
                        .padding(.trailing, 5)
                }
                .padding(.vertical)
            }
            Divider()
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geo in
            StepperView(MatrixAValues: .constant([]), MatrixBValues: .constant([]), leftStepperValue: .constant(0), rightStepperValue: .constant(0), bottomLeftStepperValue: .constant(0), bottomRightStepperValue: .constant(0), rightSide: true, bottom: true, geo: geo)
                .padding()
                .frame(width: 180, height: 60)
        }
    }
}
