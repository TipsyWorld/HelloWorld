//
//  CardCell.swift
//  MatchingGame
//
//  Created by Rsquare on 2021/10/27.
//

import UIKit

class CardCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    
    func update(item: Card){
        
        if item.isFliped {
            
            UIView.transition(with: self.cellView, duration: 1, options: .transitionFlipFromLeft, animations: {
                self.cellView.backgroundColor = item.frontColor
            }, completion: { _ in
               
           })
            
        }else{
            
            UIView.transition(with: self.cellView, duration: 1, options: .transitionFlipFromRight, animations: {
                self.cellView.backgroundColor = item.backColor
            }, completion: nil)
        }
//        switch item.status {
//        case .front:
//            self.cellView.backgroundColor = item.frontColor
//        case .back:
//            self.cellView.backgroundColor = item.backColor
//        }
        
        
        
    }
    
}
