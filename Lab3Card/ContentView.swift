//
//  ContentView.swift
//  Lab3Card
//
//  Created by Pranav Mittal on 9/15/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name: String = ""
    @State private var bank: String = ""
    //@State private var defCard = "VISA"
    @State private var defCard = CardDetails()   //Use any of these
    @State private var cardNumber: String = ""
    @State private var rawNum: String = ""
    @State private var secureCode: String = ""
    @State private var secCode: String = ""
    @State private var selectedDate = Date()
    @State private var cardColors = CardDetails()  //Use any of these
    @State private var selectedColor = Colors.blue
    @State private var isShowingSheet = false
    @State private var newCardVar = CardDetails()   //Use any of these
    
    
    
    //let CardType = ["VISA", "Mastercard", "Amex", "Discover"]

    var body: some View {
//        NavigationView{
            VStack {
                Text("Add Card").bold().font(.system(size: 30))
                Form{
                    
                    Section(header: Text("SIGNATURE")){
                        TextField("Card Holder Name", text: $newCardVar.holderName)
                        TextField("Bank", text: $newCardVar.bank)
                        Picker("Card Type", selection: $newCardVar.type){
                            ForEach(CardType.allCases, id: \.self){
                                card in Text(card.rawValue)
                            }
                        }.pickerStyle(.menu)
                    }
                    
                    Section(header: Text("DETAILS")){
                        
                        
                        TextField("Card Number", text: $cardNumber)
                            .onChange(of: cardNumber){ newNum in
                                rawNum = newNum.filter { "0123456789".contains($0) }
                                if rawNum.count > 16 {
                                    rawNum = String(rawNum.prefix(16))
                                }
                                cardNumber = formatCardNumber(rawNum)
                            }

                      
                        TextField("Secure Code", text: $newCardVar.secureCode)
                            .onChange(of: newCardVar.secureCode){ finalSecNum in
                                secCode = finalSecNum.filter{"0123456789".contains($0)}
                                if secCode.count > 3{
                                    secCode = String(secCode.prefix(3))
                                }
                                newCardVar.secureCode = secCode
                            }
                        
                        
                        DatePicker("Valid Through", selection: $newCardVar.validity, displayedComponents: [.date])
                    }
                    
                    Section(header: Text("CARD COLOR")){
                        HStack{
                            Circle().fill(Color.black).frame(width: 80, height: 50).onTapGesture {
                                newCardVar.color = Colors.black
                            }
                            Circle().fill(Color.blue).frame(width: 80, height: 50).onTapGesture {
                                newCardVar.color = Colors.blue
                            }
                            Circle().fill(Color.red).frame(width: 80, height: 50).onTapGesture {
                                newCardVar.color = Colors.red
                            }
                            Circle().fill(Color.green).frame(width: 80, height: 50).onTapGesture {
                                newCardVar.color = Colors.green
                            }
                        }

//                        Picker("Select a Color", selection: $selectedColor){
//                            Text("Black").tag(Color.black)
//                            Text("Blue").tag(Color.blue)
//                            Text("Red").tag(Color.red)
//                            Text("Green").tag(Color.green)
//
//                        }.pickerStyle(.segmented)
                    }
                        
                    Button("Add Card to Wallet"){ isShowingSheet.toggle()
                        
                    }.sheet(isPresented: $isShowingSheet) {
                        VStack {
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 25).fill(newCardVar.color).frame(width: 350, height: 225)
                                Text("\(newCardVar.bank)").foregroundColor(Color.white).textCase(.uppercase).font(.system(size: 30)).position(x: 100, y: 70)
                                
                                Text("\(newCardVar.type.rawValue)").foregroundColor(Color.white).textCase(.uppercase).font(.system(size: 20)).position(x: 280, y: 80)
                                
                                Text("\(newCardVar.holderName)").foregroundColor(Color.white).font(.system(size: 30)).bold().position(x: 135, y: 150)
                                
                                Text("Valid Thru: \(newCardVar.formattedValidity)").foregroundColor(Color.white).font(.system(size: 15)).position(x: 105, y: 185)
                                
                                Text("Secure Code: \(newCardVar.secureCode)").foregroundColor(Color.white).font(.system(size: 15)).position(x: 250, y: 185)
                                
                                Text("\(cardNumber)").foregroundColor(Color.white).font(.system(size: 25)).position(x: 170, y: 220).bold()
                            }
                            
                            
                        Button("") {
                        isShowingSheet.toggle()
                            }
                        }.presentationDetents([.height(300)])
                    }
                }
                
            }
            
    }
    
    func formatCardNumber(_ string: String) -> String {
        var formatted = string
        
        if string.count > 4{
            formatted.insert(" ", at: formatted.index(formatted.startIndex, offsetBy: 4))
        }
        if string.count > 9{
            formatted.insert(" ", at: formatted.index(formatted.startIndex, offsetBy: 9))
        }
        if string.count > 14{
            formatted.insert(" ", at: formatted.index(formatted.startIndex, offsetBy: 14))
        }
        return formatted
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
