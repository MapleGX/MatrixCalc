//
//  ContentView.swift
//  MatrixCalc
//
//  Created by Максим on 21.11.21.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct ContentView: View {
    @State private var leftStepperValue = 0
    @State private var rightStepperValue = 0
    @State private var bottomRightStepperValue = 0
    @State private var bottomLeftStepperValue = 0
    @State private var MatrixAValues:[String] = []
    @State private var MatrixBValues:[String] = []
    @State private var calculatedMatrix: [Int] = []
    @State private var showCalculatedMatrix = false
    @State private var showAlert = false
    @State private var matrixA = true
    @State private var column = 0
    @State private var alertText = ""
    @State private var dialogNum = ""
    @State private var selected = 0
    var body: some View {
        GeometryReader{ geometry in
            HStack(spacing: 0){
                RowSelector(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, geometry: geometry, rightside: false)
                Matrx(MatrixBValues: $MatrixBValues, MatrixAValues: $MatrixAValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: false, geometry: geometry)
                VStack{
                    Divider()
                        .padding(.top, 5)
                    Text("Matrix calc")
                        .padding(.vertical, 8)
                    Divider()
                    VStack{
                        let fontSize = geometry.size.height * 0.04
                        Button {
                            calcultaion(operationType: "+")
                        } label: {
                            ZStack {
                                Text("+")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            calcultaion(operationType: "-")
                        } label: {
                            ZStack {
                                Text("-")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            calcultaion(operationType: "*")
                        } label: {
                            ZStack {
                                Text("*")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            showAlert = true
                        } label: {
                            ZStack {
                                Text("*x")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            swap(&MatrixAValues, &MatrixBValues)
                            swap(&bottomLeftStepperValue, &bottomRightStepperValue)
                            swap(&leftStepperValue, &rightStepperValue)
                        } label: {
                            ZStack {
                                Text("<-->")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                    }
                    Divider()
                    Image("icon_128x128")
                        .resizable()
                        .padding(.all, 5)
                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.2)
                    Divider()
                        .padding(.bottom, 5)
                }
                .frame(maxWidth: geometry.size.width * 0.1)
                Matrx(MatrixBValues: $MatrixBValues, MatrixAValues: $MatrixAValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: true, geometry: geometry)
                RowSelector(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, geometry: geometry, rightside: true)
            }
            .sheet(isPresented: $showAlert) {
                VStack(spacing: 10){
                    Text("Choose matrix")
                        .padding(.top, 15)
                    Picker(selection: $selected, label: EmptyView()) {
                        Text("Matrix: A").tag(1)
                        Text("Matrix: B").tag(2)
                    }
                    .pickerStyle(.radioGroup)
                    .horizontalRadioGroupLayout()
                    VStack{
                        TextField("Input X for matrix", text: $dialogNum)
                            .padding(.horizontal, 10)
                            .lineLimit(1)
                            .onChange(of: dialogNum) { _ in
                                dialogNum = dialogNum.filter( { "0123456789".contains($0) })
                            }
                        Spacer()
                        HStack{
                            Spacer()
                            Button {
                                if selected == 1 {
                                    matrixA = true
                                    if dialogNum.count > 0 {
                                        calcultaion(operationType: "*a", num: Int(dialogNum) ?? 0)
                                        showAlert = false
                                    }
                                } else {
                                    matrixA = false
                                    if dialogNum.count > 0 {
                                        calcultaion(operationType: "*b", num: Int(dialogNum) ?? 0)
                                        showAlert = false
                                    }
                                }
                            } label: {
                                Text("Apply")
                            }
                            Spacer()
                            Button {
                                showAlert = false
                            } label: {
                                Text("Dismiss")
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: 175, height: 120)
            }
            .sheet(isPresented: $showCalculatedMatrix) { AnswerView(matrix: $calculatedMatrix, columns: $column) }
        }
        .frame(minWidth: 955, minHeight: 480)
    }
    func calcultaion(operationType: String, num: Int = 0){
        let IntMatrixA = MatrixAValues.map( { Int($0) ?? 0 } )
        let IntMatrixB = MatrixBValues.map( { Int($0) ?? 0 } )
        calculatedMatrix.removeAll()
        
        switch operationType {
            case "+":
                guard leftStepperValue == rightStepperValue && bottomLeftStepperValue == bottomRightStepperValue else { return }
                for i in IntMatrixA.indices { calculatedMatrix.append(IntMatrixA[i]  + IntMatrixB[i]) }
                column = bottomLeftStepperValue
            case "-":
                guard leftStepperValue == rightStepperValue && bottomLeftStepperValue == bottomRightStepperValue else { return }
                for i in IntMatrixA.indices { calculatedMatrix.append(IntMatrixA[i]  - IntMatrixB[i]) }
                column = bottomRightStepperValue
            case "*":
                guard IntMatrixA.count > 0 && IntMatrixB.count > 0 else { return }
                let matrixDimensA: [[Int]] = IntMatrixA.chunked(into: leftStepperValue)
                let matrixDimensB: [[Int]] = IntMatrixB.chunked(into: rightStepperValue)
                var arr = Array(repeating: Array(repeating: 0, count: leftStepperValue ), count: bottomRightStepperValue)
                if bottomLeftStepperValue == rightStepperValue {
                    for value1 in 0..<leftStepperValue{
                        for value2 in 0..<bottomRightStepperValue{
                            for value3 in 0..<bottomLeftStepperValue{
                                arr[value1][value2] += matrixDimensA[value3][value2] * matrixDimensB[value1][value3]
                            }
                        }
                    }
                } else { return }
                calculatedMatrix = Array(arr.joined())
                column = bottomRightStepperValue
            default:
                guard (matrixA ? IntMatrixA : IntMatrixB).count > 0 else { return }
                for i in (matrixA ? IntMatrixA : IntMatrixB).indices { calculatedMatrix.append((matrixA ? IntMatrixA[i] : IntMatrixB[i]) * num)}
                column = matrixA ? bottomLeftStepperValue : bottomRightStepperValue
        }
        if calculatedMatrix.count > 0 { showCalculatedMatrix = true }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
