//
//  FirebaseImageView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import SwiftUI
import Combine
import FirebaseStorage
import UIKit

struct FirebaseImageView: View {
    @ObservedObject var imageLoader: FirebaseImageLoader

    init(path: String) {
        imageLoader = FirebaseImageLoader(path: path)
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
        }
    }
}

class FirebaseImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let path: String

    private var task: StorageDownloadTask?

    init(path: String) {
        self.path = path
        downloadImage()
    }

    private func downloadImage() {
        let ref = Storage.storage().reference(withPath: path)
        task = ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            }
        }

        task?.observe(.progress) { snapshot in
            // Handle progress updates
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print("Download progress: \(percentComplete)%")
        }

        task?.observe(.success) { snapshot in
            // Handle successful completion
            print("Download completed")
        }

        task?.observe(.failure) { snapshot in
            // Handle failure
            if let error = snapshot.error {
                print("Download failed: \(error.localizedDescription)")
            }
        }
    }
}
