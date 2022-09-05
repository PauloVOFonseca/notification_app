# notification_app

Para o desenvolvimento do caso foi utilizado o package Flutter Local Notifications: https://pub.dev/packages/flutter_local_notifications. Mas também poderia ser utilizado o package Awesome Notifications: https://pub.dev/packages/awesome_notifications, que tem como vantagem configurar botões na notificação.

Nele foi necessário configurar o AndroidManifest.xml, inserindo dentro da tag de activity o seguinte código: 

    android:showWhenLocked="true"
    android:turnScreenOn="true"

Para IOS, é necessário configurar o AppDelegate.m/AppDelegate.swift, inserindo ao método didFinishLaunchingWithOptions o seguinte código:

    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

O package deve ter suas configurações inicializadas, tanto para android como para IOS:

    void initialize() {
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        const android = AndroidInitializationSettings('@mipmap/ic_launcher');
        const iOS = IOSInitializationSettings();
        const initSettings = InitializationSettings(android: android, iOS: iOS);

        flutterLocalNotificationsPlugin.initialize(initSettings,
            onSelectNotification: onSelectNotification);
  }

O @mipmap/ic_launcher simboliza o ícone que será exibido nas notificações, ele pode ser alterado nas pastas de mipmap em:

notification_app\android\app\src\main\res\

# Notificação simples (ícone, imagem de miniatura e título)

Para essa notificação foi necessário apenas fazer a chamada do largeIcon usando o encode Base64, como pode ser observado no arquivo show_notification.dart

# Notificação com navegação
Por padrão, ao clicar na notificação, o app é aberto, mas é possível alterar esta funcionalidade utilizando a função onSelecNotification, durante a inicialização do projeto. Para isso, foi inserida uma função, que detecta o clique na notificação:

  Future<dynamic> onSelectNotification(payload) async {
    if (payload != null) {
      NavigationService.instance.navigationKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const AnotherPage()),
      );
    }
  }

Ela é capaz de receber uma variável dinâmica, podendo conter informações da rota que o usuário será redirecionado.

# Notificação agendada
Para a implementação da notificação agenda, é necessário utilizar o package Timezone: https://pub.dev/packages/timezone. Ele deve ser inicializado no main.dart, recebendo a localização padrão a ser utilizada.
 
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("America/Bahia"));

Também é necessário fazer a passagem do tempo em que a notificação será chamada, nesse caso foi agendada para 20 segundos no futuro:

    TZDateTime.now(local).add(const Duration(seconds: 20))

Na função de exibição de notificação, deve ser chamada a função zonedSchedule, capaz de receber o tempo acima e o código requerido a seguir:

      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,

# Notificação fixa
A notificação fixa foi feita fazendo a passagem do true na variável ongoing (show_notification.dart). Criando uma notificação permanente na barra do celular.