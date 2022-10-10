//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Sümeyye Kılıçoğlu on 8.05.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
@IBOutlet weak var ImageView: UIImageView!
@IBOutlet weak var nameText: UITextField!
@IBOutlet weak var artistText: UITextField!
@IBOutlet weak var yearText: UITextField!
@IBOutlet weak var saveButton: UIButton!
   var chosenPainting = ""
    var chosenPaintingid : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
if chosenPainting !=
    "" {
    // Core Data
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
    let idString = chosenPaintingid?.uuidString
    fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
    fetchRequest.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(fetchRequest)
        if results.count > 0 {
            for result in results as! [NSManagedObject] {
                
                if let name = result.value(forKey: "name") as? String {
                    nameText.text = name
                }
                if let artist = result.value(forKey: "artist") as? String {
                    artistText.text = artist
                }
                
                if let year = result.value(forKey: "year") as? Int
                {
                    yearText.text = String(year)
                }
                if let imageData = result.value(forKey: "image") as? Data {
                    let image = UIImage(data: imageData)
                    ImageView.image = image
                }

            }
        }
    } catch {
    print("error")
    }
    
} else {
    nameText.text = ""
    artistText.text = ""
    yearText.text = ""
}
    
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
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
     
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
        
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: contex)
        //        Attributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        if let year = Int (yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = ImageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        do {
            try contex.save()
            print("succes")
        }
        catch {
        print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
