//
//  ContentView.swift
//  MatrixCalc
//
//  Created by Максим on 21.11.21.
//

import SwiftUI

struct ContentView: View {
    @State var leftStepperValue = 0
    @State var rightStepperValue = 0
    @State var bottomrRightStepperValue = 0
    var body: some View {
        GeometryReader{ geometry in
            HStack(spacing: 0){
                Divider()
                    .padding([.leading, .top, .bottom], 5)
                VStack{
                    Divider()
                        .padding(.top, 5)
                        .padding(.bottom, 40)
                    Divider()
                    Spacer()
                    Divider()
                    HStack{
                        Stepper(value: $leftStepperValue,
                                in: 0...80,
                                step: 1) {
                            EmptyView()
                        }
                        Text("Строки: " + String(leftStepperValue))
                            .font(.system(size: geometry.size.height * 0.04))
                            .bold()
                            .padding(.trailing, 5)
                    }
                    Divider()
                    Button {
                        //
                    } label: {
                        ZStack {
                            Text("Clear")
                                .font(.system(size: geometry.size.height * 0.08))
                                .bold()
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2)
                                .padding(.all, 5)
                                .frame(width: geometry.size.width * 0.19, height: geometry.size.height * 0.19)
                                
                        }
                    }
                    .buttonStyle(.borderless)
                    Divider()
                        .padding(.bottom, 5)
                }
                Divider()
                    .padding([.top, .bottom], 5)
                VStack{
                    Divider()
                        .padding(.top, 5)
                    Text("Matrix: A")
                        .padding(.vertical, 8)
                    Divider()
                    if leftStepperValue == 0 {
                        Spacer()
                    } else {
                        EmptyView() // вставить код сюда
                    }
                    Divider()
                    HStack{
                        Stepper(value: $leftStepperValue,
                                in: 0...80,
                                step: 1) {
                            EmptyView()
                        }
                        Text("Столбцы: " + String(leftStepperValue))
                            .font(.system(size: geometry.size.height * 0.035))
                            .bold()
                            .padding(.trailing, 5)
                    }
                    .frame(height: geometry.size.height * 0.095)
                    Divider()
                    Button {
                        //
                    } label: {
                        ZStack {
                            Text("Clear")
                                .font(.system(size: geometry.size.height * 0.05))
                                .bold()
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2)
                                .padding(.all, 5)
                        }
                        .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.095)
                    }
                    .buttonStyle(.borderless)
                    Divider()
                        .padding(.bottom, 5)
                }
                Divider()
                    .padding([.top, .bottom], 5)
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
                                    .stroke(Color.purple, lineWidth: 2)
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
                                    .stroke(Color.purple, lineWidth: 2)
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
                                    .stroke(Color.purple, lineWidth: 2)
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
                                    .stroke(Color.purple, lineWidth: 2)
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
                                    .stroke(Color.purple, lineWidth: 2)
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
                Divider()
                    .padding([.top, .bottom], 5)
                VStack  {
                    Divider()
                        .padding(.top, 5)
                    Text("Matrix: B")
                        .padding(.vertical, 8)
                    Divider()
                    if rightStepperValue == 0 {
                        Spacer()
                    } else {
                        EmptyView() // вставить код сюда
                    }
                    Divider()
                    HStack{
                        Text("Столбцы: " + String(bottomrRightStepperValue))
                            .font(.system(size: geometry.size.height * 0.035))
                            .bold()
                            .padding(.leading, 5)
                        Stepper(value: $bottomrRightStepperValue,
                                in: 0...80,
                                step: 1) {
                            EmptyView()
                        }
                    }
                    .frame(height: geometry.size.height * 0.095)
                    Divider()
                    Button {
                        //
                    } label: {
                        ZStack {
                            Text("Clear")
                                .font(.system(size: geometry.size.height * 0.05))
                                .bold()
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2)
                                .padding(.all, 5)
                        }
                        .frame(maxWidth: geometry.size.width * 0.13, maxHeight: geometry.size.height * 0.095)
                    }
                    .buttonStyle(.borderless)
                    Divider()
                        .padding(.bottom, 5)
                }
                Divider()
                    .padding([.top, .bottom], 5)
                Group {
                    VStack{
                        Divider()
                            .padding(.top, 5)
                            .padding(.bottom, 40)
                        Divider()
                        Spacer()
                        Divider()
                        HStack{
                            Text("Строки: " + String(rightStepperValue))
                                .font(.system(size: geometry.size.height * 0.04))
                                .bold()
                                .padding(.leading, 5)
                            Stepper(value: $rightStepperValue,
                                    in: 0...80,
                                    step: 1) {
                                EmptyView()
                            }
                        }
                        Divider()
                        Button {
                            //
                        } label: {
                            ZStack {
                                Text("Clear")
                                    .font(.system(size: geometry.size.height * 0.08))
                                    .bold()
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.purple, lineWidth: 2)
                                    .padding(.all, 5)
                                    .frame(width: geometry.size.width * 0.19, height: geometry.size.height * 0.19)
                                    
                            }
                        }
                        .buttonStyle(.borderless)
                        Divider()
                            .padding(.bottom, 5)
                    }
                    Divider()
                        .padding([.top, .trailing, .bottom], 5)
                }
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
