//
//  ViewController.swift
//  LoremPicsumAPI
//
//  Created by Field Employee on 12/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loremPicsumTableView: UITableView!

    var pokemonArray: [LoremPicsum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getSingularPokemon()
        self.getTenPictures()
    }
    
    private func getTenPictures() {
        self.loremPicsumTableView.register(UINib(nibName:
            "LoremPicsumTableViewCell", bundle: nil),
            forCellReuseIdentifier:
            "LoremPicsumTableViewCell")
        self.loremPicsumTableView.dataSource = self
        
        let group = DispatchGroup()
        for _ in 1...10 {
        group.enter()
        NetworkingManager.shared
        .getDecodedObject(from:
        self.createRandomPokemonURL()) { (loremPicsum:
        LoremPicsum?, error) in
        guard let loremPicsum = loremPicsum else { return }
        self.pokemonArray.append(loremPicsum)
            group.leave()
        }
       }
        group.notify(queue: .main) {
            self.loremPicsumTableView.reloadData()
        }
    }
    
//    private func getSingularPokemon() {
//        NetworkingManager.shared
//            .getDecodedObject(from:
//            self.createRandomPokemonURL()) {
//                (loremPicsum:LoremPicsum?, error) in
//            guard let loremPicsum = loremPicsum else {
//                if let error = error {
//                   let alert = self.generateAlert(from:
//                    error)
//                    DispatchQueue.main.async {
//                        self.present(alert, animated: true,
//                                     completion: nil)
//                    }
//                }
//                return
//            }
//                DispatchQueue.main.async {
//                    self.pokemonNameLabel?.text = loremPicsum.id
//                }
//                NetworkingManager.shared.getImageData(from:
//                    loremPicsum.download_url) { data, error in
//                    guard let data = data else { return }
//                    DispatchQueue.main.async {
//                     self.pokemonImageView?.image =
//                        UIImage(data: data)
//                    }
//                }
//            }
//
//
//    }
    private func createRandomPokemonURL() -> String
    {
        let randomNumber = Int.random(in:1...151)
//         return "https://pokeapi.co/api/v2/pokemon/\(randomNumber)"
       return "https://picsum.photos/id/\(randomNumber)/info"
    }
    
    
    private func generateAlert(from error: Error)
    -> UIAlertController {
        let alert = UIAlertController(title: "Error",
        message: "We ran into an error! Error Description:\(error.localizedDescription)",
        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell =
            tableView
            .dequeueReusableCell(withIdentifier:
            "LoremPicsumTableViewCell", for: indexPath) as!
        LoremPicsumTableViewCell
        cell.configure(with:
        self.pokemonArray[indexPath.row])
        return cell
    }

}

