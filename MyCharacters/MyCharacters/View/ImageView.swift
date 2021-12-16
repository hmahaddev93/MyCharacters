//
//  ImageView.swift
//  
//
//  Created by Khatib H. on 5/7/21.
//

import SwiftUI
import Combine

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(url:URL) {
        if imageCache.object(forKey: url.absoluteString as AnyObject) == nil {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    imageCache.setObject(data as AnyObject, forKey: url.absoluteString as AnyObject)
                    self.data = data
                }
            }
            task.resume()
        }
    }
}

let screenWidth = UIScreen.main.bounds.width
struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = .placerholder
    private var width:CGFloat?
    private var height:CGFloat?
    private var url: URL

    init(url:URL, width:CGFloat? = nil, height:CGFloat? = nil) {
        self.width = width
        self.height = height
        self.url = url
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .if(self.width != nil &&
                self.height != nil)
                { $0.frame(width: self.width, height: self.height) }
            .aspectRatio(contentMode: .fit)
            .onAppear(perform: {
                if let dataFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? Data {
                    self.image = UIImage(data: dataFromCache) ?? UIImage(systemName: "photo")!
                }
            })
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? .placerholder
            }
    }
}

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

extension UIImage {
    static let placerholder = UIImage(systemName: "photo")!.withRenderingMode(.alwaysTemplate)
}
