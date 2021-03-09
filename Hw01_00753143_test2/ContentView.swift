//
//  ContentView.swift
//  Hw01_00753143_test2
//
//  Created by CK on 2021/3/7.
//
import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var AnswearShow = false
    @State private var number = 0
    @State private var showingAlert = false
    var body: some View {
        
        ZStack{
            Image("猜燈謎背景3")
                .resizable()
                .opacity(0.6)
            VStack(alignment: .leading,spacing :70){
                
                HStack{
                    Text("第" + String(number+1) + "題")
                        .font(.title).foregroundColor(.white).multilineTextAlignment(.center).padding(16)
                        Spacer()
                }.background(Color.yellow)
                
                Text(Question[Sequence[number]]).font(.title).fontWeight(.bold).padding()
                Button(action:{
                    let questionUtterance = AVSpeechUtterance(string:Question[Sequence[number]])
                    questionUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                    let questionSynthesizer = AVSpeechSynthesizer()
                    questionSynthesizer.speak(questionUtterance)
                    
                },label:{
                    Text("幫我念題目")
                })
                

                HStack{
                    
                    
                    if AnswearShow == true {
                        Text(Answer[Sequence[number]])
                            .font(.largeTitle)
                            .multilineTextAlignment(.trailing)
                            .padding()
                        Button(action:{
                            let answerUtterance = AVSpeechUtterance(string:Answer[Sequence[number]])
                            answerUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                            let answerSynthesizer = AVSpeechSynthesizer()
                            answerSynthesizer.speak(answerUtterance)
                            
                        },label:{
                            Text("想聽答案")
                        })
                           
                    }else{
                        Text("答案是...?")
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .padding()
                            
                    }
                    
                }
                
                Image("熊玩手機")
                .resizable()
                .scaledToFit()
              
                HStack{
                    
                    Button(action: {
                        AnswearShow = true
                    },label: {
                        Text("看答案")
                            .font(.title)
                            .foregroundColor(.white)
                            .background(Color.pink)
                            .cornerRadius(20.0)
                    
                    }).padding(20)
                    
                    Button(action: {
                      
                        if(number > 8){
                            showingAlert = true
                            Sequence.shuffle()
                            number = 0
                        }else{
                            number = number + 1
                            AnswearShow = false
                        }
                      
                    },label: {
                        
                        
                        Text("下一題")
                            .font(.title)
                            .foregroundColor(.white)
                            .background(Color.yellow)
                            .cornerRadius(20.0)
                            
                    }).padding(1.0)
                    
                    Button(action: {
                        Sequence.shuffle()
                        number = 0
                        AnswearShow = false
                    },label: {
                        Text("重選10題")
                            .font(.title)
                            .foregroundColor(.white)
                            .background(Color.yellow)
                            .cornerRadius(10.0)
                    }).alert(isPresented: $showingAlert) { () -> Alert in
                        let answer = "已經玩超過10題了 重新玩10題吧～"
                        return Alert(title: Text(answer))
                    }.padding(30)
                }
                
            }.onAppear(perform: {
                Sequence.shuffle()
            })
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
