//
//  PopUpView.swift
//  Game
//
//  Created by Bhautik Rajodiya on 07/02/23.
//

import UIKit

class PopUpView: UIViewController {
    @IBOutlet weak var scroeLableInPopup: UILabel!
    @IBOutlet weak var hightestScroe: UILabel!
    @IBOutlet weak var rePlayButton: UIButton!
    
    var reload : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            
            self.view.alpha = 1
        }

    }

    @IBAction func rePlayButtonAction(_ sender: UIButton) {
        view.layer.backgroundColor = UIColor.white.cgColor
        reload?()
        self.dismiss(animated: false)
    }

}
