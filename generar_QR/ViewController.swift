import UIKit

class ViewController: UIViewController {
    //Variables de interfaz
    @IBOutlet weak var imgQR: UIImageView!
    
    //Variables de trabajo
    var mensaje = "Hola como estas?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgQR.image = genera_qr(texto: mensaje)
    }

    func genera_qr(texto: String) -> UIImage? {
        let data = texto.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "InputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            if let salida = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: salida)
            }
        }
        return nil
    }
    
}

