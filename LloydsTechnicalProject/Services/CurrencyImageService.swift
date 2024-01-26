//
//  CurrencyImageService.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation
import SwiftUI
import Combine

protocol CurrencyImageServiceProtocol {
    func downloadImage(url:URL, completionHandler: @escaping (Result<UIImage,NetworkingError>) -> ())
    func getCurrencyImage(currency:Currency)
}

class CurrencyImageService: CurrencyImageServiceProtocol  {

    @Published var image:UIImage?
    private let filemanager = LocalFileManager.instance
    private let folderName = "currency_images"

       func getCurrencyImage(currency:Currency){
         if let savedImage = filemanager.getImage(imageName:currency.id, folderName: folderName) {
            image = savedImage
        } else {
            guard let url = URL(string: currency.image) else {
                return
            }
            downloadImage(url: url) {[weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    guard let folderName = self?.folderName else { return }
                    self?.filemanager.saveImage(image: image, fileImageName: currency.id, folderName: folderName)
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    
    func downloadImage(url:URL, completionHandler: @escaping (Result<UIImage,NetworkingError>) -> ()) {
        URLSession.shared.dataTask(with: url) {  data, response, error in
            guard let data = data,
                  error == nil,
                  let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(.failure(NetworkingError.badURLResponse(url: url)))
                return
            }
            completionHandler(.success(image))
        }.resume()
    }
}
