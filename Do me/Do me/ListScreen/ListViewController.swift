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
    @IBOutlet weak var addButton: UIButton!
    
    var rightBarFilterButton:UIBarButtonItem?
    var filterToggle = true
    var presenter: ListPresenterProtocol!
    var taskList: [ListPresentation] = []{
        didSet{
            tableview.reloadData()
        }
    }
    var searchedList: [ListPresentation] = []
    
    let searchController: UISearchController = {
    let sc = UISearchController(searchResultsController: nil)
    sc.obscuresBackgroundDuringPresentation = false
    sc.searchBar.placeholder = "Write what do you want to find :)"
        return sc
    }()
    override func viewWillAppear(_ animated: Bool) {
        if ( UserDefaults.standard.bool(forKey: "Update")) {
            reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("ListViewController", owner: self, options: nil)
        configureNavigationBarItem()
        configureTableView()
        presenter.viewDidLoad()
        emptyTaskViewConfigure()

    
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowRadius = 1
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        addButton.layer.masksToBounds = false
    }
    func reloadData(){
        taskList.removeAll()
        presenter.viewDidLoad()
        emptyTaskViewConfigure()
        UserDefaults.standard.setValue(false, forKey: "Update")

        
    }
    func configureNavigationBarItem(){
        self.rightBarFilterButton = UIBarButtonItem(title: "Filter by date", style: .plain, target: self, action: #selector(tappedButton))
        rightBarFilterButton?.tag = 0
        rightBarFilterButton?.tintColor = .black
        rightBarFilterButton?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .heavy)], for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarFilterButton
        let leftBarFilterButton = UIBarButtonItem(title: "Reminder", style: .plain, target: nil, action: nil)
        leftBarFilterButton.tintColor = .black
        leftBarFilterButton.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 30, weight: .heavy)], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarFilterButton
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .black
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    func emptyTaskViewConfigure(){
        if(self.taskList.isEmpty){
            noTaskView.isHidden = false
            tableview.isHidden = true
        }else {
            noTaskView.isHidden = true
            tableview.isHidden = false
        }
    }
    private func configureTableView(){
        tableview.register(UINib(nibName: "PinnedTableViewCell", bundle: nil), forCellReuseIdentifier: "PinnedTableViewCell")
    }
    @IBAction func tappedButton(_ sender: UIButton) {
        switch sender.tag {
        case ButtonTag.filter.rawValue: filter()
        default: break
        }
    }
    func filter(){
    
        if filterToggle {
            self.taskList = self.taskList.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
            presenter.updateSearchList(data: self.taskList)
            NSLog("[ListViewController] Filtered by date")
            self.rightBarFilterButton?.title = "Filter by Date"
            self.filterToggle = false
            UIView.animate(withDuration: 1) {
                self.view.backgroundColor = .systemGray4
                self.view.backgroundColor = .white

            }
        }else {
            self.taskList = self.taskList.sorted(by: { $0.header.compare($1.header) == .orderedDescending })
            presenter.updateSearchList(data: self.taskList)
            NSLog("[ListViewController] Filtered by header")
            self.rightBarFilterButton?.title = "Filter by Header"
            self.filterToggle = true
            UIView.animate(withDuration: 1) {
                self.view.backgroundColor = .systemGray4
                self.view.backgroundColor = .white
            }
        }
     
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        presenter.routeAdd()
    }
}


extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension ListViewController:UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PinnedTableViewCell", for: indexPath) as! PinnedTableViewCell
        cell.presenter = self.presenter
        cell.taskList = self.taskList
        return cell
     
   
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.taskList.count < 2 {
            return 250
        }else {
            return CGFloat(Int(self.taskList.count / 2 * 260) + 260)
        }
    }
}

extension ListViewController:ListViewProtocol{
    func handleOutput(_ output: ListPresenterOutput) {
        switch output {
        case .showList(let tasks):
            self.taskList = tasks
            self.searchedList = tasks
        DispatchQueue.main.async {
            self.tableview.reloadData()
            }
        }
        
    }
}

extension ListViewController:UISearchResultsUpdating,UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.taskList = self.searchedList
    }
    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else {
              return
          }
        if(searchText.count > 0){
            self.taskList.removeAll()
            self.taskList = searchedList.filter {
                return $0.content.range(of: searchText) != nil ||
                    $0.header .range(of: searchText) != nil
            }
            presenter.updateSearchList(data: self.taskList)
        }
        if(searchText.isEmpty){
            self.taskList.removeAll()
            self.taskList = self.searchedList
            presenter.updateSearchList(data: self.taskList)
        }
        NSLog("[ListViewController] Search Query: %@",searchText)
    }
}

 fileprivate enum ButtonTag:Int {
    case filter = 0
}

