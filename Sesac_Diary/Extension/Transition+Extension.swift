//
//  Transition+Extension.swift
//  Sesac_Diary
//
//  Created by HeecheolYoon on 2022/08/24.
//

import Foundation
import UIKit

extension UIViewController {
    enum TransitionStyle {
        
        case present
        case presentNavigation
        case presentFullNavigation
        case push
        case dismiss
        case pop
        
    }

    func transition<T: UIViewController> (_ viewController: T, transitionSytle: TransitionStyle = .present) {
        switch transitionSytle {
        case .present:
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .dismiss:
            self.dismiss(animated: true)
        case .pop:
            self.navigationController?.popViewController(animated: true)
        }
    }
}

