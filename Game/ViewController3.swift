//
//  ViewController3.swift
//  Game
//
//  Created by R&W on 04/02/23.
//

import UIKit

class ViewController3: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var fgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","cyan"]
    var bgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","cyan"]
    
    let colorHelper :[String : UIColor] = ["Red" : UIColor.red,"Black" : UIColor.black,"Blue" : UIColor.blue,"Orenge" : UIColor.orange,"Green" : UIColor.green,"Purple" : UIColor.purple,"Yellow" : UIColor.yellow,"Brown" : UIColor.brown,"cyan" : UIColor.cyan]
    
    @IBOutlet weak var timeLine: UIProgressView!
    @IBOutlet weak var colorBox: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logic()
        timeLine.progress = 1.0
        progress()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fgColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorBox.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.layer.cornerRadius = 30
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
    
    func logic(){
        //fgColor=["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","cyan"]
        fgColor.shuffle()
        let number = (0 ..< 9).randomElement()!
        print("Number: \(number)")
        
        
        bgColor.shuffle()
        
        var a : Bool = false
        
        repeat {
            a = false
            for i in bgColor.indices
            {
                if bgColor[i] == fgColor[i]
                {
                    a = true
                    fgColor.shuffle()
                    break
                }
            }
        } while a ;
        
        let putBgColorInFg = bgColor[number]
        
        
        for j in 0..<9 {
            if (fgColor[j]==putBgColorInFg) {
                let backupColor = fgColor[number]
                fgColor[number] = putBgColorInFg
                
                if bgColor[j]==backupColor {
                    fgColor[j] = "amber"
                }
                else{
                    fgColor[j]=backupColor
                }
                
                print(fgColor)
                print(backupColor)
                print(putBgColorInFg)
                break
            }
        }
        
        colorBox.reloadData()
    }
    
    
    
    var time = Timer()
    
    func progress(){
        var a : Float = 1.0
        self.timeLine.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            a -= 0.01
            print(a)
            self.timeLine.progress = a
            if self.timeLine.progress == 0.0{
                self.timeLine.progress = 0.0
                self.timeLine.isHidden = true
                self.time.invalidate()
            }
        })
    }
}
