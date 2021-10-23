//
//  DetailViewController.swift
//  Do me
//
//  Created by Yavuz Selim Bitmez on 30.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var reminderView: UIView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var repeatView: UIView!
    @IBOutlet weak var okayView: UIView!
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var repeats: UISwitch!
    @IBOutlet weak var header: UITextField!
    @IBOutlet weak var content: UITextView!
    var editable = false
    var keyboardOn = false
    var task:DetailPresentation?
    var viewModel:DetailViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (editable){
            viewModel.viewDidLoad()
        }
        configureNavigationBar()
        configureReminderView()
        configureMaskView()
    }

    fileprivate enum ButtonTag:Int {
        case okay = 0, dismiss,calendar ,save ,back,trash
    }
   private func configureNavigationBar(){
        let calendarBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tappedButton))
        calendarBarButtonItem.tag = 2
        calendarBarButtonItem.tintColor = .black
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(tappedButton))
        saveBarButtonItem.tag = 3
        saveBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        saveBarButtonItem.tintColor = .black
        let dismissBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(tappedButton))
        dismissBarButtonItem.tag = 1
        dismissBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        dismissBarButtonItem.tintColor = .black
        let trashBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(tappedButton))
        trashBarButtonItem.tag = 5
        trashBarButtonItem.tintColor = .black
        if (editable){
            trashBarButtonItem.isEnabled = true
        }else {
            trashBarButtonItem.isEnabled = false
        }


        navigationItem.leftBarButtonItem = dismissBarButtonItem
        navigationItem.rightBarButtonItems = [saveBarButtonItem,trashBarButtonItem,calendarBarButtonItem]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    func configureReminderView(){
        self.reminderView.frame = CGRect(x: self.reminderView.frame.origin.x, y: 1500, width: self.reminderView.frame.width, height: self.reminderView.frame.height)
        reminderView.isHidden = true
        reminderView.layer.cornerRadius = 30
        datePickerView.layer.cornerRadius = 10
        repeatView.layer.cornerRadius = 10
        okayView.layer.cornerRadius = 10
        dismissView.layer.cornerRadius = 10
    }
   private func configureMaskView(){
        maskView.alpha = 0
        maskView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(reminderViewTrigger))
        maskView.addGestureRecognizer(tap)
    }
    @IBAction func tappedButton(_ sender: UIButton) {
        switch sender.tag {
        case ButtonTag.okay.rawValue: reminderViewTrigger()
        case ButtonTag.dismiss.rawValue: self.navigationController?.popViewController(animated: true)
        case ButtonTag.calendar.rawValue: reminderViewTrigger()
        case ButtonTag.save.rawValue: save()
        case ButtonTag.back.rawValue: reminderViewTrigger()
        case ButtonTag.trash.rawValue: delete()

        default: break
        }
    }
    @objc func reminderViewTrigger(){
        if (self.reminderView.isHidden) {
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp) {
                self.reminderView.isHidden = false
                self.maskView.isHidden = false
                self.maskView.alpha = 0.3
                self.reminderView.frame = CGRect(x: self.reminderView.frame.origin.x,
                                                 y: self.view.center.y - self.reminderView.frame.height / 2 - 150,
                                                 width: self.reminderView.frame.width,
                                                 height: self.reminderView.frame.height)
            } completion: { completion in
                NSLog("[DetailViewController] Reminderview opened with animate.")
            }
        }else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp) {
                self.reminderView.frame = CGRect(x: self.reminderView.frame.origin.x, y: 1500, width: self.reminderView.frame.width, height: self.reminderView.frame.height)
                self.maskView.alpha = 0
            } completion: { completion in
                self.reminderView.isHidden = true
                self.maskView.isHidden = true
                NSLog("[DetailViewController] Reminderview animate closed with animate.")

            }
        }
    }
   private func save(){
        if checkViewComponents() {
            if editable {
                viewModel.updateTask(task: TaskModel(header: header.text!,
                                                   date: datePicker.date,
                                                   content: content.text,
                                                   id:task!.id, repeats: repeats.isOn))
                self.navigationController?.popViewController(animated: true)
            }else {
                viewModel.saveTask(task: TaskModel(header: header.text!,
                                                   date: datePicker.date,
                                                   content: content.text,
                                                   id:"", repeats: repeats.isOn))
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    private func delete(){
        viewModel.removeTask(task: task!)
        self.navigationController?.popViewController(animated: true)
    }
    func checkViewComponents() -> Bool {
        if header.text!.isEmpty {
            checkAlert(message: "Header")
            return false
        }else if content.text!.isEmpty {
            checkAlert(message: "Content")
            return false
        }
        return true
    }
    private func checkAlert(message:String) {
        let alert = UIAlertController(title: "Please fill this blank", message: message , preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Okay, thanks", style: .default, handler: nil))
        alert.view.layer.cornerRadius = 15
        alert.view.tintColor = .black
        self.present(alert, animated: true, completion: nil)
    }
}
extension DetailViewController:DetailViewModelDelegate {
    func showTaskDetail(_ task: DetailPresentation) {
        header.text = task.header
        content.text = task.content
        datePicker.date = task.date
        repeats.isOn = task.repeats
        self.task = task
    }
}
