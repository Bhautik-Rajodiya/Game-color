//
//  ViewController3.swift
//  Game
//
//  Created by R&W on 04/02/23.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var hart1: UIButton!
    @IBOutlet weak var hart2: UIButton!
    @IBOutlet weak var hart3: UIButton!
    @IBOutlet weak var timeLine: UIProgressView!
    @IBOutlet weak var colorBox: UICollectionView!
   
    @IBOutlet weak var scroeLabel: UILabel!

    
    var fgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","Cyan"]
    var bgColor = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","Cyan"]
    var time = Timer()
    
    let colorHelper :[String : UIColor] = [
        "Red" : UIColor.red,"Black" : UIColor.black,"Blue" : UIColor.blue,
        "Orenge" : UIColor.orange,"Green" : UIColor.green,"Purple" : UIColor.purple,
        "Yellow" : UIColor.yellow,"Brown" : UIColor.brown,"Cyan" : UIColor.cyan
    ]
    var scroe = 0
    var timeAcsept: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
       
    }
    
    
    
    func reloadData() {
        logic()
        timeLine.progress = 1.0
        progress()
        colorBox.layer.cornerRadius = 30
        scroeLableSetUp()
        scroe = 0
        colorBox.reloadData()
        
        self.view.isUserInteractionEnabled = true
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
        scroeLabel.text = "\(Int(scroe))"
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
        var count = 3
        let selectedCellLable = fgColor[indexPath.item]
        let selectedCellBgColor = bgColor[indexPath.item]
        if selectedCellLable == selectedCellBgColor {
            time.invalidate()
            progress()
            scroe += 1
            return
        }
        
        if selectedCellLable != selectedCellBgColor {
            time.invalidate()
            progress()
            let img1 = UIImage(systemName: "suit.heart")
            hart1.setImage(img1, for: .normal)
            count -= 1
        }
        else if count == 2{
            time.invalidate()
            progress()
            let img2 = UIImage(systemName: "suit.heart")
            hart2.setImage(img2, for: .normal)
            count -= 1
        }
        else if count == 1{
            time.invalidate()
            progress()
            let img3 = UIImage(systemName: "suit.heart")
            hart3.setImage(img3, for: .normal)
        }
        else {
            time.invalidate()
            animationIn()
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
        var a = timeAcsept
        self.timeLine.progress = 1
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            a -= 1
            self.timeLine.progress = a/self.timeAcsept
            if a <= 0 {
                self.time.invalidate()
                self.animationIn()
            }
        })
        
    }
    
    
    func animationIn(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpView") as! PopUpView
        vc.reload = reloadData
        vc.scoreTranfar = scroe
        vc.myNav = navigationController
        
        self.present(vc, animated: false)
    }
}


