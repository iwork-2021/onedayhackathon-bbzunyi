//
//  ViewController.swift
//  Album
//
//  Created by bb on 2021/12/21.
//

import UIKit
import CoreML
import CoreMedia
import Vision

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var resultsLabel: UILabel!

    
    
    var firstTime:Bool = true
    lazy var classificationRequest: VNCoreMLRequest = {
          do{
              let classifier = try snacks(configuration: MLModelConfiguration())
              let model = try VNCoreMLModel(for: classifier.model)
              let request = VNCoreMLRequest(model: model, completionHandler: {
                  [weak self] request,error in
                  self?.processObservations(for: request, error: error)
              })
              request.imageCropAndScaleOption = .centerCrop
              return request
              
              
          } catch {
              fatalError("Failed to create request")
          }
      }()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      //cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
      resultsView.alpha = 0
      //resultsLabel.text = "choose or take a photo"
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      // Show the "choose or take a photo" hint when the app is opened.
      if firstTime {
        showResultsView(delay: 0.5)
        firstTime = false
      }
    }
    
    @IBAction func takePicture() {
      presentPhotoPicker(sourceType: .camera)
    }

    @IBAction func choosePhoto() {
      presentPhotoPicker(sourceType: .photoLibrary)
    }

    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = sourceType
      present(picker, animated: true)
      hideResultsView()
    }

    func showResultsView(delay: TimeInterval = 0.1) {
      view.layoutIfNeeded()
      UIView.animate(withDuration: 0.5,
                     delay: delay,
                     usingSpringWithDamping: 0.6,
                     initialSpringVelocity: 0.6,
                     options: .beginFromCurrentState,
                     animations: {
        self.resultsView.alpha = 1
        self.view.layoutIfNeeded()
      },
      completion: nil)
    }

    func hideResultsView() {
      UIView.animate(withDuration: 0.3) {
        self.resultsView.alpha = 0
      }
    }

    func classify(image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
              let handler = VNImageRequestHandler(cgImage: image.cgImage!)
              do {
                  try handler.perform([self.classificationRequest])
              } catch {
                  print("Failed to perform classification: \(error)")
              }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ViewController {
    func processObservations(for request: VNRequest, error: Error?) {
        if let results = request.results as? [VNClassificationObservation] {
            if results.isEmpty {
                self.resultsLabel.text = "Nothing found"
            } else {
                let result = results[0].identifier
                let confidence = results[0].confidence
                DispatchQueue.main.async {
                    if confidence > 0.8{
                        self.resultsLabel.text = result + String(format: "   %.1f%%", confidence * 100)
                    }else{
                        self.resultsLabel.text = "I'm not sure."
                    }
                    self.showResultsView()
                }
                print(result)
            }
        } else if let error = error {
            self.resultsLabel.text = "Error: \(error.localizedDescription)"
        } else {
            self.resultsLabel.text = "???"
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)

    let image = info[.originalImage] as! UIImage
    imageView.image = image

    classify(image: image)
  }
}
