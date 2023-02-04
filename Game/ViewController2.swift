//
//  ViewController2.swift
//  Game
//
//  Created by R&W on 03/02/23.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            setup()
    }
    
    func setup(){
        easyButton.layer.cornerRadius = 10
        mediumButton.layer.cornerRadius = 10
        hardButton.layer.cornerRadius = 10
    }

    @IBAction func easyButtonAction(_ sender: UIButton) {
        neviget()
    }
    
    @IBAction func mediumButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func hardButtonAction(_ sender: UIButton) {
    }
    
    func neviget(){
        let abc = storyboard?.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        navigationController?.pushViewController(abc, animated: true)
    }
}
