//
//  ContentView.swift
//  MathTutor
//
//  Created by Miguel on 6/15/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    @State private var answer = ""
    @State private var audioPlayer : AVAudioPlayer!
    @State private var textFieldIsDisabled = false
    @State private var buttonIsDisabled = false
    @FocusState private var isFocused : Bool
    @State private var message = " "
    
    private var emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    
    
    var body: some View {
        VStack {
            Group {
                Text(firstNumberEmojis)
                Image(systemName: "plus")
                Text(secondNumberEmojis)

            }
            .font(Font.system(size: 80))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .animation(.default, value: message)
            
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber) =")
                .font(.largeTitle)
                .animation(.default, value: message)
            
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
                .focused($isFocused)
                .disabled(textFieldIsDisabled)
            
            Button("Guess") {
                isFocused = false
                guard let answerValue = Int(answer) else {
                    return
                }
                if  firstNumber + secondNumber == answerValue {
                    playSound(soundName: "correct")
                    message = "Correct!"
                } else {
                    playSound(soundName: "wrong")
                    message = ("Sorry, the correct answer is: \(firstNumber + secondNumber)")
                }
                textFieldIsDisabled = true
                buttonIsDisabled = true
//                answer = ""
//                showingKeyboard = false
//                
//                firstNumber = Int.random(in: 1...10)
//                secondNumber = Int.random(in: 1...10)
//                firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
//                
//                secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
                
            }
            .buttonStyle(.borderedProminent)
            .disabled(answer.isEmpty || buttonIsDisabled)
            
            Spacer()
            
            
            Text(message)
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .foregroundStyle(message == "Correct!" ? .green : .red)
                .animation(.default, value: message)
            
            if message != " " {
                Button("Play Again") {
                    message = " "
                    answer = ""
                    textFieldIsDisabled = false
                    buttonIsDisabled = false
                    generateEquation()
                }
            }
        }
        .padding()
        .onAppear {
            generateEquation()
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
    
    func generateEquation() {
        firstNumber = Int.random(in: 1...10)
        secondNumber = Int.random(in: 1...10)
        firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
        
        secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
    }
}



#Preview {
    ContentView()
}
