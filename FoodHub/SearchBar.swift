//
//  SearchBar.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/20.
//  Copyright © 2019 JeffRen. All rights reserved.

//  在子视图中改变父视图中的属性，需要做三件事
//  1. 子视图使用 Binding
//  2. 父视图使用 State
//  3. 父视图调用子视图时，在传入参数前加 $
//  State 作用：在属性改变时，重新渲染视图

//  解决预览崩溃：.constant()

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var showCancelButton: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                self.showCancelButton = true
            }, onCommit: {
                print("onCommit")
            }).foregroundColor(.primary)
            
            Button(action: {
                self.searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
            }
            
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBar(searchText: .constant(""), showCancelButton: .constant(false))
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
