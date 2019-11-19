//
//  AddCheckListViewController.swift
//  TodoApp
//
//  Created by Canan Gök on 25.08.2019.
//  Copyright © 2019 Canan Gök. All rights reserved.
//

import UIKit
protocol AddCheckListViewControllerDelegate : class {
    func AddNewTask(_ task:CheckListItemModel)
}
class AddCheckListViewController: UIViewController {
   
    private var newTask :CheckListItemModel = CheckListItemModel()
    
    weak var actionDelegate : AddCheckListViewControllerDelegate?
    //task oluşturmamızı sağlayan button
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    //task ismini set etmemizi sağlayan button
    @IBOutlet weak var taskNameButtonITem: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after
        doneBarButtonItem.isEnabled = false
        taskNameButtonITem.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskNameButtonITem.becomeFirstResponder()
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let unwrappedTaskName = taskNameButtonITem.text else {return}
        newTask.taskName = unwrappedTaskName
        actionDelegate?.AddNewTask(newTask)
        navigationController?.popViewController(animated: true)
    }
   
    @IBAction func prioritySegmentControlValueChanged(_ sender: UISegmentedControl) {
        let priorityTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)
      
        if let unwrappedTitle = priorityTitle,
            let unwrappedPriority = Priority(rawValue: unwrappedTitle){
            newTask.priority = unwrappedPriority
        }
        else{
            let action :  UIAlertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            let alert : UIAlertController = UIAlertController(title: "Hata", message: "Geliştirici ile iletişime geçiniz", preferredStyle: .alert)
            
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        }
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskNameButtonITem.resignFirstResponder()
    }
    
}
//Eski ve yeni tapped değerlerini tutarak done butonunun state'ini değiştirmek
extension AddCheckListViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range,in:oldText)
            else{
                return false;
        }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButtonItem.isEnabled=newText.isEmpty ?  false :true
        return true
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        taskNameButtonITem.resignFirstResponder()
        return true
    }
}
