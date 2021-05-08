import SwiftUI

struct ContentView: View {
    private var numberofImages = 7
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    @State private var comment:String = ""
    @State private var userComment:String = ""
    @State private var showComment:Bool = false
    @State var rating: Int = 0
    
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
    
    func actionSheet() {
           guard let urlShare = URL(string: "https://www.apple.com/mac") else { return }
           let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
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
    
        
        /*HStack{
            Button {
                rating1()
            } label: {
                Image(systemName: "star.fill")
            }
            Button {
                rating2()
            } label: {
                Image(systemName: "star.fill")
            }
            Button {
                rating3()
            } label: {
                Image(systemName: "star.fill")
            }
            Button {
                rating4()
            } label: {
                Image(systemName: "star.fill")
            }
            Button {
                rating5()
            } label: {
                Image(systemName: "star.fill")
            }
            
        }*/
    
    struct ratings: View {
        
        @Binding var rating: Int
        
        var label: String = ""
        
        var maximumRating = 5
        
        var offImage :Image?
        var onImage = Image(systemName: "star.fill")
        
        var offColor = Color.gray
        var onColor = Color.yellow
        
        func image(for number: Int) -> Image {
            if number > rating {
                return offImage ?? onImage
            } else {
                return onImage
            }
            
        }
        
        var body: some View {
            HStack {
                if label.isEmpty == false {
                    Text(label)
                }

                ForEach(1..<maximumRating + 1) { number in
                    self.image(for: number)
                        .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                        .onTapGesture {
                            self.rating = number
                        }
                }
            }

        }
    }
    
    var body: some View {
        NavigationView{
        GeometryReader { proxy in
            VStack {
                ScrollView{
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
                
                    Text("""
                    Incredibly light and boasting a speedy performance, get your work done anywhere with the MacBook Air (2020). From video-editing to gaming, the Apple M1 chip lets you take on the biggest tasks without draining your battery.
                    It's 3.5x faster than the previous generation, with eight-cores of power providing an incredible performance. And for whisper-quiet operation, the improved thermal efficiency means it doesn't even need a fan.
                    With the Retina Display screen, everything from blockbuster movies to everyday browsing is a visual joy.
                    True Tone technology automatically adjust the display to your environment - so web pages and emails look as natural as if they were printed.
                    """) .padding() //.frame(width: 300, height: 300, alignment: .topLeading)
                //Comment Text Field will need to go here. So it can be included within the scroll view.
                    TextField("", text: $comment, onEditingChanged: {_ in
                        self.showComment = true
                    }, onCommit: {
                        if self.showComment {
                            self.userComment = self.comment
                        }
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                  
                    Text("Your Comment is: \(self.userComment)")
                        Spacer()
                    Text("Your Rating is:")
                    
                    Spacer()
                    ratings(rating: $rating)
                    
                    //RatingView(rating: .constant(3))
                    //RatingView(rating: .constant(3))
                   //starRating
                    // Rating Section will need to go her as well. SystemName:Star.circle.fill or unfill.
                }
                    Button(action: actionSheet) {
                                   Image(systemName: "square.and.arrow.up")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 36, height: 36)
                               
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

}
