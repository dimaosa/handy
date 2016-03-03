//
//  ViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    
    var picker: UIImagePickerController!

    func noCamera(){
        let alertVC = UIAlertController(
            title: "Dear User!",
            message: "I want to infrom you, this device has no camera...",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC,
            animated: true,
            completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!

    
    var currentImage = UIImage() {
        didSet {
            imageView.userInteractionEnabled = true
            NSLog("New image is set!")
            performSegueWithIdentifier(Constants.choosePhotoIdentifier, sender: nil)
        }
    }
    @IBAction func cameraPhoto(sender: AnyObject) {
        if (UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil){
            picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .Camera
            presentViewController(picker, animated: true,completion:nil)
        } else {
            noCamera()
            NSLog("No Fucking camera, poor guy!")
        }
        
    }

    @IBAction func choosePhoto(sender: AnyObject) {
        picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true) { () -> Void in
            NSLog("Pick from Photo Library!")
        }
    }
    
    @IBAction func takePhoto(sender: AnyObject) {}
    override func viewDidLoad() {
        super.viewDidLoad()
        tagGestureConfiguration()
    }
    //MARK: Configuration function
    
    func tagGestureConfiguration() {
        
        // UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
        //initWithTarget:self action:@selector(respondToTapGesture:)];
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector("tapOnImageView:")
        )
        self.imageView.addGestureRecognizer(tapRecognizer)
    }
    
    func tapOnImageView(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier(Constants.choosePhotoIdentifier, sender: nil)
        NSLog("tapOnImageView")
        
    }

    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        currentImage = chosenImage
        imageView.contentMode = .ScaleAspectFit
        imageView.image = chosenImage
        dismissViewControllerAnimated(true) { () -> Void in
            NSLog("Get out from imagePickerController")
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { () -> Void in
            NSLog("Dismiss view controller animation!")
        }
    }
    
    private struct Constants{
        static let choosePhotoIdentifier = "choosePhotoIdentifier"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier {
            case Constants.choosePhotoIdentifier:
                NSLog("Constants.choosePhotoIdentifier")
                if let con = segue.destinationViewController as? PhotoViewController{
                    con.image = self.currentImage
                }
                break
            default:
                break
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
}

