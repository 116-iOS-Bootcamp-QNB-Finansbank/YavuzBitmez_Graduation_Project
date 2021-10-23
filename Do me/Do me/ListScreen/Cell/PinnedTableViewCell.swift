//
//  PinnedTableViewCell.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import UIKit

class PinnedTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var taskList: [ListPresentation] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    var presenter: ListPresenterProtocol!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    private func configureCollectionView(){
        collectionView.register(UINib(nibName: "PinnedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PinnedCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension PinnedTableViewCell:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Detail will open
        presenter.didSelectRow(at: indexPath)
    }
}
extension PinnedTableViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.taskList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinnedCollectionViewCell", for: indexPath) as! PinnedCollectionViewCell
        cell.configure(data: taskList[indexPath.row])
        return cell
    }
}
extension PinnedTableViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 2 - 15, height: 240)
    }
}
