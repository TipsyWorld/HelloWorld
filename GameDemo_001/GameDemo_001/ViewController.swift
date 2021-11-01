//
//  ViewController.swift
//  GameDemo_001
//
//  Created by Rsquare on 2021/10/23.
//

import UIKit

enum Type {
    case odd
    case even
}

class ViewController: UIViewController {

    @IBOutlet weak var fistImage: UIImageView!
    @IBOutlet weak var comNumbers: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var comRemain: UILabel!
    @IBOutlet weak var userRemain: UILabel!
    
    var userBalls = 10
    var comBalls = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fistImage.isHidden = true
        self.comRemain.text = "남은 구슬 \(comBalls)개"
        self.userRemain.text = "남은 구슬 \(userBalls)개"
    }

    @IBAction func gameStartPressed(_ sender: UIButton) {
        self.fistImage.isHidden = false
//
//        UIView.animate(withDuration: 3.0) {
//
//            self.fistImage.transform = CGAffineTransform(scaleX: 5, y: 5)
//            self.fistImage.transform = CGAffineTransform(scaleX: 1, y: 1)
//        } completion: { _ in
//                self.showAlert()
//        }
        
//        UIView.animate(withDuration: 3.0) {
//            UIView.transition(with: self.fistImage, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//            UIView.transition(with: self.fistImage, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
//        }
        
        
//        UIView.animate(withDuration: 2.0) {
//
//        } completion: { com in
//
//        }

        
//        UIView.transition(with: self.fistImage, duration: 2, options: .transitionCurlUp, animations: nil, completion: { _ in
//        UIView.transition(with: self.fistImage, duration: 2, options: .transitionFlipFromRight, animations: nil, completion: nil)
//    })
        
        
        
        UIView.animate(withDuration: 3.0) {

            self.fistImage.transform = CGAffineTransform(rotationAngle: 90)
            self.fistImage.transform = CGAffineTransform(rotationAngle: 360)
            self.fistImage.transform = CGAffineTransform(rotationAngle: 0)
        } completion: { _ in
//                        self.showAlert()
        }
        
        
    }

    func showAlert(){
        let alert = UIAlertController.init(title: "GAME START", message: "홀 짝을 선택해주세요 ", preferredStyle: .alert)
        
        let oddBtn = UIAlertAction.init(title: "홀", style: .default) { btn in
            self.fistImage.isHidden = true
            print(alert.textFields?.first?.text)
            guard let numbers = alert.textFields?.first?.text else {
                return
            }
            
            guard let intNumber =  Int(numbers) else {
                return
            }
            
            self.getWinner(many: intNumber, type: .odd)
        }
        
        let evneBtn = UIAlertAction.init(title: "짝", style: .default) { _ in
            self.fistImage.isHidden = true
            print(alert.textFields?.first?.text)
            
            guard let numbers = alert.textFields?.first?.text else {
             return
            }
            
            guard let intNumber =  Int(numbers) else {
                return
            }
            
            self.getWinner(many: intNumber, type: .even)
        }
        
        alert.addTextField { textView in
            textView.placeholder = "배팅할 구슬의 갯수를 적어주세요."
            
        }
        alert.addAction(oddBtn)
        alert.addAction(evneBtn)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getWinner(many: Int, type: Type ){
        
        let com = self.getRandom()
        
        self.comNumbers.text = com % 2 == 0 ? "짝 \(com)" :
            "홀 \(com)"
        let comType = getType(origin: com)
        
        if comType == type {
            print("user win")
            self.resultLbl.text = "user win"
            self.calculateBalls(winner: "user", many: many)
        }else{
            print("com  win")
            self.resultLbl.text = "com win"
            self.calculateBalls(winner: "com", many: many)
        }
        
    }
    
    func calculateBalls(winner: String, many: Int){
        
        if winner == "com" {
            self.userBalls = self.userBalls - many
            self.comBalls = self.comBalls + many
            
            if checkAccountEmpty(balls: self.userBalls) {
                self.resultLbl.text = "com win 유저 파산 "
            }
        }else{
            self.userBalls = self.userBalls + many
            self.comBalls = self.comBalls - many
            
            if checkAccountEmpty(balls: self.comBalls) {
                self.resultLbl.text = "user win 컴 파산"
            }
        }
        
        self.comRemain.text = "남은 구슬 \(comBalls)개"
        self.userRemain.text = "남은 구슬 \(userBalls)개"
    }
    
    func checkAccountEmpty(balls:Int) -> Bool{
        return balls == 0
    }
    
    func getRandom() -> Int {
        return Int(arc4random() % 10 + 1)
    }
    
    func getType(origin:Int) -> Type{
        return origin%2 == 0 ? .even : .odd
    }
    
}

