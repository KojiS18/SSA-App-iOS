//
//  ViewController.swift
//  app4
//
//  Created by Peter W on 4/15/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

import AVFoundation

class QRReaderViewController: UIViewController, UITextFieldDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var written: Bool = false
    
    @IBOutlet var messageLabel: UILabel!
    
   
    
    
    let supportedCodeTypes = [
        AVMetadataObjectTypeQRCode
        ]
    
    func tryToWrite(text: String){
        if text != "" && !written {
            var counter = 0
            var stringCounter = 0
            var freeArray = text.split(separator: ",")
            for each in freeArray {
                if Int(each) != nil {
                    counter = counter + 1
                    print("has \(counter) valid frees")
                } else {
                    stringCounter = stringCounter + 1
                }
            }
            if counter > 1 && stringCounter==1 {
                written = true
                print(freeArray)
                let defaults:UserDefaults = UserDefaults.standard
                if var namesArray = defaults.array(forKey: "namesArray") {
                    namesArray.append(String(freeArray[0]))
                    defaults.set(namesArray, forKey: "namesArray")
                    print("exist")
                    print(namesArray)
                } else {
                    let newNamesArray = [String(freeArray[0])]
                    defaults.set(newNamesArray, forKey: "namesArray")
                    print(newNamesArray)
                }
                var newUserFrees: [Bool] = Array(repeating: false, count: 64)
                //freeArray.remove(at: 0)
                for num in freeArray {
                    if let n = Int(num) {
                        newUserFrees[n] = true
                    }
                }
                print(newUserFrees)
                if let all = defaults.array(forKey:
                    "all") {
                    var allFriends = all as! [[Bool]]
                    allFriends.append(newUserFrees)
                    defaults.set(allFriends, forKey: "all")
                    print(allFriends)
                } else {
                    defaults.set([newUserFrees], forKey: "all")
                    print([newUserFrees])
                    print("creating a new one")
                }
                let alertController = UIAlertController(title: "Done", message: "You have successfully added \(freeArray[0]), who has \(counter) frees in a cycle", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController,animated: true, completion: nil)
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
    
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: messageLabel)
            //view.bringSubview(toFront: closeButton)
            
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QRcode is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                let a = metadataObj.stringValue
                messageLabel.text = a!
                tryToWrite(text: a!)
                
            }
        }
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


