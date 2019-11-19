//
//  ViewController.swift
//  TodoApp
//
//  Created by Canan Gök on 25.08.2019.
//  Copyright © 2019 Canan Gök. All rights reserved.
//

import UIKit

class CheckListViewController: UIViewController {

   
    @IBOutlet weak var organizeBarButtonItem: UIBarButtonItem!
    
    //To do itemları listeler
    @IBOutlet weak var checkListTableView: CheckListTableView!
    
    //Oluşturulan her bir itemi listenin içine atmamızı sağlayan data source
    private var checkListItemList : [CheckListItemModel] = []{ 
        didSet{
            organizeBarButtonItem.isEnabled = checkListItemList.isEmpty ? false : true
            checkListTableView.checkListItemList = checkListItemList
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }

    private func configure(){
        organizeBarButtonItem.isEnabled = false
        checkListTableView.actionDelegate = self
    }

    //To do item yaratcak sayfaya gider
    @IBAction func addItemTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addCheckListViewController =  storyboard.instantiateViewController(withIdentifier: "AddCheckListViewController") as? AddCheckListViewController {
            addCheckListViewController.actionDelegate = self
            self.navigationController?.pushViewController(addCheckListViewController, animated: true)
        }
    }
    @IBAction func organizeButtonTapped(_ sender: Any) {
        checkListItemList.sort{$0.priority.orderNo > $1.priority.orderNo}
    }
}

extension CheckListViewController : AddCheckListViewControllerDelegate{
    func AddNewTask(_ task: CheckListItemModel) {
        checkListItemList.append(task)
    }

}
extension CheckListViewController : CheckListTableViewDelegate{
    func didSelect(at index: Int) {
        checkListItemList.remove(at: index)
    }
}
