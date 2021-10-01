//
//  ListViewController.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var noTaskView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    var taskLists = [TaskModel]()
    var finishedLists = [TaskModel]()
    var sections = [Section]()
    let date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("ListViewController", owner: self, options: nil)
        configureTableView()
        configureSections()
        taskDemo()

    }
    private func taskDemo(){
        self.taskLists.append(TaskModel(id: 1, header: "Yap", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.taskLists.append(TaskModel(id: 1, header: "Yap", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.taskLists.append(TaskModel(id: 1, header: "Yap", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.taskLists.append(TaskModel(id: 1, header: "Yap", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.taskLists.append(TaskModel(id: 1, header: "Yap", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.taskLists.append(TaskModel(id: 1, header: "Yap", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.finishedLists.append(TaskModel(id: 1, header: "Bittiiiii", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.finishedLists.append(TaskModel(id: 1, header: "Bittiiiii", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
        self.finishedLists.append(TaskModel(id: 1, header: "Bittiiiii", date: self.date, context: "Bunlarrrrrrrrrrrrrrrr"))
    }
    private func configureSections(){
        let pinnedSection = Section(name: "Pinned")
        let upComingSection = Section(name: "UpComing")
        let finishedSection = Section(name: "Finished")

        sections.append(pinnedSection)
        sections.append(upComingSection)
        sections.append(finishedSection)
    }
    private func configureTableView(){
        tableview.register(UINib(nibName: "PinnedTableViewCell", bundle: nil), forCellReuseIdentifier: "PinnedTableViewCell")
        
    }
}


extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
}

extension ListViewController:UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PinnedTableViewCell", for: indexPath) as! PinnedTableViewCell
        return cell
    }
    //Section process
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sections[section].name == "Pinned" {
            return 1
        }else if self.sections[section].name == "UpComing"{
            return self.taskLists.count
        }else  {
            return self.finishedLists.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        view.backgroundColor = .white
        let title = UILabel(frame: CGRect(x: 15, y: 5, width: view.frame.width, height: 20))
        title.textColor = .darkGray
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.text = self.sections[section].name
        view.addSubview(title)
        return view
    }
}
