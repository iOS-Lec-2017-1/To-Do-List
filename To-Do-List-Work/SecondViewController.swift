//
//  SecondViewController.swift
//  To-Do-List-Work
//
//  Created by amadeus on 2017. 6. 8..
//  Copyright © 2017년 DIT Apps. All rights reserved.
//

import UIKit

class SecondViewController:  UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    
    let defaults = UserDefaults.standard
    var items = [dataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: UIButton) {
        
        let currentDate = Date()
        let format = DateFormatter()
        format.locale = NSLocale(localeIdentifier: "ko_kr") as Locale!
        format.dateFormat = "yyyy-MM-dd"
        
        if let decoded = defaults.object(forKey: "items") as? NSData {
            let itemObject = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [dataModel]
            items = itemObject
            
            let inputTitle = itemTextField.text
            let inputDate = format.string(from: currentDate)

            let newItem = dataModel(title: inputTitle!, date: inputDate)
            
            items.append(newItem)
            print(items)
            
        } else {
            let newItem = dataModel(title: itemTextField.text! , date: format.string(from: currentDate))
            items = [newItem]
            print(items)

        }
        
        // key 값이 "items"로 items 배열을 저장소에 encode하여 저장함(다음에 불러 오기 위해)
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: items), forKey: "items")
        
        // 다음 입력을 위해 텍스트필드 초기화
        itemTextField.text = ""
    }
    
    // 바탕화면의 View를 누르면 키패드가 내려간다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // [Return] 키를 누르면 키패드가 내려간다.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
