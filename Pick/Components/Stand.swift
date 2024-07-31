//
//  Stand.swift
//  Pick
//
//  Created by Om Preetham Bandi on 7/30/24.
//

import SwiftUI

struct Stand: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 1000, height: 5)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    Stand()
}
