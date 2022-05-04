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
    var body: some View {
        GeometryReader{ geometry in
            HStack(spacing: 0){
                Group{
                    Divider()
                        .padding([.leading, .top, .bottom], 5)
                    VStack{
                        Divider()
                            .padding(.top, 5)
                            .padding(.bottom, 40)
                        Divider()
                        Spacer()
                        Divider()
                        HStack(spacing: 5){
                            Stepper {
                                EmptyView()
                            } onIncrement: {
                                leftStepperValue += 1
                                while MatrixAValues.count < leftStepperValue * bottomLeftStepperValue {
                                    MatrixAValues.append("")
                                }
                            } onDecrement: {
                                if leftStepperValue > 0 {
                                    leftStepperValue -= 1
                                    if bottomLeftStepperValue > 0 {
                                        MatrixAValues.removeSubrange(leftStepperValue * bottomLeftStepperValue...MatrixAValues.count - 1)
                                    }
                                }
                            }
                            Text("Row's: " + String(leftStepperValue))
                                .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.035: geometry.size.height * 0.035))
                                .lineLimit(1)
                                .padding(.trailing, 5)
                        }
                        Divider()
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("Clear")
                                    .padding(.all, 5)
                                    .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.1: geometry.size.height * 0.1))
                                    .lineLimit(1)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2)
                            }
                        }
                        .buttonStyle(.borderless)
                        Divider()
                            .padding(.bottom, 5)
                    }
                }
             //  .frame(width: geometry.size.width * 0.1)
                Group{
                    Divider()
                        .padding([.top, .bottom], 5)
                    
                    VStack{
                        Divider()
                            .padding(.top, 5)
                        Text("Matrix: A")
                            .padding(.vertical, 8)
                        Divider()
                        if leftStepperValue == 0 || bottomLeftStepperValue == 0{
                            Spacer()
                        } else {
                            let gridItemLayoutA = Array(repeating: GridItem(), count: bottomLeftStepperValue)
                            Spacer()
                            LazyVGrid(columns: gridItemLayoutA) {
                                ForEach(0...(leftStepperValue * bottomLeftStepperValue) - 1, id: \.self){ cell in
                                    TextEditor(text: $MatrixAValues[cell])
                                }
                            }
                            Spacer()
                        }
                        Divider()
                        HStack(spacing: 5){
                            Stepper {
                                EmptyView()
                            } onIncrement: {
                                bottomLeftStepperValue += 1
                                while MatrixAValues.count < leftStepperValue * bottomLeftStepperValue {
                                    MatrixAValues.append("")
                                }
                            } onDecrement: {
                                if bottomLeftStepperValue > 0 {
                                    bottomLeftStepperValue -= 1
                                    if leftStepperValue > 0 {
                                        MatrixAValues.removeSubrange(leftStepperValue * bottomLeftStepperValue...MatrixAValues.count - 1)
                                    }
                                }
                            }
                            Text("Column's: " + String(bottomLeftStepperValue))
                                .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.03: geometry.size.height * 0.03))
                                .lineLimit(1)
                                .padding(.trailing, 5)
                        }
                        .frame(height: geometry.size.height * 0.095)
                        Divider()
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
             //   .frame(width: .infinity)
                VStack{
                    Divider()
                        .padding(.top, 5)
                    Text("Matrix calc")
                        .padding(.vertical, 8)
                    Divider()
                    VStack{
                        let fontSize = geometry.size.height * 0.04
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("+")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("-")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.33, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("*")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.33, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("*x")
                                    .font(.system(size: fontSize))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(maxWidth: geometry.size.width * 0.33, maxHeight: geometry.size.height * 0.2)
                                
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
                                    .frame(maxWidth: geometry.size.width * 0.33, maxHeight: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                    } // есть ошибка где то тут
                    Divider()
                    Image("icon_128x128")
                        .resizable()
                        .padding(.all, 5)
                        .frame(width: geometry.size.width * 0.19, height: geometry.size.height * 0.19)
                    Divider()
                        .padding(.bottom, 5)
                }
             //   .frame(width: geometry.size.width * 0.1)
                Group {
                    Divider()
                        .padding([.top, .bottom], 5)
                    VStack{
                        Divider()
                            .padding(.top, 5)
                        Text("Matrix: B")
                            .padding(.vertical, 8)
                        Divider()
                        if rightStepperValue == 0 || bottomRightStepperValue == 0 {
                            Spacer()
                        } else {
                            let gridItemLayoutB = Array(repeating: GridItem(), count: bottomRightStepperValue)
                            Spacer()
                            LazyVGrid(columns: gridItemLayoutB){
                                ForEach(0...(bottomRightStepperValue * rightStepperValue) - 1 , id: \.self){ cell in
                                    TextEditor(text: $MatrixBValues[cell])
                                }
                            }
                            Spacer()
                        }
                        Divider()
                        HStack(spacing: 5){
                            Text("Column's: " + String(bottomRightStepperValue))
                                .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.03: geometry.size.height * 0.03))
                                .lineLimit(1)
                                .padding(.leading, 5)
                            Stepper {
                                EmptyView()
                            } onIncrement: {
                                bottomRightStepperValue += 1
                                while MatrixBValues.count < rightStepperValue * bottomRightStepperValue {
                                    MatrixBValues.append("")
                                }
                            } onDecrement: {
                                if bottomRightStepperValue > 0 {
                                    bottomRightStepperValue -= 1
                                    if rightStepperValue > 0 {
                                        MatrixBValues.removeSubrange(rightStepperValue * bottomRightStepperValue...MatrixBValues.count - 1)
                                    }
                                }
                            }
                        }
                        .frame(height: geometry.size.height * 0.095)
                        Divider()
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
             //   .frame(width: .infinity)
                Group{
                    VStack{
                        Divider()
                            .padding(.top, 5)
                            .padding(.bottom, 40)
                        Divider()
                        Spacer()
                        Divider()
                        HStack(spacing: 5){
                            Text("Row's: " + String(rightStepperValue))
                                .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.035: geometry.size.height * 0.035))
                                .lineLimit(1)
                                .padding(.leading, 5)
                            Stepper {
                                EmptyView()
                            } onIncrement: {
                                rightStepperValue += 1
                                while MatrixBValues.count < rightStepperValue * bottomRightStepperValue {
                                    MatrixBValues.append("")
                                }
                            } onDecrement: {
                                if rightStepperValue > 0 {
                                    rightStepperValue -= 1
                                    if bottomRightStepperValue > 0 {
                                        MatrixBValues.removeSubrange(rightStepperValue * bottomRightStepperValue...MatrixBValues.count - 1)
                                    }
                                }
                            }
                        }
                        Divider()
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("Clear")
                                    .padding(.all, 5)
                                    .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.1: geometry.size.height * 0.1))
                                    .lineLimit(1)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2)
                                
                            }
                        }
                        .buttonStyle(.borderless)
                        Divider()
                            .padding(.bottom, 5)
                    }
                    Divider()
                        .padding([.top, .trailing, .bottom], 5)
                }
             //   .frame(width: geometry.size.width * 0.1)
            }
        }
        .frame(minWidth: 720, minHeight: 480)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
