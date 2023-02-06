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
    
    var fgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","Cyan"]
    var bgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","Cyan"]
    var time = Timer()
    
    let colorHelper :[String : UIColor] = [
        "Red" : UIColor.red,"Black" : UIColor.black,"Blue" : UIColor.blue,
        "Orenge" : UIColor.orange,"Green" : UIColor.green,"Purple" : UIColor.purple,
        "Yellow" : UIColor.yellow,"Brown" : UIColor.brown,"Cyan" : UIColor.cyan
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logic()
        timeLine.progress = 1.0
        progress()
        colorBox.layer.cornerRadius = 30
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
        
        print(putBgColorInFg, ans + 1, "******")
        
        colorBox.reloadData()
    }
    
    
    func progress(){
        var a : Float = 1.0
        self.timeLine.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            a -= 0.01
            self.timeLine.progress = a
            if self.timeLine.progress == 0.0{
                self.timeLine.progress = 0.0
                self.timeLine.isHidden = true
                self.time.invalidate()
            }
        })
    }
}
