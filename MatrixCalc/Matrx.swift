//
//  Matrx.swift
//  MatrixCalc
//
//  Created by Максим on 5.05.22.
//
import SwiftUI

struct Matrx: View {
    @Binding var MatrixBValues: [String]
    @Binding var MatrixAValues: [String]
    @Binding var leftStepperValue: Int
    @Binding var rightStepperValue: Int
    @Binding var bottomLeftStepperValue: Int
    @Binding var bottomRightStepperValue: Int
    let rightSide: Bool
    let geometry: GeometryProxy
    var body: some View {
        Group{
            Divider()
                .padding([.top, .bottom], 5)
            VStack{
                Divider()
                    .padding(.top, 5)
                Text(rightSide ?  "Matrix: B" : "Matrix: A")
                    .padding(.vertical, 8)
                Divider()
                if rightSide ? rightStepperValue == 0 || bottomRightStepperValue == 0 : (leftStepperValue == 0 || bottomLeftStepperValue == 0){
                    Spacer()
                } else {
                    let gridItemLayoutA: [GridItem] = Array(repeating: .init(.fixed(30)), count: rightSide ? bottomRightStepperValue : bottomLeftStepperValue)
                    Spacer()
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        LazyVGrid(columns: gridItemLayoutA, spacing: 10) {
                            ForEach(rightSide ? MatrixBValues.indices : MatrixAValues.indices, id: \.self){ cell in
                                ScrollView(.horizontal, showsIndicators: false){
                                    TextField(" 0 ", text:  rightSide ? $MatrixBValues[cell] : $MatrixAValues[cell])
                                        .lineLimit(1)
                                        .onChange(of: MatrixAValues) { _ in
                                            guard cell < MatrixAValues.count else { return }
                                            MatrixAValues[cell] = MatrixAValues[cell].filter( { "0123456789".contains($0) })
                                        }
                                        .onChange(of: MatrixBValues) { _ in
                                            guard cell < MatrixBValues.count else { return }
                                            MatrixBValues[cell] = MatrixBValues[cell].filter( { "0123456789".contains($0) })
                                        }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                }
                if rightSide {
                    StepperView(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: true, bottom: true, geo: geometry)
                } else {
                    StepperView(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: false, bottom: true, geo: geometry)
                }
                Button {
                    //
                } label: {
                    ZStack {
                        Text("Auto complete")
                            .padding()
                            .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.02: geometry.size.height * 0.02))
                            .lineLimit(1)
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .padding(.all, 5)
                    }
                    .frame(maxWidth: geometry.size.width * 0.14, maxHeight: geometry.size.height * 0.095)
                }
                .buttonStyle(.borderless)
                Divider()
                    .padding(.bottom, 5)
            }
            Divider()
                .padding([.top, .bottom], 5)
        }
    }
}

struct Matrx_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geo in
            Matrx(MatrixBValues: .constant([]), MatrixAValues: .constant([]), leftStepperValue: .constant(0), rightStepperValue: .constant(0), bottomLeftStepperValue: .constant(0), bottomRightStepperValue: .constant(0), rightSide: false, geometry: geo)
        }
    }
}
