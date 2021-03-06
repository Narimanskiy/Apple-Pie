//
//  ViewController.swift
//  Apple Pie
//
//  Created by Нариман on 02.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords = [
        "Ауди",
        "БМВ",
        "Бриллианс",
        "Кадилак",
        "Чанган",
        "Чери",
        "Чери Эксид",
        "Шевроле",
        "Крайслер",
        "Ситроэн",
        "Датсун",
        "Дунфэн",
        "ФАВ",
        "Генезис",
        "Хавейл",
        "Хонда",
        "Хёндэ",
        "Инфинити",
        "Ягуар",
        "Джип",
        "Киа",
        "Лада",
        "Лэнд Ровер",
        "Лексус",
        "Лифан",
        "Мазда",
        "Мерседес-Бенц",
        "Мини",
        "Мицубиси",
        "Ниссан",
        "Опель",
        "Пежо",
        "Порше",
        "Рено",
        "Шкода",
        "Субару",
        "Сузуки",
        "Тойота",
        "Фольксваген",
        "Вольво",
        "Зоти",
        "УАЗ",
        "Акура",
        "Альфа Ромео",
        "БИД",
        "Додж",
        "Грейт-Уолл",
        "Хайма",
        "Хавтай",
        "Джак",
        "Равон",
        "Сеат",
        "Смарт",
        "СанЙонг",
        "Вортекс",
        "ЗАЗ",
        "Богдан",
        "ТагАЗ",
    ].shuffled()
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    //MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemainig: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemainig < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
        updateUI()
        }
    }
    
    func updateUI() {
        let movesRemainig = currentGame.incorrectMovesRemainig
        let imageNumber = (movesRemainig + 64) % 8
        let image = "Tree\(imageNumber)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    //MARK: IB Actions
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    


}

