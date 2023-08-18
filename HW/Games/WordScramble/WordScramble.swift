//
//  WordScramble.swift
//  WeSplit
//
//  Created by Artem Vekshin on 24.07.2023.
//

import SwiftUI

struct WordScramble: View {
    @State private var ArrayOfWord = [String]()
    @State private var roootWord = ""
    @State private var currentWord = ""
    @State private var Score = 0
    
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
       
        NavigationView {
            List{
                Section{
                    Text("Score: \(Score)")
                    TextField("Enter the word", text: $currentWord).textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(ArrayOfWord, id: \.self){ word in
                        HStack{ Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
        }.navigationTitle(roootWord)
        
            .onSubmit {
                addWord()
            }
            .onAppear(perform: randdomWordFromFile)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Restart", action: startGame)
            }
        
    }
        
    func startGame(){
        randdomWordFromFile()
        currentWord = ""
        Score = 0
        ArrayOfWord.removeAll()
    }
        
    func addWord(){
        let  answer = currentWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else{return}
        
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossibleForU(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(roootWord)'!")
            return
        }

        guard isRealBro(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation{
            ArrayOfWord.insert(answer, at: 0)
        }
        currentWord = ""
        Score += 1
    }
    func randdomWordFromFile(){
        if let startWOrdURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWOrdURL){
                let allWords = startWords.components(separatedBy: "\n")
                roootWord = allWords.randomElement() ?? "Artem Veskshin is God"
                return
            }
        }
    fatalError("Sorry I can't load files from file(")
    }
    func isOriginal(word: String) -> Bool {
        !ArrayOfWord.contains(word)
    }
    //если мы создадим переменную копию корневого слова, мы можем затем перебрать каждую букву введенного пользователем слова, чтобы увидеть, существует ли эта буква в нашей копии. Если это так, мы удаляем его из копии (чтобы его нельзя было использовать дважды), затем продолжаем. Если мы успешно доходим до конца пользовательского слова, то слово хорошее, в противном случае возникает ошибка, и мы возвращаем false.
    func isPossibleForU(word: String) -> Bool{
        var tempWord = roootWord
        for i in word{
            if let pos = tempWord.firstIndex(of: i){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    func isRealBro(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpelledange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missSpelledange.location == NSNotFound
        
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct WordScramble_Previews: PreviewProvider {
    static var previews: some View {
        WordScramble()
    }
}
