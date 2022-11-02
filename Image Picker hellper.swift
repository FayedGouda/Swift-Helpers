import Foundation
import UIKit

protocol ImagePickerHelperDelegate : AnyObject {
    func didFinishPickingImage(selectedImage : UIImage)
    func cameraNotAvailable()
}

class ImagePickerHelper : NSObject {
    
    private let imagePicker =  UIImagePickerController()
    private weak var pickerViewController : UIViewController!
    private weak var delegate : ImagePickerHelperDelegate!
    
    init(delegate : ImagePickerHelperDelegate , pickerViewController : UIViewController) {
        super.init()
        imagePicker.delegate = self
        self.delegate = delegate
        self.pickerViewController = pickerViewController
    }
    
    func selectPhtoFromGalary() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        pickerViewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func takePhotoUsingCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            pickerViewController.present(imagePicker,animated: true,completion: nil)
        } else {
            delegate.cameraNotAvailable()
        }
    }
}

extension ImagePickerHelper:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     imagePicker.dismiss(animated: true, completion: nil)

     if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
         delegate.didFinishPickingImage(selectedImage: img)
     }
     else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
         delegate.didFinishPickingImage(selectedImage: img)
     }
   }
}
