//
//  ContentView.swift
//  MathTutor
//
//  Created by Miguel on 6/15/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var firstNumber = Int.random(in: 1...10)
    @State private var secondNumber = Int.random(in: 1...10)
    private var emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    @State private var answer = ""
    @FocusState private var showingKeyboard : Bool
    @State private var audioPlayer : AVAudioPlayer!
    
    var body: some View {
        VStack {
            Group {
                Text(firstNumberEmojis)
                    .font(Font.system(size: 80))
                
                Image(systemName: "plus")
                
                Text(secondNumberEmojis)
                    .font(Font.system(size: 80))
            }
            .font(Font.system(size: 80))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber) =")
                .font(.largeTitle)
            
            TextField(" ", text: $answer)
                .font(.largeTitle)
                .frame(width: 60)
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 2)
                }
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .focused($showingKeyboard)
            
            Button("Guess") {
                guard let answerValue = Int(answer) else {
                    return
                }
                if  firstNumber + secondNumber == answerValue {
                    playSound(soundName: "correct")
                } else {
                    playSound(soundName: "wrong")
                }
                answer = ""
                showingKeyboard = false
                
                firstNumber = Int.random(in: 1...10)
                secondNumber = Int.random(in: 1...10)
                firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
                
                secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
                
            }
            .buttonStyle(.borderedProminent)
            .disabled(answer.isEmpty)
            
            Spacer()
            
            Text("Custom message")
                .font(.largeTitle)
                .fontWeight(.black)
        }
        .padding()
        .onAppear {
            firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
            
            secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
        }
    }
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Error 1")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("Error 2")
        }
    }
}



#Preview {
    ContentView()
}
