//
//  ContentView.swift
//  memorize
//
//  Created by tingyu  on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    //var emojis: Array<String> = ["🐶", "🐱", "🐭", "🐹", "🐰", "🐉", "🐮"]
    //var emojis:[String] = ["a", "b", "c", "d"]
    var emojis = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    @State var emojiCount = 6
    
    var body: some View{
        VStack{
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self){emojis in
                    CardView(content: emojis)
                }
            }
            HStack{
                Button(action: {
                    emojiCount -= 1
                }, label: {
                    Text("Remove Card")
                })
                
                Spacer()
                
                Button(action: {
                    emojiCount += 1
                }, label: {
                    Text("Add Card")
                })
            }
        }
        .padding()
        .foregroundStyle(.orange)
    }
}
struct CardView:View {
    @State var isFaceup: Bool=true
    var content: String
    var body: some View{
       ZStack {
           //var shape:RoundedRectangle = RoundedRectangle(cornerRadius: 20)
           let shape = RoundedRectangle(cornerRadius: 20)
           //var shape = Circle();
           if isFaceup{
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
           }
           else {
               shape
           }
        }
       .onTapGesture {
           isFaceup = !isFaceup
       }
        
//     .onTapGesture(perform:{
//         isFaceup = !isFaceup
//       })
    }
}


#Preview {
    ContentView()
}
