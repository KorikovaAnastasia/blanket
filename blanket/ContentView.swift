import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var authService = AuthService()

    var body: some View {
        NavigationView {
            ZStack {
                // Заголовочное изображение
                Image("headerImage") 
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                    .clipped()
                    .scaleEffect(2)
                    .offset(x: -200, y: -350)

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text("У вас есть аккаунт?")
                            .font(.headline) // Уменьшаем размер шрифта
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading) // Выравнивание по левому краю
                            .padding(.top, 20)

                        TextField("Почта", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity) // Выравнивание по ширине
                            .padding(.horizontal)

                        SecureField("Пароль", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity) // Выравнивание по ширине
                            .padding(.horizontal)

                        Button(action: {
                            login()
                        }) {
                            Text("Войти")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 53/255, green: 85/255, blue: 212/255)) // RGBA(53, 85, 212, 1)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: RegisterView()) {
                            Text("Зарегистрироваться")
                                .foregroundColor(Color(red: 53/255, green: 85/255, blue: 212/255)) // Цвет текста как на кнопке "Войти"
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 235/255, green: 238/255, blue: 255/255)) // RGBA(235, 238, 255, 1)
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.bottom, 20) // Отступ снизу
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Информация"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func login() {
        let user = LoginUser(email: email, password: password)
        authService.login(user: user) { result in
            switch result {
            case .success(let authResponse):
                alertMessage = "Вход выполнен успешно. Токен: \(authResponse.access_token)"
                showAlert = true
            case .failure(let error):
                alertMessage = "Ошибка входа: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

// Пример экрана регистрации
struct RegisterView: View {
    @State private var name = ""
    @State private var birthdate = ""
    @State private var gender = ""
    @State private var city = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var authService = AuthService()

    var body: some View {
        VStack(spacing: 20) {
            Text("Создать новый аккаунт")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)

            TextField("Имя", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity) // Выравнивание по ширине
                .padding(.horizontal)

            TextField("Дата рождения", text: $birthdate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity) // Выравнивание по ширине
                .padding(.horizontal)

            TextField("Пол", text: $gender)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity) // Выравнивание по ширине
                .padding(.horizontal)

            TextField("Город", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity) // Выравнивание по ширине
                .padding(.horizontal)

            TextField("Почта", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity) // Выравнивание по ширине
                .padding(.horizontal)

            SecureField("Пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity) // Выравнивание по ширине
                .padding(.horizontal)

            Button(action: {
                register()
            }) {
                Text("Зарегистрироваться")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer() // Пустое пространство для выравнивания
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Информация"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func register() {
        let user = User(name: name, birthdate: birthdate, gender: gender, city: city, email: email, password: password)
        authService.register(user: user) { result in
            switch result {
            case .success(let message):
                alertMessage = message
                showAlert = true
            case .failure(let error):
                alertMessage = "Ошибка регистрации: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

// Пример использования
struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
