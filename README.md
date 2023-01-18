# iOS

## Requisitos

- Versão do sistema operacional iOS: 12.4 ou superior.
- Versão do projeto Swift 4+: funciona com Xcode anterior ao 13.

### Instalação do Pacote

CocoaPods
Para adicionar o SDK ao seu projeto utilizando Cocoapods basta adicionar o seguinte comando ao seu Podfile:

Instalação em ambiente de desenvolvimento e testes

### Instalação em ambiente de desenvolvimento e testes

```ruby
platform :ios, '12.4'

use_frameworks!
target 'NOME_DO_SEU_PROJETO' do
    pod 'CSLivenessSDK', :git => 'URL DO REPOSITÓRIO ENVIADO PELA CLEAR SALE', :tag => '0.0.8-hml'
    pod 'CSLivenessSDKTec', :git => 'URL DO REPOSITÓRIO ENVIADO PELA CLEAR SALE', :tag => '0.0.5'
    pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '7.15.0'
    pod 'Amplitude', '~> 8.10.2'
end


```

### Instalação em ambiente de produção

```ruby
platform :ios, '12.4'

use_frameworks!
target 'NOME_DO_SEU_PROJETO' do
    pod 'CSLivenessSDK', :git => 'URL DO REPOSITÓRIO ENVIADO PELA CLEAR SALE', :tag => '0.0.8'
    pod 'CSLivenessSDKTec', :git => 'URL DO REPOSITÓRIO ENVIADO PELA CLEAR SALE', :tag => '0.0.5'
    pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '7.15.0'
    pod 'Amplitude', '~> 8.10.2'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    # Adicionar
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
    end
    flutter_additional_ios_build_settings(target)
  end
end
```
## Configuração

Instruções para configuração do framework no projeto:

- Adicionar as seguintes entradas ao arquivo Info.plist do projeto de destino:

```
<key>NSCameraUsageDescription</key>
<string>This app requires access to the camera.</string>
```

> Após confifurações executar `pod install`

## Configuração

Para iniciar o Framework importe o SDK em seu código 

```swift
import CSLivenessSDK
```

Extenda o Delegate para capturar os resultados do Framework

```swift
// MARK: - Clearsale liveness Delegate

extension ViewController: CSLivenessDelegate {
    func liveness(didOpen: Bool) {
        print(didOpen)
    }
    
    func liveness(error: CSLivenessError) {
        print(error)
        print("*********** \(error.rawValue) ***********")
        force(portrait: false)
    }
    
    func liveness(success: CSLivenessResult) {
        print(success)
        print("*********** \(success) ***********")
        force(portrait: false)
    }

    func force(portrait: Bool)  {
        DispatchQueue.main.async {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,forKey: "orientation")
        }
    }
}
```

E realize a chamada do Framework.

```swift
    @IBAction func didTapButton(_ sender: Any) {
        force(portrait: true)
        DispatchQueue.main.async {
            self.livenessSdk = CSLiveness(
                configurations: CSLivenessConfigurations(
                    clientId: "SEU CLIENT ID AQUI",
                    clientSecret: "SEU SECRET ID AQUI"
                )
            )
            
            self.livenessSdk?.delegate = self
            self.livenessSdk?.start(viewController: self, animated: true)
        }
    }
```
