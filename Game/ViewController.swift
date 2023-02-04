//
//  ViewController.swift
//  Game
//
//  Created by R&W on 03/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLine: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        timeLine.progress = 0.0
        timeLine.isHidden = true

    }

    @IBAction func playButtonAction(_ sender: UIButton) {
        timeLine.isHidden = false
       progress()
    }
    
    var time = Timer()
    
    func progress(){
        var a : Float = 0.0
        self.timeLine.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            a += 0.05
            print(a)
            self.timeLine.progress = a
            if self.timeLine.progress == 1.0{
                
                self.neviget()
                self.timeLine.progress = 0.0
                self.timeLine.isHidden = true
                self.time.invalidate()
            }
        })
    }
    
    
    func neviget(){
        let abc = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigationController?.pushViewController(abc, animated: true)
    }

    
    func setup(){
        playButton.layer.backgroundColor = UIColor.white.cgColor
        playButton.layer.cornerRadius = 10
        //playButton.layer.masksToBounds = true
    }
    
}

