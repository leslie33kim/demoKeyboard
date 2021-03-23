//
//  ViewController.swift
//  DemoKeyboard
//
//  Created by admin on 05/03/21.
//

import UIKit

class DisplayDataVC: UIViewController,KeyboardDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var originaltext = NSMutableAttributedString()
    var strOrig:String!  = ""
    var strImg:String!  = nil
    var arrSelectImages  = [String]()
    var arrDisData = [String]()

    let keyboardView = CustomView(frame: CGRect(x: 0, y: 0, width: 0, height: 300))

    @IBOutlet weak var txtData: UITextView!
    @IBOutlet weak var tblData: UITableView!
    @IBOutlet weak var conbottomtxtMsg: NSLayoutConstraint!

    
    func keyWasTapped(imgName: String,btnisSelect: Bool,isText:Bool) {
        strImg = imgName
        
        self.arrDisData.append(imgName)
        self.tblData.reloadData()

    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        txtData.layer.cornerRadius = 10
        txtData.layer.borderWidth = 1
        txtData.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtData.becomeFirstResponder()
        keyboardView.delegate = self
        keyboardView.imgname = ""
        keyboardView.simpleimgname = ""
        txtData.attributedText = NSAttributedString(string: "Select Images")
        txtData.inputView = keyboardView
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resetTapped))
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        bar.items = [reset,spaceBtn]
        bar.sizeToFit()
        txtData.inputAccessoryView = bar
    }
    

    //MARK:- Keyboard Notfi
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.conbottomtxtMsg.constant =   10
            })

        }


    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.conbottomtxtMsg.constant = 10
                
            })

        }
    }

    //MARK:- Tableview delegate Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDisData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblData.dequeueReusableCell(withIdentifier: "CellTblDisplay") as! CellTblDisplay
        let strImg1  = self.arrDisData[indexPath.row]
        if strImg1.contains(".jpeg"){
            cell.imgDisplay.image = UIImage(named: strImg1)
        }
        else {
              let gifimg = UIImage.gifImageWithName(strImg1)
            cell.imgDisplay.image = gifimg
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrDisData.count  > 0 {
            return 180
        }
        return 0
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrDisData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
     }
    
    @objc func resetTapped(){
        self.view.endEditing(true)
    }
    
    @objc func clearTapped(){
        
        txtData.deleteBackward()
        if txtData.attributedText.length == 0 {
            txtData.inputView  = nil
            txtData.reloadInputViews()
            strImg = ""
            viewWillAppear(true)
            self.view.endEditing(true)
        }
        
    }
}

