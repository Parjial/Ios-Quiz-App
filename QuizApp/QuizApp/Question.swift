//
//  Question.swift
//  QuizApp
//
//  Created by Parth Karki on 2024-11-15.
//

import Foundation

struct Question: Codable {
    let questionText: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
