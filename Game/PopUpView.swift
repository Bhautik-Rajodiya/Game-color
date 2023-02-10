//
//  PopUpView.swift
//  Game
//
//  Created by Bhautik Rajodiya on 07/02/23.
//

import UIKit

class PopUpView: UIViewController {
    
    
    @IBOutlet weak var pop: UIView!
    @IBOutlet weak var scroeLableInPopup: UILabel!
    @IBOutlet weak var hightestScroe: UILabel!
    @IBOutlet weak var rePlayButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    var scoreTranfar = 0
    var reload : (()->())?
    var myNav : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popSetUp()
        buttunSetUp()
        view.alpha = 0
        scroeLableInPopup.text = "Score : \(scoreTranfar)"
        abc()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.view.alpha = 1
        }
    }
    
    func abc() {
        let oldValue = UserDefaults.standard.integer(forKey: "score")
        print(oldValue)
        if oldValue <= scoreTranfar {
            UserDefaults.standard.set(scoreTranfar, forKey: "score")
            hightestScroe.text = "Highest Score : \(scoreTranfar)"
        }
        else {
            hightestScroe.text = "Highest Score : \(oldValue)"
        }
    }

    @IBAction func rePlayButtonAction(_ sender: UIButton) {
        view.layer.backgroundColor = UIColor.white.cgColor
        reload?()
        self.dismiss(animated: false)
    }
    
    @IBAction func homeButtonAction(_ sender: UIButton) {
        myNav?.popViewController(animated: true)
        self.dismiss(animated: false)
    }
    
    func popSetUp(){
        pop.layer.cornerRadius = 10
        pop.layer.shadowRadius = 5
        pop.layer.shadowColor = UIColor.gray.cgColor
        pop.layer.shadowOpacity = 1.0
        pop.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    func buttunSetUp(){
        rePlayButton.layer.cornerRadius = 10
        rePlayButton.layer.shadowRadius = 4
        rePlayButton.layer.shadowColor = UIColor.gray.cgColor
        rePlayButton.layer.shadowOpacity = 0.3
        rePlayButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        homeButton.layer.cornerRadius = 10
        homeButton.layer.shadowRadius = 4
        homeButton.layer.shadowColor = UIColor.gray.cgColor
        homeButton.layer.shadowOpacity = 0.3
        homeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    
    
}
