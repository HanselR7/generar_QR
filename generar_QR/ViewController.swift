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
    
    @IBAction func enviar_QR(_ sender: Any) {
        DispatchQueue.main.async {
            do {
                let imagen_enviar = self.imgQR.image
                if let imagen_data = imagen_enviar?.jpegData(compressionQuality: 0.9) {
                    let objetos_compartir = [imagen_data]
                    let ventana = UIActivityViewController(activityItems: objetos_compartir, applicationActivities: nil)
                    if self.presentedViewController == nil {
                        self.present(ventana, animated: true, completion: nil)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                        self.present(ventana, animated: true, completion: nil)
                    }
                }
            } catch {
                print("Error")
            }
        }
    }
}

