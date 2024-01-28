//
//  ViewModel.swift
//  PiClean
//
//  Created by Reema Alfaleh on 11/07/1445 AH.
//

import UIKit

final class ViewModel: ObservableObject{
    @Published var selectedImage1: UIImage?
    @Published var selectedImage2: UIImage?
    @Published var classificationResult2: String?
    @Published var isShowingCleanAlert: Bool?
    @Published var isShowingUnCleanAlert: Bool?


}
