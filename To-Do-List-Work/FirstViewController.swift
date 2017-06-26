//
//  FirstViewController.swift
//  To-Do-List-Work
//
//  Created by amadeus on 2017. 6. 8..
//  Copyright © 2017년 DIT Apps. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let defaults = UserDefaults.standard
    var items = [dataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UserDefaults에 저장된 내용을 key를 사용하여 불러옴
        if let decoded = defaults.object(forKey: "items") {
        let ItemObject = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! [dataModel]

        items = ItemObject
        print(items)
        
        //Reloads the rows and sections of the table view
        myTableView.reloadData()
        print("after reload items.count = \(items.count)")
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let myIndex = items[indexPath.row] 
        print("***** \(myIndex)")
        cell.textLabel?.text = myIndex.title
        cell.detailTextLabel?.text = myIndex.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            items.remove(at: indexPath.row)
            myTableView.reloadData()
            
            //삭제된 후 데이터(items)를 encode하여 UserDefaults에 새로 저장
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: items), forKey: "items")
            print("after remove items.count = \(items.count)")
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
