//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Parth Karki on 2024-11-15.
//

import UIKit

class QuizViewController: UIViewController {
    // Outlets for the UI elements
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var progressBar: UIProgressView!

    // Array to store the questions and other relevant data
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load questions from QuestionStore
        loadQuestions()
        
        // Display the first question
        loadQuestion()
    }

    // Load the questions from the shared QuestionStore
    func loadQuestions() {
        // Get the stored questions from QuestionStore
        questions = QuestionStore.shared.questions
    }

    // Display the current question and answers
    func loadQuestion() {
        // If we've exhausted all the questions, show the result
        guard currentQuestionIndex < questions.count else {
            showResult()
            return
        }

        // Get the current question
        let currentQuestion = questions[currentQuestionIndex]

        // Set the question text
        questionLabel.text = currentQuestion.questionText

        // Combine the correct answer with incorrect answers and shuffle them
        var answers = currentQuestion.incorrectAnswers
        answers.append(currentQuestion.correctAnswer)
        answers.shuffle()

        // Set the answer buttons' titles
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(answers[index], for: .normal)
        }

        // Update the progress bar based on the current question index
        progressBar.progress = Float(currentQuestionIndex + 1) / Float(questions.count)
    }

    // Handle answer selection
    @IBAction func answerSelected(_ sender: UIButton) {
        // Get the selected answer and compare it with the correct answer
        let selectedAnswer = sender.titleLabel?.text
        let correctAnswer = questions[currentQuestionIndex].correctAnswer

        // If the selected answer is correct, increment the score
        if selectedAnswer == correctAnswer {
            score += 1
        }

        // Move to the next question
        currentQuestionIndex += 1
        loadQuestion()
    }

    // Show the final score when the quiz is finished
    func showResult() {
        // Show an alert with the score
        let alert = UIAlertController(title: "Quiz Finished", message: "Your score is \(score)/\(questions.count)", preferredStyle: .alert)
        
        // Add an action to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Navigate back to the root view controller (main page or starting page)
            if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)  // Pops to the root of the navigation stack
            } else {
                // If no navigation controller is used, dismiss the quiz view
                self.dismiss(animated: true, completion: nil)
            }
        })
        
        // Present the alert
        present(alert, animated: true)
    }
}
