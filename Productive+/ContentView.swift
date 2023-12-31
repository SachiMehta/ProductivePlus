import AVKit
import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var subtext = "welcome to productive+"
    @State private var navImg = "nav"
    @State private var lampOn = false
    // for music
    @State var audioPlayer: AVAudioPlayer!
    @State var playingMusic: Bool = false
    
    var body: some View {
        NavigationStack (path: $path){
            ZStack {
                Color(red: 0.959, green: 0.924, blue: 0.925)
                    .ignoresSafeArea()
                
                VStack {
                    Button(action: {
                        if !playingMusic {
                            self.audioPlayer.play()
                            playingMusic = true
                        } else {
                            self.audioPlayer.pause()
                            playingMusic = false
                        }
                        
                    }, label: {
                        if !playingMusic {
                            Image("musicOff")
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70.0)
                                .zIndex(2)
                                .position(x: 350)
                        } else {
                            Image("musicOn")
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70.0)
                                .zIndex(2)
                                .position(x: 350)
                        }
                    })
                }.onAppear {
                    let sound = Bundle.main.path(forResource: "Tokyo", ofType: "mp3")
                    self.audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                    // music will infinitely loop
                    audioPlayer.numberOfLoops = -1
                }

                Text("\(subtext)")
                    .zIndex(2)
                    .position(x: 200, y: 200)
                    .fontWeight (.heavy)
                    .foregroundColor(Color(red: 0.643, green: 0.55, blue: 0.495))
                Image("\(navImg)")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture { location in
                        if Rect(x1: 158, y1: 414, x2: 235, y2: 480, location: location)
                        {
                            
                            path.append("playlist")
                            print("comp clicked")
                            subtext = "study time!"
                            navImg = "nav"
                        }
                        
                        else if Elipse(x: 312, y:308, radius: 30, location: location)
                        {
                            path.append("timer")
                            print("in the clock")
                            subtext = "study time!"
                            navImg = "nav"
                        }
                                                
                        else if Rect(x1: 285, y1: 440, x2: 346, y2: 473, location: location)
                        {
                            path.append("journal")
                            print("in the journal")
                            subtext = "study time!"
                            navImg = "nav"
                        }
                        
                        else if Rect(x1: 41, y1: 305, x2: 161, y2: 385, location: location)
                        {
                            path.append("todo")
                            print("in the todo list")
                            subtext = "study time!"
                            navImg = "nav"
                        }
                        //plant
                        else if Rect(x1: 268, y1: 340, x2: 354, y2: 397, location: location)
                        {
                            subtext = "water your plants :)"
                            navImg = "plant"
                            print("in the plant")
                        }
                        //lamp
                        else if Rect(x1: 30, y1: 390, x2: 84, y2: 458, location: location)
                        {
                            subtext = "conserve some energy"
                            if !lampOn {
                                navImg = "lamp"
                                lampOn = true
                            } else {
                                lampOn = false
                                navImg = "nav"
                                subtext = "study time!"
                            }
                            print("in the lamp")
                        }
                        //post-it
                        else if Rect(x1: 172, y1: 305, x2: 248, y2: 380, location: location)
                        {
                            subtext = "you're doing great! keep going!"
                            navImg = "postit"
                            print("in the postit")
                        }
                        //water
                        else if Rect(x1: 245, y1: 429, x2: 280, y2: 465, location: location)
                        {
                            subtext = "drink some water!"
                            navImg = "water"
                            print("in the water")
                        }
                        else
                        {
                            subtext = "study time!"
                            navImg = "nav"
                            print("Empty tap")

                        }
                        
                        print("Tapped at \(location)")
                    }
            }
            .navigationDestination(for: String.self){ view in
                if view == "playlist"
                {
                    let _ = print("playlist is being requested")
                    //change page name here
                    Breathing()
                }
                
                else if view == "timer"
                {
                    let _ = print("timer is being requested")
                    StudyTimer()
                }
                
                else if view == "journal"
                {
                    let _ = print("journal is being requested")
                    Journal()
                }
                
                else if view == "todo"
                {
                    let _ = print("todo is being requested")
                    ToDoView(title: "")
                }
            }
            
        }
        
        
    }
}
func Rect (x1: Int, y1: Int, x2: Int , y2: Int, location: CGPoint) -> Bool
{
    if Int(location.x) > x1 && Int(location.x) < x2
        && Int(location.y) > y1 && Int(location.y) < y2
    {
        return true
    }
    return false
}
func Elipse (x: Int, y: Int, radius: Double, location: CGPoint) -> Bool
{
    let xd = Int(abs(Double(x) - (location.x)))
    let yd = Int(abs(Double(y) - (location.y)))
    let xys = (pow(Double(xd),2) + pow(Double(yd),2))
    let distance = sqrt(Double(xys))
    if Double(distance) <= Double(radius)
    {
        
        return true
    }
    return false
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
