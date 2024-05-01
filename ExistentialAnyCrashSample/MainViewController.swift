//
//  MainViewController.swift
//  ExistentialAnyCrashSample
//
//  Created by 홍경표 on 5/1/24.
//

import UIKit

final class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let crashItem = CrashItem(id: "CrashItem")
        let crashWrapper = CrashWrapper(item: crashItem)

        // print(crashWrapper.item)
        // >> This makes compile error
        // with "Runtime support for parameterized protocol types is only available in iOS 16.0.0 or newer" message.

        // ⚠️ This makes no compile error.
        // But makes runtime crash in iOS 15.x and below.
        switch crashWrapper.item {
        case let crashItem as CrashItem:
            print(crashWrapper, crashItem)
        default:
            print(crashWrapper)
        }

        let solutionItem = SolutionItem(id: "SolutionItem")
        let solutionWrapper = SolutionWrapper(item: solutionItem)
        switch solutionWrapper.item {
        case let solutionItem as SolutionItem:
            print(solutionWrapper,solutionItem)
        default:
            print(solutionWrapper)
        }
    }
}

// MARK: - Crash Code
struct CrashWrapper {
    let item: any Identifiable<String>
}

struct CrashItem: Identifiable {
    let id: String
}

// MARK: - Solution
protocol StringIdentifiable {
    var id: String { get }
}

struct SolutionWrapper: Identifiable {
    let item: StringIdentifiable
    var id: String { item.id }
}

struct SolutionItem: StringIdentifiable {
    let id: String
}
