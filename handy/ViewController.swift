//
//  ViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit
import Nuke

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
    
    
    var currentImage = UIImage() {
        didSet {
            NSLog("New image is set!")
            self.performSegueWithIdentifier(Constants.choosePhotoIdentifier, sender: self)
        }
    }
    
    @IBOutlet weak var buttonCamera: UIButton!
    @IBAction func cameraPhoto(sender: AnyObject) {
        
        //check if camera is available
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: Configuration function
    
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        currentImage = chosenImage
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
            print(identifier)
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
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    func createBlurBackground() {
        

        let bckgrndImgViw = UIImageView()
        bckgrndImgViw.image = currentImage
        bckgrndImgViw.contentMode = .ScaleAspectFill
        bckgrndImgViw.frame = CGRectMake(
            0,
            0,
            UIScreen.mainScreen().bounds.width,
            UIScreen.mainScreen().bounds.height
        )
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        bckgrndImgViw.addSubview(blurEffectView)
        self.view.insertSubview(bckgrndImgViw, atIndex: 0)
    }
}

