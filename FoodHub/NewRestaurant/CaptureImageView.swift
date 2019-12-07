//
//  CaptureImageView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/12/4.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct CaptureImageView {
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
