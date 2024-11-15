//
//  ViewController.swift
//  QuizApp
//
//  Created by Parth Karki on 2024-11-15.
//

import UIKit

class ViewController: UIViewController, QuestionBuilderDelegate {

    var questions: [Question] = [] // Array to store added questions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Delegate method to handle the addition of a question
    func didAddQuestion(_ question: Question) {
        questions.append(question) // Add the new question to the questions array
        print("Question Added: \(question.questionText)") // For debugging
    }
    
    // Method to present QuestionBuilderViewController
    @IBAction func addQuestionTapped(_ sender: UIButton) {
        let questionBuilderVC = storyboard?.instantiateViewController(withIdentifier: "QuestionBuilderViewController") as! QuestionBuilderViewController
        questionBuilderVC.delegate = self // Set ViewController as the delegate
        navigationController?.pushViewController(questionBuilderVC, animated: true)
    }
}
