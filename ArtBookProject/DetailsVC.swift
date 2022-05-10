//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Sümeyye Kılıçoğlu on 8.05.2022.
//

import UIKit

class DetailsVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
@IBOutlet weak var ImageView: UIImageView!
@IBOutlet weak var nameText: UITextField!
@IBOutlet weak var artistText: UITextField!
@IBOutlet weak var yearText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        ImageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        ImageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectImage() {
    let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
     
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
        
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
    }
    
}
