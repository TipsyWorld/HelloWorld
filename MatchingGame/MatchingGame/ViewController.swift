//
//  ViewController.swift
//  MatchingGame
//
//  Created by Rsquare on 2021/10/27.
//

import UIKit

struct Card {
    var frontColor: UIColor
    var backColor: UIColor
//    var status: CardStatus = .back
    var isFliped = false
    var isMatched = false
    init(frontColor: UIColor, backColor: UIColor) {
        self.frontColor = frontColor
        self.backColor = backColor
    }
    
}

enum CardStatus {
    case front
    case back
}

//그림보고 뜻맞추기 게임  영어단어 맞추기
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var opendCard:Card?
    var indexPathArr: [IndexPath] = []
    
    var array = [
        Card(frontColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Card(frontColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), backColor:  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.array[indexPath.item].isMatched {
            return
        }
        self.indexPathArr.append(indexPath)
        if self.indexPathArr.count == 2  {
            // do compare
            guard let fist = self.indexPathArr.first?.item, let last = self.indexPathArr.last?.item else {
                return
            }
            
            if self.array[fist].frontColor == self.array[last].frontColor {
                print("같은")
                self.array[fist].isFliped = true
                self.array[last].isFliped = true
                self.array[fist].isMatched = true
                self.array[last].isMatched = true
                collectionView.reloadItems(at: [indexPath])
                self.indexPathArr.removeAll()
            }else{
                print("다름")
                self.array[fist].isFliped = false
                self.array[last].isFliped = false
                collectionView.reloadItems(at: self.indexPathArr)
                self.indexPathArr.removeAll()
            }
        }else{
            
            if !self.array[indexPath.item].isMatched {
                self.array[indexPath.item].isFliped = !self.array[indexPath.item].isFliped
            }
            
        }
        
        
        
        
        
        
        
        collectionView.reloadItems(at: [indexPath])
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }
        
        cell.update(item: self.array[indexPath.item])
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.bounds.width - 20)/3
        let height = width
        
        return CGSize(width:width, height:height)
    }
}
