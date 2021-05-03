//
//  ContentView.swift
//  Image Gallery
//
//  Created by Bowo on 03/05/2021.
//

import SwiftUI

struct ContentView: View {
    private var numberofImages = 7
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
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
                Spacer()
                controls
            }
            }
    
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

