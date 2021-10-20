//
//  EditViewController.swift
//  ProfileName
//
//  Created by mac on 8/10/21.
//

import UIKit

class EditViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtProfesi: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProfileModel.syncronize()
        self.txtName.text = ProfileModel.name
        self.txtProfesi.text = ProfileModel.profession
        self.txtEmail.text = ProfileModel.email
    }

    @IBAction func saveBtnAct(_ sender: Any) {
        
        if let name = txtName.text, let email = txtEmail.text, let profession = txtProfesi.text {
            if name.isEmpty {
                textEmpty("Nama")
            } else if email.isEmpty {
                textEmpty("Email")
            } else if profession.isEmpty {
                textEmpty("Profession")
            } else {
                saveProfile(name, email, profession)
                self.clearText()
                self.back()
            }
        }
    }
    
    @IBAction func cancelBtnAct(_ sender: Any) {
        self.back()
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveProfile(_ name: String, _ email: String, _ profession: String) {
        ProfileModel.stateLogin = true
        ProfileModel.name = name
        ProfileModel.email = email
        ProfileModel.profession = profession
    }
    
    func clearText() {
        self.txtEmail.text = ""
        self.txtName.text = ""
        self.txtProfesi.text = ""
    }
    
    func textEmpty(_ field: String) {
        let alert = UIAlertController(
            title: "Alert?",
            message: "\(field) is empty",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
