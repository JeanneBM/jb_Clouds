**Wdrożenie**
- Pobranie pakietu Tomcat z oficjalnej strony Apache.
- Rozpakowanie archiwum w wybranej lokalizacji.
- Sprawdzenie zgodności serwera z wersjami JDK i API przed instalacją.

**Pierwsze uruchomienie**
- Startowanie serwera: `bin/startup.sh` (Linux/macOS) lub `bin/startup.bat` (Windows).
- Zatrzymywanie serwera: `bin/shutdown.sh` (Linux/macOS) lub `bin/shutdown.bat` (Windows).
- Podgląd bieżących logów: `tail -f logs/catalina.out`.

**Wykorzystanie skryptu catalina.sh**
- Uruchamianie: `catalina.sh start`
- Zatrzymywanie: `catalina.sh stop`
- Restartowanie: `catalina.sh restart`
- Sprawdzenie wersji: `catalina.sh version`

**Instalacja Oracle JDK**
- Pobranie najnowszej wersji JDK.
- Instalacja zgodnie z instrukcją dla danego systemu operacyjnego.
- Ustawienie JAVA_HOME i PATH:
 
  ```
  export JAVA_HOME=/path/to/jdk
  export PATH=$JAVA_HOME/bin:$PATH
  ```

**Logowanie**
- Uruchamianie serwera z przekierowaniem logów do pliku: `catalina.sh run > logs/tomcat.log 2>&1`.
- Uruchamianie serwera z przekierowaniem logów na konsolę: `catalina.sh run`.

**Opcje uruchomieniowe**
- JAVA_OPTS: ustawienia JVM.
- CATALINA_OPTS: opcje specyficzne dla Tomcata.
- Parametry XMS, XMX i XX:MaxPermSize do zarządzania pamięcią JVM.
- CATALINA_OUT: główny plik logów Tomcata.
- CATALINA_TMPDIR: katalog tymczasowy dla Tomcata.

**Automatyczne uruchamianie Tomcata**
- Dodanie skryptu startowego do `systemd` lub `init.d`.
- Konfiguracja dostępu do konsoli Web przez sieć.

**Zmiana portu nasłuchu**
- Edycja pliku `conf/server.xml`, zmiana atrybutu `port` w elemencie `<Connector>`.

**Tomcat Manager**
- Dostęp do panelu zarządzania: `http://localhost:8080/manager`.
- Konfiguracja uprawnień w pliku `conf/tomcat-users.xml`.
- Wdrażanie aplikacji poprzez Managera lub kopiowanie plików WAR do `webapps/`.

**Wdrażanie aplikacji**
- Wdrażanie pliku WAR z Tomcat Managera.
- Automatyczne rozpakowywanie archiwum WAR.
- Wdrażanie bez Tomcat Managera poprzez umieszczenie pliku WAR w katalogu `webapps/`.
- Zmiana adresu aplikacji poprzez konfigurację w `server.xml`.

**Zarządzanie aplikacjami**
- Zatrzymywanie i startowanie aplikacji przez Tomcat Managera.
- Sprawdzanie sesji aplikacji i ich rozłączanie.

**Konsola tekstowa i skrypty**
- Lista wdrożonych aplikacji: `catalina.sh list`
- Przeładowanie aplikacji: `catalina.sh reload [app_name]`
- Sprawdzanie statusu serwera: `catalina.sh status`

**Struktura katalogów serwera**
- `bin/` - skrypty uruchomieniowe.
- `conf/` - pliki konfiguracyjne.
- `logs/` - logi serwera.
- `webapps/` - wdrożone aplikacje.
- `work/` - katalog tymczasowy.
- `temp/` - pliki tymczasowe.

**Pliki konfiguracyjne**
- `server.xml` - główna konfiguracja serwera.
- `web.xml` - domyślne ustawienia aplikacji.
- `context.xml` - konfiguracja aplikacji.

**Debugowanie i logi**
- `catalina.out` - główny plik logów.
- `catalina.yyyy-mm-dd.txt` - dzienne logi serwera.
- `localhost_access.log` - logi dostępu.
- `manager.yyyy-mm-dd.txt` - logi Tomcat Managera.
- Szukanie przyczyn problemów poprzez analizę logów i testy konfiguracyjne.

