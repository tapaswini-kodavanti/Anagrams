import Foundation
import SwiftUI
import UIKit
import PlaygroundSupport

var score = 0
var highScore = 0

var easyWords = [""]
var intermediateWords = [""]
var hardWords = [""]
var lastTenWords = [""]


// ============================== Home View Controller ============================== \\


public class HomeViewController : UIViewController {
    
    public override func loadView() {
        super.viewDidLoad()
        
        loadWords()
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.32, alpha: 1.00)
        view.frame = CGRect(x: 150, y: 200, width: 600, height: 450)

        let label = UILabel()
        label.frame = CGRect(x: 160, y: 150, width: 400, height: 80)
        label.text = "Anagramz"
        label.textColor = .white
        label.font = UIFont(name:"AvenirNext-UltraLight", size: 60.0)

        view.addSubview(label)


        let continueButton = UIButton(frame: CGRect(x: 255, y: 240 , width: 90, height: 35))
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor(red: 1.00, green: 0.53, blue: 0.13, alpha: 1.00)
        continueButton.titleLabel!.font = UIFont(name: "AvenirNext", size: 20)
        continueButton.layer.cornerRadius = 10
        continueButton.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)

        view.addSubview(continueButton)
        
        self.view = view
    }
    
    @objc func continuePressed() {
        let next = InfoViewController()
        nc.pushViewController(next, animated: true)
    }
    
    @ objc func loadWords() {
        // Easy Words
        guard let easyWordsPath = Bundle.main.path(forResource:"Easy Words", ofType: "txt"),
              let _ = FileManager.default.contents(atPath: easyWordsPath) else {
                fatalError("Can not get \"Easy Words\" data")
            }
        
        do {
            let content: String = try String(contentsOfFile: easyWordsPath, encoding: .utf8)
            easyWords = content.components(separatedBy: "\n")
        } catch {
            print("Can not read \"Easy Words\" data")
        }
        
        easyWords = easyWords.filter { $0 != "" }
        
        
        // Intermediate Words
        guard let intermediateWordsPath = Bundle.main.path(forResource:"Intermediate Words", ofType: "txt"),
              let _ = FileManager.default.contents(atPath: intermediateWordsPath) else {
                fatalError("Can not get \"Intermediate Words\" data")
            }
        
        do {
            let content: String = try String(contentsOfFile: intermediateWordsPath, encoding: .utf8)
            intermediateWords = content.components(separatedBy: "\n")
        } catch {
            print("Can not read \"Intermediate Words\" data")
        }
        
        intermediateWords = intermediateWords.filter { $0 != "" }
        
        // Hard Words
        guard let hardWordsPath = Bundle.main.path(forResource:"Hard Words", ofType: "txt"),
              let _ = FileManager.default.contents(atPath: hardWordsPath) else {
                fatalError("Can not get \"Hard Words\" data")
            }
        
        do {
            let content: String = try String(contentsOfFile: hardWordsPath, encoding: .utf8)
            hardWords = content.components(separatedBy: "\n")
        } catch {
            print("Can not read \"Hard Words\" data")
        }
        
        hardWords = hardWords.filter { $0 != "" }
        
    }
}


// ============================== Info View Controller ============================== \\


public class InfoViewController : UIViewController {
    public override func loadView() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.32, alpha: 1.00)
        view.frame = CGRect(x: 150, y: 200, width: 600, height: 450)
        
        let title = UILabel()
        title.frame = CGRect(x: 60, y: 70, width: 400, height: 80)
        title.text = "an·a·gram"
        title.textColor = .white
        title.font = UIFont(name:"AvenirNext-UltraLight", size: 50.0)

        view.addSubview(title)
        
        let pronounce = UILabel()
        pronounce.frame = CGRect(x: 100, y: 110, width: 400, height: 80)
        pronounce.text = "/ˈaneˌgram/"
        pronounce.textColor = .white
        pronounce.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)

        view.addSubview(pronounce)
        
        let wordType = UILabel()
        wordType.frame = CGRect(x: 60, y: 135, width: 400, height: 80)
        wordType.text = "noun"
        wordType.textColor = .white
        wordType.font = UIFont(name:"AvenirNext-UltraLight", size: 15.0)
        wordType.font = UIFont.italicSystemFont(ofSize: 15.0)

        view.addSubview(wordType)
        
        let description = UILabel()
        description.frame = CGRect(x: 100, y: 125, width: 450, height: 200)
        description.text = "a word, phrase, or name formed by rearraging the letter of another, such as \"silent\" formed by \"listen\""
        description.textColor = .white
        description.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)
        description.lineBreakMode = .byWordWrapping
        description.numberOfLines = 0

        view.addSubview(description)
        
        let instruction = UILabel()
        instruction.frame = CGRect(x: 25, y: 265, width: 550, height: 120)
        instruction.text = "Unscramble as many words as possible in two minutes. If the guess is correct, the word will automatically disappear. Difficulty increases as points increase. Click \"New Word\" if you are stuck. "
        instruction.textColor = .white
        instruction.font = UIFont(name:"AvenirNext-UltraLight", size: 16.0)
        instruction.lineBreakMode = .byWordWrapping
        instruction.textAlignment = .center
        instruction.numberOfLines = 0

        view.addSubview(instruction)
        
        let playButton = UIButton(frame: CGRect(x: 255, y: 385 , width: 90, height: 35))
        playButton.setTitle("Play", for: .normal)
        playButton.backgroundColor = UIColor(red: 1.00, green: 0.53, blue: 0.13, alpha: 1.00)
        playButton.titleLabel!.font = UIFont(name: "AvenirNext", size: 20)
        playButton.layer.cornerRadius = 10
        playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)

        view.addSubview(playButton)
        
        self.view = view
    }
    
    @objc func playPressed() {
        let next = GameViewController()
        nc.pushViewController(next, animated: true)
        
    }
    
}


// ============================== Game View Controller ============================== \\


public class GameViewController : UIViewController {
    
    var answer = ""
    var lastUsed = ""
    var secondsLeft = 120
    var timer = Timer()
    var scrambledWord = UILabel()
    var textField = UITextField(frame: CGRect(x: 200, y: 200, width: 200, height: 24))

    let placeholder = UILabel()
    let timerLabel = UILabel()
    let scoreNum = UILabel()
    let highScoreNum = UILabel()
    
    public override func loadView() {
        super.viewDidLoad()
        score = 0
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.32, alpha: 1.00)
        view.frame = CGRect(x: 150, y: 200, width: 600, height: 450)

        
        let scoreLabel = UILabel()
        scoreLabel.frame = CGRect(x: 20, y: 3, width: 100, height: 80)
        scoreLabel.text = "Score: "
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)

        view.addSubview(scoreLabel)


        scoreNum.frame = CGRect(x: 130, y: 3, width: 400, height: 80)
        scoreNum.text = String(score)
        scoreNum.textColor = .white
        scoreNum.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)

        view.addSubview(scoreNum)


        // High Score Label and Value
        let highScoreLabel = UILabel()
        highScoreLabel.frame = CGRect(x: 20, y: 30, width: 130, height: 80)
        highScoreLabel.text = "High Score: "
        highScoreLabel.textColor = .white
        highScoreLabel.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)

        view.addSubview(highScoreLabel)

        highScoreNum.frame = CGRect(x: 130, y: 30, width: 400, height: 80)
        highScoreNum.text = String(highScore)
        highScoreNum.textColor = .white
        highScoreNum.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)

        view.addSubview(highScoreNum)


        // Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)


        timerLabel.frame = CGRect(x: 530, y: 3, width: 400, height: 80)
        timerLabel.text = String(secondsLeft / 60) + ":" + String(format: "%02d", secondsLeft % 60)
        timerLabel.textColor = .white
        timerLabel.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)

        view.addSubview(timerLabel)

        scrambledWord.frame = CGRect(x: 175, y: 120, width: 250, height: 80)
        scrambledWord.text = "TESTWORD"
        scrambledWord.textColor = .white
        scrambledWord.font = UIFont(name:"AvenirNext-UltraLight", size: 30.0)
        scrambledWord.textAlignment = .center

        view.addSubview(scrambledWord)

        // Text Field
        textField.addTarget(self, action: #selector(checkAnswer), for: UIControl.Event.editingChanged)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.32, alpha: 1.00)
        textField.inputView = UIView()
        textField.font = UIFont(name:"AvenirNext-UltraLight", size: 17.0)
        textField.textColor = .white
        textField.textAlignment = .center

        view.addSubview(textField)

        // Placeholder
        placeholder.frame = CGRect(x: 200, y: 200, width: 200, height: 24)
        placeholder.text = "Enter Here"
        placeholder.textColor = .lightGray
        placeholder.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)
        placeholder.textAlignment = .center

        view.addSubview(placeholder)

        // New Word Button
        let newWordButton = UIButton(frame: CGRect(x: 240, y: 260 , width: 120, height: 35))
        newWordButton.setTitle("New Word", for: .normal)
        newWordButton.backgroundColor = UIColor(red: 1.00, green: 0.53, blue: 0.13, alpha: 1.00)
        newWordButton.titleLabel!.font = UIFont(name: "AvenirNext", size: 20)
        newWordButton.layer.cornerRadius = 10
        newWordButton.addTarget(self, action: #selector(presentNewWord), for: .touchUpInside)

        view.addSubview(newWordButton)


        self.view = view

        presentNewWord()
    }

    @objc func updateTimer() {
        secondsLeft -= 1
        if secondsLeft == 0 {
            endGame()
        }
        let minutesString = String(secondsLeft / 60)
        let secondsString = String(format: "%02d", secondsLeft % 60)
        timerLabel.text = minutesString + ":" + secondsString

    }

    @objc func checkAnswer() {
        let userGuess = textField.text?.uppercased()
        if userGuess?.count ?? 0 > 0 {
            placeholder.isHidden = true
        }
        if userGuess == answer {
            score += 1
            scoreNum.text = String(score)
            if score > highScore {
                highScore = score
                highScoreNum.text = String(highScore)
            }

            lastUsed = answer
            presentNewWord()
            placeholder.isHidden = false
            textField.text = ""
        }
    }

    @objc func presentNewWord() {
        var anagram = ""

        checkWordsLength()
        
        repeat {
            if score <= 10 {
                answer = easyWords[Int.random(in: 0..<easyWords.count)]
            } else if score <= 20 {
                answer = intermediateWords[Int.random(in: 0..<intermediateWords.count)]
            } else {
                answer = hardWords[Int.random(in: 0..<hardWords.count)]
            }
            
        } while lastTenWords.contains(answer)
        
        lastTenWords.append(answer)
        

        var characters = Array(answer)

        for index in 0..<characters.count {
            let j = Int.random(in: 0..<characters.count)
            let temp = characters[index]
            characters[index] = characters[j]
            characters[j] = temp
        }
        anagram = String(characters)

        if anagram == answer {
            presentNewWord()
        } else {
            scrambledWord.text = anagram
        }
    }
    
    @objc func checkWordsLength() {
        if lastTenWords.count > 10 {
            lastTenWords.removeFirst()
        }
    }

    @objc func endGame() {
        timer.invalidate()
        let next = EndGameViewController()
        nc.pushViewController(next, animated: true)
        
    }

}


// ============================== End Game View Controller ============================== \\


public class EndGameViewController : UIViewController {
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.32, alpha: 1.00)
        view.frame = CGRect(x: 150, y: 200, width: 600, height: 450)
        
        let title = UILabel()
        title.frame = CGRect(x: 175, y: 120, width: 250, height: 80)
        title.text = "Game Over"
        title.textColor = .white
        title.font = UIFont(name:"AvenirNext-UltraLight", size: 30.0)
        title.textAlignment = .center
        
        view.addSubview(title)
        
        let scoreLabel = UILabel()
        scoreLabel.frame = CGRect(x: 260, y: 150, width: 60, height: 80)
        scoreLabel.text = "Score: "
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)
        scoreLabel.textAlignment = .center

        view.addSubview(scoreLabel)

        let scoreNum = UILabel()
        scoreNum.frame = CGRect(x: 320, y: 150, width: 50, height: 80)
        scoreNum.text = String(score)
        scoreNum.textColor = .white
        scoreNum.font = UIFont(name:"AvenirNext-UltraLight", size: 20.0)
        scoreNum.textAlignment = .center

        view.addSubview(scoreNum)
        
        let newWordButton = UIButton(frame: CGRect(x: 240, y: 260 , width: 120, height: 35))
        newWordButton.setTitle("Play Again", for: .normal)
        newWordButton.backgroundColor = UIColor(red: 1.00, green: 0.53, blue: 0.13, alpha: 1.00)
        newWordButton.titleLabel!.font = UIFont(name: "AvenirNext", size: 20)
        newWordButton.layer.cornerRadius = 10
        newWordButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)

        view.addSubview(newWordButton)
        
        
        self.view = view
    }
    
    @objc func playPressed() {
        let next = GameViewController()
        nc.pushViewController(next, animated: true)
    }
}


let viewScreen = CGRect(x: 0, y: 0, width: 600, height: 450)
let vc = HomeViewController()
let nc = UINavigationController(rootViewController: vc)
nc.navigationBar.isHidden = true
nc.view.frame = viewScreen
PlaygroundPage.current.liveView = nc.view
