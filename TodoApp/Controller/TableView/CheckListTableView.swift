//
//  CheckListTableView.swift
//  TodoApp
//
//  Created by Canan Gök on 25.08.2019.
//  Copyright © 2019 Canan Gök. All rights reserved.
//


import UIKit
//alttaki veriyi üste taşımak için delegate yazıyoruz
protocol CheckListTableViewDelegate : class {
    func didSelect(at index:Int)
}

class CheckListTableView: UITableView {
    
    var actionDelegate : CheckListTableViewDelegate?
    var checkListItemList:[CheckListItemModel] = [] {
        didSet{
            reloadData()
        }
    }
    
    //Init method like viewDidLoad().
    override func awakeFromNib() {
        super.awakeFromNib()
        //protocol tanımlama.
        delegate = self
        //protocol tanımlama.
        dataSource = self
        //listenin footer kısmını kapatmak için tanımladık.
        tableFooterView = UIView()
    }
}
//Clean code : Protocol extend etmek için.
extension CheckListTableView: UITableViewDataSource {
    
    //Listedeki satır sayısını gösterir.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkListItemList.count
    }
    //Listedeki indexe karşılık gelen satırı gösterir.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: "CheckListTableViewCell") as? CheckListTableViewCell {
            let item = checkListItemList[indexPath.row]
            cell.taskNameLabel.text = item.taskName
            cell.priorityLabel.text = item.priority.rawValue
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,title: "Delete"){
                (action, view, success) in
            self.actionDelegate?.didSelect(at: indexPath.row)
            success(true)
                
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
}
//Clean code : Protocol extend etmek için.
extension CheckListTableView : UITableViewDelegate {
    
  
    
}



