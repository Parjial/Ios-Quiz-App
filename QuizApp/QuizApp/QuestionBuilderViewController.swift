//
//  QuestionBuilderViewController.swift
//  QuizApp
//
//  Created by Parth Karki on 2024-11-15.
//


import UIKit

protocol QuestionBuilderDelegate: AnyObject {
    func didAddQuestion(_ question: Question)
}

class QuestionBuilderViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerField: UITextField!
    @IBOutlet weak var incorrectAnswer1Field: UITextField!
    @IBOutlet weak var incorrectAnswer2Field: UITextField!
    @IBOutlet weak var incorrectAnswer3Field: UITextField!

    weak var delegate: QuestionBuilderDelegate?

    @IBAction func saveQuestion(_ sender: UIButton) {
        guard let questionText = questionTextField.text,
              let correctAnswer = correctAnswerField.text,
              let incorrect1 = incorrectAnswer1Field.text,
              let incorrect2 = incorrectAnswer2Field.text,
              let incorrect3 = incorrectAnswer3Field.text else { return }

        let question = Question(
            questionText: questionText,
            correctAnswer: correctAnswer,
            incorrectAnswers: [incorrect1, incorrect2, incorrect3]
        )
        
        // Pass the new question to the delegate to add it to the list
        delegate?.didAddQuestion(question)

        // Pop back to the previous screen
        navigationController?.popViewController(animated: true)
    }

    @IBAction func cancel(_ sender: UIButton) {
        navigationController?.popViewController(animated: true) // Go back without saving
    }
}
