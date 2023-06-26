//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Кирилл on 24.06.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet var resultPictureLabel: UILabel!
    @IBOutlet var resultTextLabel: UILabel!
    
    var variantAnimals: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        findAnimal()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
}

//MARK: - Private Methods

private extension ResultViewController {

    /// Метод поиска наиболее часто встречающегося типа животного
    func findAnimal() {
        
        var dog = [1]
        var cat = [1]
        var rabbit = [1]
        var turtle = [1]
        
        for variant in variantAnimals {
            if variant.animal == .dog {
                dog.append(1)
            } else if variant.animal == .cat {
                cat.append(1)
            } else if variant.animal == .rabbit {
                rabbit.append(1)
            } else {
                turtle.append(1)
            }
        }
        
        var animals = [dog.count, cat.count, rabbit.count, turtle.count]
        
        animals.sort()
        
        if animals.last == dog.count {
            resultPictureLabel.text = "Вы \(String(Animal.dog.rawValue))"
            resultTextLabel.text = Animal.dog.definition
        } else if animals.last == cat.count {
            resultPictureLabel.text = "Вы \(String(Animal.cat.rawValue))"
            resultTextLabel.text = Animal.cat.definition
        } else if animals.last == rabbit.count {
            resultPictureLabel.text = "Вы \(String(Animal.rabbit.rawValue))"
            resultTextLabel.text = Animal.rabbit.definition
        } else {
            resultPictureLabel.text = "Вы \(String(Animal.turtle.rawValue))"
            resultTextLabel.text = Animal.turtle.definition
        }
    }
}

