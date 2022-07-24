//
//  ReportFormViewController.swift
//  MeuBairroApp
//
//  Created by pedohn13@gmail.com on 7/24/22.
//

import UIKit

class ReportFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textViewDetail: UITextView!
    @IBOutlet weak var imageViewReport: UIImageView!
    
    var report : Report?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewDetail.layer.borderWidth = 0.2
        textViewDetail.layer.cornerRadius = 5
        textViewDetail.layer.borderColor = UIColor.gray.cgColor
        
        if let report = report {
            textFieldName.text = report.name
            textFieldLocation.text = report.location
            textViewDetail.text = report.detail
            if let image = report.image {
                imageViewReport.image = UIImage(data: image)
            }
            
        }
    }

    @IBAction func save(_ sender: Any) {
        if (report == nil) {
            report = Report(context: context)
            report?.date = Date()
        }
        report?.name = textFieldName.text
        report?.location = textFieldLocation.text
        report?.detail = textViewDetail.text
        report?.image = imageViewReport.image?.jpegData(compressionQuality: 0.9)
        try? context.save()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func loadImage(_ sender: Any) {
        let alert = UIAlertController(title: "Carregar Imagem", message: "De onde você deseja carregar a imagem?", preferredStyle: .actionSheet)
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            alert.addAction(UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            })
        }
        alert.addAction(UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(UIAlertAction(title: "Álbum de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert,animated: true)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

extension ReportFormViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewReport.image = image
        }
        
        dismiss(animated: true)
    }
}
