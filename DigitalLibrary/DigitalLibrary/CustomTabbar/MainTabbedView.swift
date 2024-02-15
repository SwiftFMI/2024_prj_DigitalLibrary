//
//  MAinTabbedView.swift
//  DigitalLibrary
//
//  Created by Vasilka Terzieva on 27.01.24.
//

import SwiftUI

struct MainTabbedView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    private let authenticationProvider: AuthenticationProvidable
    private let userProvider: UserProvidable
    private let booksProvider: BooksProvidable

    @State var selectedTab = 0

    init(authenticationProvider: AuthenticationProvidable,
         userProvider: UserProvidable,
         booksProvider: BooksProvidable,
         selectedTab: Int = 0) {
        self.authenticationProvider = authenticationProvider
        self.userProvider = userProvider
        self.booksProvider = booksProvider
        self.selectedTab = selectedTab

        guard let id = authenticationProvider.getCurrentUserID() else { return }
        userProvider.setUserID(id)
    }

    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                LibraryView(booksProvider: BooksRepository())
                    .tag(0)

                MyBooksView()
                    .tag(1)

                StatisticsView()
                    .tag(2)

                ProfileView()
                    .tag(3)
            }

            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            customTabItem(imageName: item.iconName,
                                          title: item.title,
                                          isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.purple.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}

extension MainTabbedView{
    func customTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .purple.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}

struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView(authenticationProvider: AuthenticationRepositoryMock(),
                       userProvider: UserRepositoryMock(),
                       booksProvider: BooksRepositoryMock())
    }
}
