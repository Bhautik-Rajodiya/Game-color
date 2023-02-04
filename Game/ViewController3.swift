//
//  ViewController3.swift
//  Game
//
//  Created by R&W on 04/02/23.
//

import UIKit

class ViewController3: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var color = ["Red","Black","Blue","Orenge","Green","Purple","Yellow","Brown","cyan"]
    var colors :[UIColor] = [UIColor.red,UIColor.black,UIColor.blue,UIColor.orange,UIColor.green,UIColor.purple,UIColor.yellow,UIColor.brown,UIColor.cyan]

    @IBOutlet weak var colorBox: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	   let cell = colorBox.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.layer.cornerRadius = 30
        cell.lb.text = color[indexPath.row]
        cell.layer.backgroundColor = colors[indexPath.row].cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width-14.1-40)/3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        colors.shuffle()
        color.shuffle()
        colorBox.reloadData()
    }
}
