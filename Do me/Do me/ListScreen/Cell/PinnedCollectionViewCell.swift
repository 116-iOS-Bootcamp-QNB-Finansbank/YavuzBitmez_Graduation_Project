//
//  PinnedCollectionViewCell.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import UIKit

class PinnedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var taskView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.colors = [UIColor.random().cgColor, UIColor.white.cgColor]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradient.frame = self.frame
//        taskView.layer.insertSublayer(gradient, at: 0)

        taskView.backgroundColor = .random()
        layer.cornerRadius = 10
        dateView.backgroundColor = .clear
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.black.cgColor
    }

}
