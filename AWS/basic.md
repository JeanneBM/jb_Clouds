# AWS Podstawowe Usługi

## Sieć
- **VPC (Virtual Private Cloud)**: Pozwala na tworzenie izolowanych sieci w chmurze AWS. Umożliwia definiowanie zakresów IP, podsieci, tabel routingu i bram sieciowych.
- **API Gateway**: Usługa do tworzenia, publikowania, utrzymywania, monitorowania i zabezpieczania API na dowolną skalę.
- **Route 53**: Usługa DNS w chmurze, która zapewnia niezawodne i skalowalne rozwiązywanie nazw domenowych.

## Bezpieczeństwo
- **IAM (Identity and Access Management)**: Umożliwia zarządzanie dostępem do usług i zasobów AWS w sposób bezpieczny. Definiuje użytkowników, grupy, role i polityki dostępu.

## Magazynowanie i systemy plików
- **S3 (Simple Storage Service)**: Skalowalna usługa przechowywania obiektów, idealna do przechowywania i pobierania dowolnych ilości danych z dowolnego miejsca.
- **EBS (Elastic Block Store)**: Usługa zapewniająca blokowe wolumeny do użytku z instancjami EC2.
- **EFS (Elastic File System)**: Skalowalna usługa plików do użytku z instancjami EC2, obsługująca wiele instancji jednocześnie.
- **FSx**: Usługa zapewniająca w pełni zarządzane systemy plików kompatybilne z Windows File Server i Lustre.

## Zarządzanie, monitorowanie i nadzór
- **CloudWatch**: Usługa do monitorowania zasobów i aplikacji w chmurze. Zbiera i śledzi metryki, zbiera i monitoruje pliki dzienników, ustawia alarmy.
- **EventBridge**: Usługa do tworzenia zdarzeń i reakcji na nie w czasie rzeczywistym. Umożliwia integrację z różnymi usługami AWS i zewnętrznymi.
- **Auto Scaling**: Automatycznie dostosowuje pojemność instancji EC2 w celu zapewnienia wydajności i optymalizacji kosztów.
- **Secrets Manager**: Usługa do bezpiecznego przechowywania, zarządzania i pobierania poufnych informacji, takich jak hasła i klucze API.

## Bazy danych
- **RDS (Relational Database Service)**: Usługa zarządzająca relacyjnymi bazami danych, takimi jak MySQL, PostgreSQL, Oracle, SQL Server i MariaDB. Automatyzuje zadania administracyjne, takie jak tworzenie kopii zapasowych, łatanie oprogramowania i skalowanie.

## Kontenery
- **ECS (Elastic Container Service)**: Usługa do uruchamiania i zarządzania kontenerami Docker na skalowalnej infrastrukturze.
- **Fargate**: Silnik obliczeniowy dla ECS, który umożliwia uruchamianie kontenerów bez zarządzania serwerami. Automatycznie zarządza infrastrukturą.
