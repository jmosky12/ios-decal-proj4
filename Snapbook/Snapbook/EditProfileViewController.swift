//
//  EditProfileViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 12/6/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: UserProfileViewControllerDelegate?
    
    init() {
        super.init(nibName: "EditProfileViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bioTextView.editable = true
        bioTextView.text = delegate?.getBioText()
        imageView.hidden = true
        cancelButton.hidden = true
        doneButton.layer.cornerRadius = 5.0
        cancelButton.layer.cornerRadius = 15.0
        uploadPhotoButton.layer.cornerRadius = 5.0
        bioTextView.layer.cornerRadius = 5.0
    }

    @IBAction func uploadPhotoPressed(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        imageView.image = nil
        imageView.hidden = true
        cancelButton.hidden = true
    }

    @IBAction func doneButtonPressed(sender: UIButton) {
        if imageView.image != nil {
            delegate?.changePicture(imageView.image!)
        }
        delegate?.setBioText(bioTextView.text)
        self.navigationController?.popViewControllerAnimated(true)
    }


}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.hidden = false
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        cancelButton.hidden = false
        picker.dismissViewControllerAnimated(true, completion: nil)
        //add pic to user's data, make the tableview cell adjust to the one with the picture
    }
}
