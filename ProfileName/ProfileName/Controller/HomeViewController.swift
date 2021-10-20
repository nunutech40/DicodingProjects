//
//  HomeViewController.swift
//  ProfileName
//
//  Created by mac on 8/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProfileModel.syncronize()
        setupProfile()
    }
    
    func setupProfile() {
        nameLabel.text = "\(ProfileModel.name) as \(ProfileModel.profession)"
        emailLabel.text = "\(ProfileModel.email)"
    }

    @IBAction func editBtnAc(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyBoard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        self.present(newVC, animated: true, completion: nil)
    }
    
    @IBAction func resetBtnAct(_ sender: Any) {
        if ProfileModel.deleteAll() {
            self.dismiss(animated: true, completion: nil)
        }
       
    }
}
