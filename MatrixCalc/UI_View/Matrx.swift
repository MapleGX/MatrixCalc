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
    @State var showWindow = false
    @State var selected = 0
    @State var BeginingOfRange = ""
    @State var EndingOfRange = ""
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
                    let gridItemLayout: [GridItem] = Array(repeating: .init(.fixed(30), spacing: 10), count: rightSide ? bottomRightStepperValue : bottomLeftStepperValue)
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        LazyVGrid(columns: gridItemLayout, spacing: 10) {
                            ForEach(rightSide ? MatrixBValues.indices : MatrixAValues.indices, id: \.self){ cell in
                                ScrollView(.horizontal, showsIndicators: false){
                                    TextField("0", text:  rightSide ? $MatrixBValues[cell] : $MatrixAValues[cell])
                                        .lineLimit(1)
                                        .onChange(of: rightSide ? MatrixBValues : MatrixAValues) { _ in
                                            guard cell < (rightSide ? MatrixBValues : MatrixAValues).count else { return }
                                            if rightSide { MatrixBValues[cell] = MatrixBValues[cell].filter({"0123456789-".contains($0)})}
                                            else { MatrixAValues[cell] = MatrixAValues[cell].filter({"0123456789-".contains($0)}) }
                                        }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                if rightSide {
                    StepperView(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: true, bottom: true, geo: geometry)
                } else {
                    StepperView(MatrixAValues: $MatrixAValues, MatrixBValues: $MatrixBValues, leftStepperValue: $leftStepperValue, rightStepperValue: $rightStepperValue, bottomLeftStepperValue: $bottomLeftStepperValue, bottomRightStepperValue: $bottomRightStepperValue, rightSide: false, bottom: true, geo: geometry)
                }
                Button {
                    showWindow = true
                } label: {
                    ZStack {
                        Text("Auto complete")
                            .padding()
                            .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.02: geometry.size.height * 0.02))
                            .lineLimit(1)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .padding(.all, 5)
                    }
                    .frame(maxHeight: geometry.size.height * 0.095)
                }
                .buttonStyle(.borderless)
                Divider()
                    .padding(.bottom, 5)
            }
            Divider()
                .padding([.top, .bottom], 5)
        }
        .sheet(isPresented: $showWindow) {
            VStack{
                Text("Enter range for autocomplete with Random")
                    .padding(.vertical, 5)
                Picker(selection: $selected, label: EmptyView()) {
                    Text("Matrix: A").tag(1)
                    Text("Matrix: B").tag(2)
                }
                .pickerStyle(.radioGroup)
                .horizontalRadioGroupLayout()
                HStack{
                    TextField("Enter range Begining", text:  $BeginingOfRange)
                        .padding(.horizontal, 5)
                        .onChange(of: BeginingOfRange) { _ in
                            BeginingOfRange = BeginingOfRange.filter( { "0123456789-".contains($0) })
                        }
                    Text("...")
                    TextField("Enter range Ending", text: $EndingOfRange)
                        .padding(.horizontal, 5)
                        .onChange(of: EndingOfRange) { _ in
                            EndingOfRange = EndingOfRange.filter( { "0123456789-".contains($0) })
                        }
                }
                HStack{
                    Spacer()
                    Button {
                        guard (BeginingOfRange.count > 0 && EndingOfRange.count > 0) && EndingOfRange >= BeginingOfRange else { return }
                        if selected == 1 {
                            MatrixAValues.indices.forEach( { MatrixAValues[$0] = String(Int.random(in: (Int(BeginingOfRange) ?? 1)...(Int(EndingOfRange) ?? 1))) } )
                        } else {
                            MatrixBValues.indices.forEach( { MatrixBValues[$0] = String(Int.random(in: (Int(BeginingOfRange) ?? 1)...(Int(EndingOfRange) ?? 1))) } )
                        }
                    } label: {
                        Text("Apply")
                    }
                    Spacer()
                    Button {
                        showWindow = false
                    } label: {
                        Text("Dismiss")
                    }
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            .frame(width: 300, height: 120)
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
