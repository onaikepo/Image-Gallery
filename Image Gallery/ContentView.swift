//
//  ContentView.swift
//  Image Gallery
//
//  Created by Onaikepo on 03/05/2021.
//

import SwiftUI

struct ContentView: View {
    private var numberofImages = 7
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    @State private var comment:String = " "
    
    func previous() {
        withAnimation {
        currentIndex = currentIndex > 0 ? currentIndex - 1 : numberofImages - 1
        }
    }
    
    func next() {
        withAnimation{
        currentIndex = currentIndex < numberofImages ? currentIndex + 1 : 0
        }
    }
    
    var controls: some View {
        HStack{
            Button {
                previous()
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer().frame(width:100)
            Button {
               next()
            } label: {
                Image(systemName: "chevron.right")
            }
            .accentColor(.primary)
            
        }
    }
    
    
    var body: some View {
        NavigationView{
        GeometryReader { proxy in
            VStack {
            TabView(selection: $currentIndex) {
            ForEach(1..<numberofImages) {
                num in Image("\(num)")
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.4))
                    .tag(num)
            }
        }.tabViewStyle(PageTabViewStyle())
            .clipShape(RoundedRectangle(cornerRadius: 9))
        .frame(width: proxy.size.width, height: proxy.size.height / 3)
        .onReceive(timer, perform: { _ in
            next()
        })
                controls
                    .padding()
                Text("Product Description").font(.largeTitle).bold()
                ScrollView{
                    Text("""
                    Incredibly light and boasting a speedy performance, get your work done anywhere with the MacBook Air (2020). From video-editing to gaming, the Apple M1 chip lets you take on the biggest tasks without draining your battery.
                    It's 3.5x faster than the previous generation, with eight-cores of power providing an incredible performance. And for whisper-quiet operation, the improved thermal efficiency means it doesn't even need a fan.
                    With the Retina Display screen, everything from blockbuster movies to everyday browsing is a visual joy.
                    True Tone technology automatically adjust the display to your environment - so web pages and emails look as natural as if they were printed.
                    """) .padding() //.frame(width: 300, height: 300, alignment: .topLeading)
                //Comment Text Field will need to go here. So it can be included within the scroll view.
                    
                // Rating Section will need to go her as well. SystemName:Star.circle.fill or unfill.
                    TextField("Enter your comment here", text: $comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("You said: \(comment)")
                }
            }
            }.navigationBarTitle("Image Gallery")
        }
        HStack {
            Link (destination: URL(string: "https://www.apple.com/mac")!, label: {
                      Text("Explore the Mac Range Here")
                      })
        }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

