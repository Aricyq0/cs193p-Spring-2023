//
//  ContentView.swift
//  Memorize
//
//  Created by Serein on 2024/11/12.
//

import SwiftUI

let wanshengjie:Array<String> = ["👻","🙊","😈","👾","🐜","🐘","😺","🐻‍❄️","🕷️","🏇","🦫"]

let foods = ["🐡","🍇","🍉","🍈","🦐","🍊","🍌"]

let face = ["😀","😗","😃","🤣","🥺","😭","😷","🌼"]

struct ContentView: View {
    @State var themeSelector = wanshengjie
    @State var themeColor = Color.orange
    
    var body: some View {
        Text("Memorize!")
            .font(.largeTitle)
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            themeSetters
        }
        .padding()
    }
    
    func themeSet(of content: String, symbol: String) -> some View {
        Button(action:{
            switch content {
            case "万圣节":
                themeSelector = wanshengjie.shuffled()
                themeColor = Color.orange
            case "食物":
                themeSelector = foods.shuffled()
                themeColor = Color.pink
            default:
                themeSelector = face.shuffled()
                themeColor = Color.cyan
            }
        } , label: {
            VStack(spacing:5) {
                Image(systemName: symbol)
                Text(content)
                    .font(.caption)
            }
        })
    }
    
    var themeSetters: some View{
        HStack(alignment: .lastTextBaseline) {
            themeSet(of: "万圣节", symbol: "hat.widebrim.fill")
            Spacer()
            themeSet(of: "食物", symbol: "fork.knife")
            Spacer()
            themeSet(of: "表情", symbol: "water.waves")
            
        }
        .imageScale(.large)
        .padding(.horizontal,80)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<themeSelector.count,id: \.self){ index in
                CardView(content: themeSelector[index])}
            .aspectRatio(2/3,contentMode: .fit)
        }
        .foregroundColor(themeColor)
    }
    
}

struct CardView: View {
    let content : String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            /*
             Error Usage: isFaceUp = !isFaceUp
             Error: Cannot assign to property: 'self' is immutable
             Reason: CardView 是一个结构体，如果没有被标记为 mutating，就无法直接修改其实例属性
             */
            //            isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
