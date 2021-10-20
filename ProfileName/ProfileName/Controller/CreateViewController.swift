//
//  CreateViewController.swift
//  ProfileName
//
//  Created by mac on 8/10/21.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var txtProfesion: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var createButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.pinkColor()
    }

    @IBAction func createBtn(_ sender: Any) {
        print("cek create button")
        if let name = txtName.text, let email = txtEmail.text, let profession = txtProfesion.text {
            if name.isEmpty {
                textEmpty("Nama")
            } else if email.isEmpty {
                textEmpty("Email")
            } else if profession.isEmpty {
                textEmpty("Profession")
            } else {
                saveProfile(name, email, profession)
                self.clearText()
                print("cek save profile")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.present(newViewController, animated: true, completion: nil)
            }
        }
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
        self.txtProfesion.text = ""
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
