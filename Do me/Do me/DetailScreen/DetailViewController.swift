//
//  DetailViewController.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Bundle.main.loadNibNamed("DetailViewController", owner: self, options: nil)
    }

}
