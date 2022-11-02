# Swift-Helpers
#1-ImagePickerHelper:
    Hot to use
    
    In you UIViewController, create a var of ImagePickerHlper
    
class Test:UIViewController{
    var imagePickerHelper:ImagePickerHelper?
    override func viewDidLoad() {
        //delegate refers to classes confirming to ImagePickerHelperDelegate protocol
        //pickerViewController is referance to self(this class "Test" in our example)
        self.imagePickerHelper = ImagePickerHelper(delegate: self, pickerViewController: self)
    }
}
extension Test:ImagePickerHelperDelegate{
    func didFinishPickingImage(selectedImage: UIImage) {
        //You got the image after user select it
    }
    func cameraNotAvailable() {
        //Here, you may inform user his camera is not avaliable for whatever reson
    }
}
