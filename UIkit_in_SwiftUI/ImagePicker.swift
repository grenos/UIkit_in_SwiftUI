//
//  ImagePicker.swift
//  UIkit_in_SwiftUI
//
//  Created by Vasileios Gkreen on 29/02/2020.
//  Copyright © 2020 Vasileios Gkreen. All rights reserved.
//

import SwiftUI
import Combine

class ImagePicker: ObservableObject {
    
    //Singleton to make sure we always have only one instance of ImagePicker class
    static let shared: ImagePicker = ImagePicker()
    private init() {}
    
    let view = ImagePicker.View()
    let coordinator = ImagePicker.Coordinator()
    
    
    // to automatically update the UI
    let willChange = PassthroughSubject<Image?, Never>()
    
    @Published var image: Image? = nil {
        didSet {
            if image != nil {
                willChange.send(image)
            }
        }
    }
    
}




extension ImagePicker {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        //on cancel
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        //on completion
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //get selected image
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            //set image to didSet and then ---> to passThroughObject
            ImagePicker.shared.image = Image(uiImage: image)
            
            //dismiss automatically after completion
            picker.dismiss(animated: true)
        }
        
    }
}


extension ImagePicker {

    struct View : UIViewControllerRepresentable {
        
        //get the corrdinator instance from the ImagePicker class
        func makeCoordinator() -> Coordinator {
            return ImagePicker.shared.coordinator
        }
        
        // create a UI View Controller programatically
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker.View>) -> UIImagePickerController {
            
            //init the controller
            let imagePickerController = UIImagePickerController()
            
            //set fot use by setting the delgate
            imagePickerController.delegate = context.coordinator
            
            //return the controller
            return imagePickerController
            
        }
        
        
        //update VC -- NOT NEEDED HERE -- it is required from the UIViewControllerRepresentable
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker.View>) {
            
        }
        
    }
}
