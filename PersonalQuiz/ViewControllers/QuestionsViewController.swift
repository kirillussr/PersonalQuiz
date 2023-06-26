//
//  QuestionsViewController.swift
//  PersonalQuiz
//
//  Created by Кирилл on 17.06.2023.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitchs: [UISwitch]!
    
    @IBOutlet var rangeStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangeSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangeSlider.maximumValue = answerCount
            rangeSlider.value = answerCount / 2
        }
    }
    
    private let questions = Question.getQestion()
    
    private var answerChosen: [Answer] = []
    private var questionIndex = 0
    private var currentAnswers: [Answer] { questions[questionIndex].answers }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let myChosen = segue.destination as? ResultViewController else { return }
        myChosen.variantAnimals = answerChosen
    }
    
    //MARK: - IBActions
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answerChosen.append(currentAnswer)
        
        nextQestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitchs, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        nextQestion()
    }
    
    @IBAction func rangedAnswreButtonPressed() {
        let index = lrintf(rangeSlider.value)
        answerChosen.append(currentAnswers[index])
        nextQestion()
    }
}

//MARK: - Private Methods

private extension QuestionsViewController {
    func updateUI() {
    
        for stackView in [singleStackView, multipleStackView, rangeStackView] {
            stackView?.isHidden = true
        }
        
        let currentQestion = questions[questionIndex]
        questionLabel.text = currentQestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        showCurrentAnswers(for: currentQestion.responseType)
    }
    
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(wint: currentAnswers)
        case .range: showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answer: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answer) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(wint answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangeStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
