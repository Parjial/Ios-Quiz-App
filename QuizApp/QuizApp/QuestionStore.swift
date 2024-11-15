//
//  QuestionStore.swift
//  QuizApp
//
//  Created by Parth Karki on 2024-11-15.
//

import Foundation

class QuestionStore {
    static let shared = QuestionStore()
    
    var questions: [Question] {
        get {
            // Load saved questions from UserDefaults or return an empty array if none found
            if let data = UserDefaults.standard.data(forKey: "questions"),
               let savedQuestions = try? JSONDecoder().decode([Question].self, from: data) {
                return savedQuestions
            }
            return [] // Return an empty array if no questions are found
        }
        set {
            // Save the new array of questions to UserDefaults
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "questions")
            }
        }
    }
    
    private init() {} // Private init to ensure this is a singleton
}
