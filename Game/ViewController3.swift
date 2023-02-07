//
//  ViewController3.swift
//  Game
//
//  Created by R&W on 04/02/23.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var timeLine: UIProgressView!
    @IBOutlet weak var colorBox: UICollectionView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var scroeLabel: UILabel!
    @IBOutlet weak var scroeLableInPopup: UILabel!
    @IBOutlet weak var hightestScroe: UILabel!
    @IBOutlet weak var rePlayButton: UIButton!
    
    var fgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","Cyan"]
    var bgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","Cyan"]
    var time = Timer()
    
    let colorHelper :[String : UIColor] = [
        "Red" : UIColor.red,"Black" : UIColor.black,"Blue" : UIColor.blue,
        "Orenge" : UIColor.orange,"Green" : UIColor.green,"Purple" : UIColor.purple,
        "Yellow" : UIColor.yellow,"Brown" : UIColor.brown,"Cyan" : UIColor.cyan
    ]
    var scroe = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logic()
        timeLine.progress = 1.0
        progress()
        colorBox.layer.cornerRadius = 30
        scroeLableSetUp()
       
    }
    @IBAction func rePlayButtonAction(_ sender: UIButton) {
        view.layer.backgroundColor = UIColor.white.cgColor
        popupView.isHidden = true
        progress()
        logic()
        //scroeLableInPopup.text = "Score : \(Int(scroeLabel.text!))"

    }
}


extension ViewController3 : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fgColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorBox.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.lb.text = fgColor[indexPath.row]
        cell.layer.backgroundColor = colorHelper[bgColor[indexPath.row]]?.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width-14.1-40)/3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCellLable = fgColor[indexPath.item]
        let selectedCellBgColor = bgColor[indexPath.item]
        
        if selectedCellLable == selectedCellBgColor {
            time.invalidate()
            progress()
            scroe += 1
            scroeLabel.text = "\(Int(scroe))"
        }
        else {
            time.invalidate()
            animationIn(desiredView: popupView)
            scroeLableInPopup.text = "Score : \(Int(scroeLabel.text!))"
        }
        logic()
    }
}
 

extension ViewController3 {
    
    func logic(){
        bgColor.shuffle()
        
        
        fgColor.shuffle()
        var a : Bool = false
        repeat {
            a = false
            for i in bgColor.indices {
                if bgColor[i] == fgColor[i] {
                    a = true
                    fgColor.shuffle()
                    break
                }
            }
        } while a ;
        
        
        let ans = (0 ..< 9).randomElement()!
        let putBgColorInFg = bgColor[ans]
//        let j = (0..<9).first(where: { ind in  fgColor[ind] == putBgColorInFg })!
        let newLocation = fgColor.firstIndex(of: putBgColorInFg) ?? 0
        
        
        //                Set Here V===================================deletedData
        (fgColor[ans], fgColor[newLocation]) = (fgColor[newLocation],  fgColor[ans])
        //                     ^newData
        
        
        if bgColor[newLocation]==fgColor[newLocation] {
            let special = Set(0..<9).subtracting([newLocation, ans]).randomElement()!
            (bgColor[special], bgColor[newLocation]) = (bgColor[newLocation], bgColor[special])
        }
        
        print(putBgColorInFg)
        colorBox.reloadData()
        
    }
    func scroeLableSetUp(){
        scroeLabel.layer.cornerRadius = 10
        scroeLabel.layer.backgroundColor = UIColor.lightGray.cgColor
        scroeLabel.layer.shadowRadius = 5
        scroeLabel.layer.shadowColor = UIColor.gray.cgColor
        scroeLabel.layer.shadowOpacity = 1.0
        scroeLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    func progress(){
        var a : Float = 1.0
        self.timeLine.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            a -= 0.01
            self.timeLine.progress = a
            print(self.timeLine.progress)
           
        })
        if self.timeLine.progress == 0.0{
            self.time.invalidate()
        }
    }
    
    
    func animationIn(desiredView: UIView){
        view.addSubview(desiredView)
        view.layer.backgroundColor = UIColor.lightGray.cgColor
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = view .center
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
        popupView.layer.cornerRadius = 20
        popupView.isHidden = false
    }
}
