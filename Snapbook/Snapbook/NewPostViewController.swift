//
//  NewPostViewController.swift
//  Snapbook
//
//  Created by Jake Moskowitz on 11/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var newPostTextView: UITextView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelPicButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    var delegate:PostTable?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        imageView.hidden = true
        cancelPicButton.hidden = true
        cancelPicButton.layer.cornerRadius = 15.0
        newPostTextView.layer.cornerRadius = 5.0
        uploadPhotoButton.layer.cornerRadius = 5.0
        postButton.layer.cornerRadius = 5.0
    
        
    }

    @IBAction func uploadPhotoPressed(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func postPressed(sender: UIButton) {
//        let player = PFObject(className: "Post2")
//        player.setObject((PFUser.currentUser()?.username!)!, forKey: "Name")
//        player.setObject(newPostTextView.text, forKey: "Text")
//        player.setObject([1,2,3,4], forKey: "lol")
//        player.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//            if succeeded {
//                print("Object Uploaded")
//            } else {
//                print("Error: \(error!) \(error?.userInfo)")
//            }
//        }
        //1
        let p = Post(image: nil, user: PFUser.currentUser()!, comment: newPostTextView.text)
        //2
        p.saveInBackgroundWithBlock{ succeeded, error in
            if succeeded {
                //3
                self.delegate?.refresh()
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                //4
                if let errorMessage = error?.userInfo["error"] as? String {
                    print(errorMessage)
                }
            }
        }
        
    }
    
    @IBAction func cancelPicPressed(sender: UIButton) {
        //remove pic from database
    }

}

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.hidden = false
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        cancelPicButton.hidden = false
        picker.dismissViewControllerAnimated(true, completion: nil)
        //add pic to user's data, make the tableview cell adjust to the one with the picture
    }
}
