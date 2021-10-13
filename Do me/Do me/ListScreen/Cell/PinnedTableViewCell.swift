//
//  PinnedTableViewCell.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import UIKit

class PinnedTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var taskList: [ListPresentation] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    private func configureCollectionView(){
        collectionView.register(UINib(nibName: "PinnedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PinnedCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension PinnedTableViewCell:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("asdasd")
    }
}
extension PinnedTableViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinnedCollectionViewCell", for: indexPath) as! PinnedCollectionViewCell
        cell.header.text = self.taskList[indexPath.row].header
        cell.title.text = self.taskList[indexPath.row].context
        cell.dateText.text = "13:51"
        return cell
    }
}
extension PinnedTableViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 2 - 20, height: contentView.frame.height - 20)
    }
}
