//
//  ViewController.swift
//  Homework 3.2
//
//  Created by Виктория Страдзина on 21.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    let characterURL = URL(string: "https://spapi.dev/api/characters/1")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterInfo()
    }
    
    private func characterInfo() {
        let task = URLSession.shared.dataTask(with: characterURL) { [unowned self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let character = try decoder.decode(Character.self, from: data)
                
                DispatchQueue.main.async {
                    self.displayCharacterInfo(character)
                }
                
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    private func displayCharacterInfo(_ character: Character) {
        print("ID: \(character.id)")
        print("Name: \(character.name)")
        print("Sex: \(character.sex)")
        print("Age: \(character.age)")
        print("Hair color: \(character.hairColor)")
        print("Occupation: \(character.occupation)")
        print("Religion: \(character.religion)")
        print("Species: \(character.species)")
        print("Gender: \(character.gender)")
        print("Image: \(character.image.absoluteString)")
    }
}
