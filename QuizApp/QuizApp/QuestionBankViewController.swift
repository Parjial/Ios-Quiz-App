//
//  QuestionBankViewController.swift
//  QuizApp
//
//  Created by Parth Karki on 2024-11-15.
//

import UIKit

class QuestionBankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuestionBuilderDelegate {

    // Access the singleton to get questions
    var questions: [Question] {
        return QuestionStore.shared.questions
    }

    // Outlet for the table view
    @IBOutlet weak var tableView: UITableView!

    // Outlet for the clear all button
    @IBOutlet weak var clearAllButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load questions from the singleton (automatically done)
        tableView.reloadData()
    }

    // UITableViewDataSource: Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    // UITableViewDataSource: Configure each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row].questionText
        return cell
    }

    // Delegate method to receive a new question and add it to the array
    func didAddQuestion(_ question: Question) {
        // Add the question to the singleton's question array
        var updatedQuestions = questions
        updatedQuestions.append(question)
        QuestionStore.shared.questions = updatedQuestions // Persist the updated list
        
        tableView.reloadData() // Reload the table view to display the new question
    }

    // Action to clear all questions
    @IBAction func clearAllQuestions(_ sender: UIButton) {
        // Clear the questions from the singleton
        QuestionStore.shared.questions = []
        
        // Reload the table view to reflect the changes
        tableView.reloadData()
        
        // Optionally, show an alert confirming the action
        let alert = UIAlertController(title: "All Questions Cleared", message: "All questions have been removed from the question bank.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // Prepare for segue to pass the delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestionBuilder" {
            if let destinationVC = segue.destination as? QuestionBuilderViewController {
                destinationVC.delegate = self // Set the delegate to this view controller
            }
        }
    }
}
