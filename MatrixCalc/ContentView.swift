//
//  ContentView.swift
//  MatrixCalc
//
//  Created by Максим on 21.11.21.
//

import SwiftUI

struct ContentView: View {
    @State private var leftStepperValue = 0
    @State private var rightStepperValue = 0
    @State private var bottomRightStepperValue = 0
    @State private var bottomLeftStepperValue = 0
    @State private var MatrixAValues:[String] = []
    @State private var MatrixBValues:[String] = []
    @State private var calculatedMatrix: [Int] = []
    @State private var showAlert = false
    @State private var showCalculatedMatrix = false
    @State private var alertText = ""
    @State private var dialogNumA = ""
    @State private var dialogNumB = ""
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
                            //
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
                VStack{
                    Text("Choose matrix")
                        .padding(.top, 20)
                    Spacer()
                        HStack{
                            VStack{
                                TextField("Input X for matrix A", text: $dialogNumA)
                                    .padding(.leading, 5)
                                    .lineLimit(1)
                                    .onChange(of: dialogNumA) { _ in
                                        dialogNumA = dialogNumA.filter( { "0123456789".contains($0) })
                                    }
                                Spacer()
                                Button {
                                    calcultaion(operationType: "*x", matrixA: true, num: Int(dialogNumA) ?? 0)
                                    showAlert = false
                                } label: {
                                    Text("Matrix A")
                                }
                            }
                            VStack{
                                TextField("Input X for matrix B", text: $dialogNumB)
                                    .padding(.trailing, 5)
                                    .lineLimit(1)
                                    .onChange(of: dialogNumB) { _ in
                                        dialogNumB = dialogNumB.filter( { "0123456789".contains($0) })
                                    }
                                Spacer()
                                Button {
                                    calcultaion(operationType: "*x", matrixA: false, num: Int(dialogNumB) ?? 0)
                                    showAlert = false
                                } label: {
                                    Text("Matrix B")
                                }
                            }
                        }
                    Button {
                        showAlert = false
                    } label: {
                        Text("Dismiss")
                    }
                    .padding(.bottom, 20)
                }
                .frame(width: 300, height: 120)
            }
            .sheet(isPresented: $showCalculatedMatrix){
                AnswerView(matrix: $calculatedMatrix, columns: $bottomLeftStepperValue)
            }
        }
        .frame(minWidth: 955, minHeight: 480)
    }
    func calcultaion(operationType: String, matrixA: Bool = false, num: Int = 0){
        let IntMatrixA = MatrixAValues.map( { Int($0) ?? 0 } )
        let IntMatrixB = MatrixBValues.map( { Int($0) ?? 0 } )
        calculatedMatrix.removeAll()
        guard IntMatrixB.count > 0 && IntMatrixA.count > 0 else {
            return
        }
        switch operationType {
            case "+":
                if leftStepperValue == rightStepperValue && bottomLeftStepperValue == bottomRightStepperValue {
                    for i in IntMatrixA.indices {
                        calculatedMatrix.append(IntMatrixA[i]  + IntMatrixB[i])
                    }
                } else { return }
            case "-":
                if leftStepperValue == rightStepperValue && bottomLeftStepperValue == bottomRightStepperValue {
                    for i in IntMatrixA.indices {
                        calculatedMatrix.append(IntMatrixA[i]  - IntMatrixB[i])
                    }
                } else { return }
            case "*":
               return
            default:
                if matrixA {
                    for i in IntMatrixA.indices {
                        calculatedMatrix.append(IntMatrixA[i] * num)
                    }
                } else {
                    for i in IntMatrixB.indices {
                        calculatedMatrix.append(IntMatrixB[i] * num)
                    }
                }
        }
        showCalculatedMatrix = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
