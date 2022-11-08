//
//  InputDialogModifier.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/7.
//

//import Foundation
//import SwiftUI
//
//struct InputDialogModifier: ViewModifier {
//    
//    @Binding var isPresented:Bool
//    
//    @Binding var isLike:Bool
//    
//    var action: (_: String)-> Void
//    
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//            if (isPresented) {
//                InputDialogView(isPresented: $isPresented,isLike: $isLike, action: { item in action(item)
//                })
//                .zIndex(1000)
//            }
//        }
//    }
//}
//
//extension View {
//    func inputDialog(isPresented: Binding<Bool>,isLike: Binding<Bool>, action: @escaping (_ input: String )->Void) -> some View {
//        ModifiedContent(content: self, modifier: InputDialogModifier(isPresented: isPresented, isLike: isLike, action: action))
//    }
//}
