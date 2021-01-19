//
//  GrowthViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 18/01/21.
//

import Foundation
import Combine
import Foundation

final class GrowthViewModel: ObservableObject {
    let date1 = DateComponents(calendar: .current, year: 2014, month: 11, day: 28, hour: 5, minute: 9).date!
    let date2 = DateComponents(calendar: .current, year: 2015, month: 8, day: 28, hour: 5, minute: 9).date!

}
