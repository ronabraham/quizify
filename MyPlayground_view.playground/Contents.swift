//: A UIKit based Playground for presenting user interface
  
import UIKit
import CoreData
import PlaygroundSupport

class Questionnaire {

    var name : String
    var listOfQuestions : [Question]
    init(listOfQuestions : [Question] , name : String) {
        self.listOfQuestions = listOfQuestions
        self.name = name
    }
}

struct Question {
    var number : Int
    var text: String
    var options : [String]
    var answer : String
    
}

class MyViewController : UIViewController {
    var testString : String?
    var questionnaire : Questionnaire?

    func MyViewController(_ testString : String){
        print("test log in MyViewController")
        self.testString = "Geography Quiz"
    }
    
    override func loadView() {
        let view = UIView()
        var listOfQuestions : [Question]?
        view.backgroundColor = .white
        self.questionnaire = loadQuestionnaire()
        listOfQuestions = questionnaire!.listOfQuestions
        let q : Question = listOfQuestions![0]
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 200, width: 300, height: 20)
        label.text = q.text
        label.textColor = .black
        print("test log in loadView()")
        view.addSubview(label)
        self.view = view
    }
    
    func loadQuestionnaire()->Questionnaire{
        let question2 : Question = Question(number: 1, text: "What is the capital of India ?",
                                           options: ["New Delhi","Chandigarh","Chennai","Mumbai"],
                                           answer: "New Delhi")
        return Questionnaire(listOfQuestions: [question2], name: "Test Quiz")
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
