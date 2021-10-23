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
        
        layer.cornerRadius = 10
        dateView.backgroundColor = .clear
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.black.cgColor
        
    }
    func configure(data:ListPresentation){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.timeZone = .current
        let customDate = dateFormatter.string(from: data.date)
        
        header.text = data.header
        title.text = data.content
        dateText.text = customDate
    }
}
