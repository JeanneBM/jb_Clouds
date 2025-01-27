ssh cloud_user@34.204.1.78

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ cat *
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30201
    hostPort: 30201
    listenAddress: "0.0.0.0"
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}
# terraform.tfvars

host                   = "DUMMY VALUE"
client_certificate     = "DUMMY VALUE"
client_key             = "DUMMY VALUE"
cluster_ca_certificate = "DUMMY VALUE"

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ kind create cluster --name lab-terraform-kubernetes --config kind-config.yaml
Creating cluster "lab-terraform-kubernetes" ...
 ✓ Ensuring node image (kindest/node:v1.21.1) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-lab-terraform-kubernetes"
You can now use your cluster with:

kubectl cluster-info --context kind-lab-terraform-kubernetes

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ kubectl cluster-info --context kind-lab-terraform-kubernetes
Kubernetes control plane is running at https://127.0.0.1:37987
CoreDNS is running at https://127.0.0.1:37987/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ kind get clusters
lab-terraform-kubernetes

kubectl config view --minify --flatten --context=kind-lab-terraform-kubernetes

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ kubectl config view --minify --flatten --context=kind-lab-terraform-kubernetes
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJMU1ERXlOekU1TWpJME1Wb1hEVE0xTURFeU5URTVNakkwTVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBUEJVCkpmdFZ0NFVDU1E4b0JXVXpSNjROOW13UXdTT01HbUZrcG9TMU95b2tLQWNoU2VKd2d3VjFQOGxTOUFIendZUkYKSjZHbHc2a25mejU5N1VkaUNLYm9XV2Z0MkxPZ0xSSzlWU0UxN1ozQTUxOEVTb1FvTy93c0NEZXdKNngxbEcxTApnOFNJWEd1SnJqaGx2dDlBVTdpcGs4UHR2SWo1QjYvMERaSVMyQ0x2WitqYllPMFcwT2NIb0xQdlgzcDhEZzZCClJFbDdOalA1NUZ4VWdmbDlLUFQvajhlcnZwZU1HYWhMUmNHL04xaTAvaXAyNG5OYWhYSzhRQklpbmZYa3BEOUYKbXoySHBuZDRxV2tlU2lSSEZMc2pNb3lHeDdiSnFUNnk4TFoveGVETEFmVFJDUXBRUkxxcHZlN3JBOUF6K1hEVQpaT3hCS0lEZE1ZaDB3eDkyZ1hjQ0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZDQUZ2Z3VyQVovMElML0JrYzRtK2lvd3ZkUkFNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFDYm1BSFhmZEgxeHJKbFBLTEtJbmdYWVBZT1lXbWdrL1Qva25EZ3Roc3ptNmJJZzkvYwp2KzhuQ0xLTnJVcWZsajZ3RHd6ZmQveTBWRjkzcmlaaG55OGg1Zkg2Y3VRSmlVUXEva1VxdURPcU9pL2NMZWpJCis5UHJ0c1NWWEhobzRudFRPSW1XL21ZSmpIYjVIMnBpc1RCNmxxVFJ2TUIrZTRYTUp4UW9KWmtwZ1AyV3RSSDUKOEY4eWgxcmp4akxVN1lEZmNzSXpkMnhnbW5tejFZWk1qMXcxZm40UnpHU0FKeTlBdjZ0OUlWb2dIb2wxdElOUgpNRGZUbGRSS3pRd0tjTmVTbDZKbi9POHN2Mm8xVzZpZXZvVkw4OTcyVUZJREhOYkZwREhDaGN3RzNxaEtRcDBWClNXSURZMTMwem8vNnVDbUordlVrbkRBb04rUVlNeDUxMjZwQwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://127.0.0.1:37987
  name: kind-lab-terraform-kubernetes
contexts:
- context:
    cluster: kind-lab-terraform-kubernetes
    user: kind-lab-terraform-kubernetes
  name: kind-lab-terraform-kubernetes
current-context: kind-lab-terraform-kubernetes
kind: Config
preferences: {}
users:
- name: kind-lab-terraform-kubernetes
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJWU5KeWY0dnlFdjB3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBeE1qY3hPVEl5TkRGYUZ3MHlOakF4TWpjeE9USXlORFJhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTd2S1U3MDd0SGhwTkVCU0IKRmJJYW45OUdhUi9MYWZXNUQ1OUVwbzQzY0F3VWhOVU1mZk1HczhLSjRaYnZLWjFsWis2NmFTZ2l6WDZYSk5saAo5ZzdzOFNGZDUrMHBYc0RTQXJxNW9yNmo2MjdjRHg0ODduaTVUbWc5bEdpcERyWmZHYWFpcmRVMVdXb2o2R3JlCnZjbVRkYUI4R2JRUmIwbnhDNkVzNUJTWS8wM0c5U0ZqcXNiSUFIWmoyZERHR2xuN014OEJZMjEyc29Yc2t4Z1oKWmtpVUprRTZjd1pPUExvdGRZZnovQWU5elhnRGxFRjJiK2pZN3JPTGVoOTdtK3l5b3ZMdG5saE5UWnlPd3VEMApyNWNrUG8raWtqUC9zQXZGTXVmUVRCUFYvMzR5UzhZWWxCME5vdVo3Tkx1bHQzVGJxOGhJMWxKUXJiYTFLU0JPCkJFMDkvUUlEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JRZ0JiNExxd0dmOUNDL3daSE9Kdm9xTUwzVQpRREFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBaGhYVFZnLzNOQU1TcVdRQkg4K25IZjNNU0o2QTRTRmowdHpsClF4UU9wd1RIOHV3Q2IvZ0wvZVVFRUlmZ0x2YXRSaGhHNlQ1N0Y4NEFvYkxYOUhDZnVGMEZZZTdTU0o4R3gyM24KTUFMc3YxRzJ3T0Z3SCt4bDRPamlXMjN6UFo2QkZRanZxd0ZKb0t2elU0SXNzWjh2c25neDhsSEYvSU9pR2pmTgpIcDVkYmpqOHZ6ZW5RR1paUDBsSVRic2w1d2gwZkFwNUtWUHJsb3hZMGhtVU9paGYvU09ObDlsRTd4YVVKeS9qCll6ZjlaV3BrZWoxVUdVN2JiLzBZcU9oNlRjUndIeW5rSy9YNWxCTVkrdE96bUV0ZzBXYXA4Y1RpLzV5SEUwZEsKek9LcUc1cXg2aHBIdEg2WG1XbHBsNzdLK2ZYQU1QWGkyVHlaZkZjcTVIT0RjcVRuMHc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBN3ZLVTcwN3RIaHBORUJTQkZiSWFuOTlHYVIvTGFmVzVENTlFcG80M2NBd1VoTlVNCmZmTUdzOEtKNFpidktaMWxaKzY2YVNnaXpYNlhKTmxoOWc3czhTRmQ1KzBwWHNEU0FycTVvcjZqNjI3Y0R4NDgKN25pNVRtZzlsR2lwRHJaZkdhYWlyZFUxV1dvajZHcmV2Y21UZGFCOEdiUVJiMG54QzZFczVCU1kvMDNHOVNGagpxc2JJQUhaajJkREdHbG43TXg4QlkyMTJzb1hza3hnWlpraVVKa0U2Y3daT1BMb3RkWWZ6L0FlOXpYZ0RsRUYyCmIralk3ck9MZWg5N20reXlvdkx0bmxoTlRaeU93dUQwcjVja1BvK2lralAvc0F2Rk11ZlFUQlBWLzM0eVM4WVkKbEIwTm91WjdOTHVsdDNUYnE4aEkxbEpRcmJhMUtTQk9CRTA5L1FJREFRQUJBb0lCQUUzZjg1ZzJ3ZUxRc1pMdgpDODcxVitZSXo1ck5TTzlFclVhaElxK2hwQUc1ZmlwNGdQUy9jc3k5TjFDMWIwYkJ6RjNlR1JUU2h0MHdSN1F6CndOQi90c3N6azdaVnZlanFzTWRBOGVWUGVuN3RoM3pKM3hQZGRvOU9POXVWYkp1bDVrS200MWdDSjd2M2NySjUKdWhSaWtOT0NOVS92TnN0dGJzamFnNVhsL0tNZnBkZlArbDlRVFBrbVZKQUtwb0wxY1YxYkJQVlVvcFlhN0lrMQptVnNqOXo5TklISXNpT29Ja2dIUE5jNENzSlNnMTQ1ZDR3RDJEOEhrTTRpTkhab01tN0JsTnFwaTNoSW5QbVVoCmV3dUEySHVKS0NXYklPclBTNjh6TVI4QXRZRHlIRmVielc1SDRGRW92Y3E5Ujg3MUdLdHVuUHRiNEtFRGVVeEMKN2VMWlo4RUNnWUVBOFUzTitES2lnWlJqNE1MN0RiYjA2c1FPelZvYzdyMW9vMnVaY0lvUWlxUGtGOXl4V1VjVwpXSXFGQlk3aGNad1piTkhONFd2NjNMRHlTZUdMMGRxOElyOUJydGI3T0xML2FranFBeW1QWE42Tmt0Zk9MT0t1CmIxRzVwa2dzR3dIcEhvYnFmT25ZVmFVQTRoTEVCTno1akE4a3hkZktNaEs4N2NJOURlZzNzQTBDZ1lFQS9ZQUsKRGNsWkVYREVXNGhHbXhhVWFsUCt5Tkk0dzhHenZyc3hBcCtVZWk2MlEwM2tLTmFhZnBUU0R3eG9kb0tYTi9OOQp2YzNaazhhRjJjR0RBMmVoaEc1ZzhPemNMcHpIaW5nZXppMmpWdjVndWpPdE1QbEEwKzBQUE10WTUza2lZajN2Ck4wdi9oK0daSklzT1ZaMzZ5RGRudGU3dG5SUVp5ZVhvZklINFdiRUNnWUF5dHhXSkNxdFk3S1VwUWhHZHlrd2oKWTExeEQzVnhQK0hVSnZNeTBmRzBFY29Jc2R1Y1ZmSitYVzZqd21uamhObGJJNlZQc1hBaUhoWnVMTGRFUGVLNApzdFhOTjJYSmZ1VnJvek43d3FwYzdIRjQ0VjUxMUphdzBzNWdBbDh5dGU0VyttZ2lKTXZSQkVMeFFOeHQ0VHVaCmtqMDZUNll4YS9yRlJjT3JQcGtscVFLQmdRQ3ZDVzNudnhPbEd6dzZCNHJaSTJvdlVQZ29LaC9QNnp2MWdzT0EKa0RleGRmZWIyWGlsU2lrN0pmODFMTmdrbkY5VjN1Yi8yOWRVVmt1dDVCUldrWVBSTVhYMlpWWlRTU1h1MHFwUwpxdWlSOU90TkpzbDdlMS9yOVZBRUpsU28zOWVDQmtuYTRMcjhWQ1d1T2VZWDhCRnRsZlFpaDJ2Q2ZsS2dPZ09oCmxReXF3UUtCZ0NRSEtQWVlnWmllMTNtT2EyT01ldjZOZmh4L082Q2Z4S2RWaTFPWmtiMXFkM3hjS1BRdmhGZFkKWGdDZUNCSWF3cmN6TE1KdGRiSXJ3WUF3ZWZZTkRQaFF3MGF4NldoSVhpa0dGWXlBLzMrbTRpYlVhK1orNlkvKwp5MVo0MW9vY2Z4T1F3WlR3SkM0cmxOVnRpMWxYUzRLRVFLblZoVE1XaGZlSlUzeU1IdjhCCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==

# terraform.tfvars

host                   = "https://127.0.0.1:37987"
client_certificate     = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJWU5KeWY0dnlFdjB3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBeE1qY3hPVEl5TkRGYUZ3MHlOakF4TWpjeE9USXlORFJhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTd2S1U3MDd0SGhwTkVCU0IKRmJJYW45OUdhUi9MYWZXNUQ1OUVwbzQzY0F3VWhOVU1mZk1HczhLSjRaYnZLWjFsWis2NmFTZ2l6WDZYSk5saAo5ZzdzOFNGZDUrMHBYc0RTQXJxNW9yNmo2MjdjRHg0ODduaTVUbWc5bEdpcERyWmZHYWFpcmRVMVdXb2o2R3JlCnZjbVRkYUI4R2JRUmIwbnhDNkVzNUJTWS8wM0c5U0ZqcXNiSUFIWmoyZERHR2xuN014OEJZMjEyc29Yc2t4Z1oKWmtpVUprRTZjd1pPUExvdGRZZnovQWU5elhnRGxFRjJiK2pZN3JPTGVoOTdtK3l5b3ZMdG5saE5UWnlPd3VEMApyNWNrUG8raWtqUC9zQXZGTXVmUVRCUFYvMzR5UzhZWWxCME5vdVo3Tkx1bHQzVGJxOGhJMWxKUXJiYTFLU0JPCkJFMDkvUUlEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JRZ0JiNExxd0dmOUNDL3daSE9Kdm9xTUwzVQpRREFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBaGhYVFZnLzNOQU1TcVdRQkg4K25IZjNNU0o2QTRTRmowdHpsClF4UU9wd1RIOHV3Q2IvZ0wvZVVFRUlmZ0x2YXRSaGhHNlQ1N0Y4NEFvYkxYOUhDZnVGMEZZZTdTU0o4R3gyM24KTUFMc3YxRzJ3T0Z3SCt4bDRPamlXMjN6UFo2QkZRanZxd0ZKb0t2elU0SXNzWjh2c25neDhsSEYvSU9pR2pmTgpIcDVkYmpqOHZ6ZW5RR1paUDBsSVRic2w1d2gwZkFwNUtWUHJsb3hZMGhtVU9paGYvU09ObDlsRTd4YVVKeS9qCll6ZjlaV3BrZWoxVUdVN2JiLzBZcU9oNlRjUndIeW5rSy9YNWxCTVkrdE96bUV0ZzBXYXA4Y1RpLzV5SEUwZEsKek9LcUc1cXg2aHBIdEg2WG1XbHBsNzdLK2ZYQU1QWGkyVHlaZkZjcTVIT0RjcVRuMHc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
client_key             = "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBN3ZLVTcwN3RIaHBORUJTQkZiSWFuOTlHYVIvTGFmVzVENTlFcG80M2NBd1VoTlVNCmZmTUdzOEtKNFpidktaMWxaKzY2YVNnaXpYNlhKTmxoOWc3czhTRmQ1KzBwWHNEU0FycTVvcjZqNjI3Y0R4NDgKN25pNVRtZzlsR2lwRHJaZkdhYWlyZFUxV1dvajZHcmV2Y21UZGFCOEdiUVJiMG54QzZFczVCU1kvMDNHOVNGagpxc2JJQUhaajJkREdHbG43TXg4QlkyMTJzb1hza3hnWlpraVVKa0U2Y3daT1BMb3RkWWZ6L0FlOXpYZ0RsRUYyCmIralk3ck9MZWg5N20reXlvdkx0bmxoTlRaeU93dUQwcjVja1BvK2lralAvc0F2Rk11ZlFUQlBWLzM0eVM4WVkKbEIwTm91WjdOTHVsdDNUYnE4aEkxbEpRcmJhMUtTQk9CRTA5L1FJREFRQUJBb0lCQUUzZjg1ZzJ3ZUxRc1pMdgpDODcxVitZSXo1ck5TTzlFclVhaElxK2hwQUc1ZmlwNGdQUy9jc3k5TjFDMWIwYkJ6RjNlR1JUU2h0MHdSN1F6CndOQi90c3N6azdaVnZlanFzTWRBOGVWUGVuN3RoM3pKM3hQZGRvOU9POXVWYkp1bDVrS200MWdDSjd2M2NySjUKdWhSaWtOT0NOVS92TnN0dGJzamFnNVhsL0tNZnBkZlArbDlRVFBrbVZKQUtwb0wxY1YxYkJQVlVvcFlhN0lrMQptVnNqOXo5TklISXNpT29Ja2dIUE5jNENzSlNnMTQ1ZDR3RDJEOEhrTTRpTkhab01tN0JsTnFwaTNoSW5QbVVoCmV3dUEySHVKS0NXYklPclBTNjh6TVI4QXRZRHlIRmVielc1SDRGRW92Y3E5Ujg3MUdLdHVuUHRiNEtFRGVVeEMKN2VMWlo4RUNnWUVBOFUzTitES2lnWlJqNE1MN0RiYjA2c1FPelZvYzdyMW9vMnVaY0lvUWlxUGtGOXl4V1VjVwpXSXFGQlk3aGNad1piTkhONFd2NjNMRHlTZUdMMGRxOElyOUJydGI3T0xML2FranFBeW1QWE42Tmt0Zk9MT0t1CmIxRzVwa2dzR3dIcEhvYnFmT25ZVmFVQTRoTEVCTno1akE4a3hkZktNaEs4N2NJOURlZzNzQTBDZ1lFQS9ZQUsKRGNsWkVYREVXNGhHbXhhVWFsUCt5Tkk0dzhHenZyc3hBcCtVZWk2MlEwM2tLTmFhZnBUU0R3eG9kb0tYTi9OOQp2YzNaazhhRjJjR0RBMmVoaEc1ZzhPemNMcHpIaW5nZXppMmpWdjVndWpPdE1QbEEwKzBQUE10WTUza2lZajN2Ck4wdi9oK0daSklzT1ZaMzZ5RGRudGU3dG5SUVp5ZVhvZklINFdiRUNnWUF5dHhXSkNxdFk3S1VwUWhHZHlrd2oKWTExeEQzVnhQK0hVSnZNeTBmRzBFY29Jc2R1Y1ZmSitYVzZqd21uamhObGJJNlZQc1hBaUhoWnVMTGRFUGVLNApzdFhOTjJYSmZ1VnJvek43d3FwYzdIRjQ0VjUxMUphdzBzNWdBbDh5dGU0VyttZ2lKTXZSQkVMeFFOeHQ0VHVaCmtqMDZUNll4YS9yRlJjT3JQcGtscVFLQmdRQ3ZDVzNudnhPbEd6dzZCNHJaSTJvdlVQZ29LaC9QNnp2MWdzT0EKa0RleGRmZWIyWGlsU2lrN0pmODFMTmdrbkY5VjN1Yi8yOWRVVmt1dDVCUldrWVBSTVhYMlpWWlRTU1h1MHFwUwpxdWlSOU90TkpzbDdlMS9yOVZBRUpsU28zOWVDQmtuYTRMcjhWQ1d1T2VZWDhCRnRsZlFpaDJ2Q2ZsS2dPZ09oCmxReXF3UUtCZ0NRSEtQWVlnWmllMTNtT2EyT01ldjZOZmh4L082Q2Z4S2RWaTFPWmtiMXFkM3hjS1BRdmhGZFkKWGdDZUNCSWF3cmN6TE1KdGRiSXJ3WUF3ZWZZTkRQaFF3MGF4NldoSVhpa0dGWXlBLzMrbTRpYlVhK1orNlkvKwp5MVo0MW9vY2Z4T1F3WlR3SkM0cmxOVnRpMWxYUzRLRVFLblZoVE1XaGZlSlUzeU1IdjhCCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg=="
cluster_ca_certificate = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJMU1ERXlOekU1TWpJME1Wb1hEVE0xTURFeU5URTVNakkwTVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBUEJVCkpmdFZ0NFVDU1E4b0JXVXpSNjROOW13UXdTT01HbUZrcG9TMU95b2tLQWNoU2VKd2d3VjFQOGxTOUFIendZUkYKSjZHbHc2a25mejU5N1VkaUNLYm9XV2Z0MkxPZ0xSSzlWU0UxN1ozQTUxOEVTb1FvTy93c0NEZXdKNngxbEcxTApnOFNJWEd1SnJqaGx2dDlBVTdpcGs4UHR2SWo1QjYvMERaSVMyQ0x2WitqYllPMFcwT2NIb0xQdlgzcDhEZzZCClJFbDdOalA1NUZ4VWdmbDlLUFQvajhlcnZwZU1HYWhMUmNHL04xaTAvaXAyNG5OYWhYSzhRQklpbmZYa3BEOUYKbXoySHBuZDRxV2tlU2lSSEZMc2pNb3lHeDdiSnFUNnk4TFoveGVETEFmVFJDUXBRUkxxcHZlN3JBOUF6K1hEVQpaT3hCS0lEZE1ZaDB3eDkyZ1hjQ0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZDQUZ2Z3VyQVovMElML0JrYzRtK2lvd3ZkUkFNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFDYm1BSFhmZEgxeHJKbFBLTEtJbmdYWVBZT1lXbWdrL1Qva25EZ3Roc3ptNmJJZzkvYwp2KzhuQ0xLTnJVcWZsajZ3RHd6ZmQveTBWRjkzcmlaaG55OGg1Zkg2Y3VRSmlVUXEva1VxdURPcU9pL2NMZWpJCis5UHJ0c1NWWEhobzRudFRPSW1XL21ZSmpIYjVIMnBpc1RCNmxxVFJ2TUIrZTRYTUp4UW9KWmtwZ1AyV3RSSDUKOEY4eWgxcmp4akxVN1lEZmNzSXpkMnhnbW5tejFZWk1qMXcxZm40UnpHU0FKeTlBdjZ0OUlWb2dIb2wxdElOUgpNRGZUbGRSS3pRd0tjTmVTbDZKbi9POHN2Mm8xVzZpZXZvVkw4OTcyVUZJREhOYkZwREhDaGN3RzNxaEtRcDBWClNXSURZMTMwem8vNnVDbUordlVrbkRBb04rUVlNeDUxMjZwQwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="


[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/kubernetes...
- Installing hashicorp/kubernetes v2.35.1...
- Installed hashicorp/kubernetes v2.35.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ wget https://raw.githubusercontent.com/linuxacademy/content-terraform-2021/main/lab_kubernetes_resources.tf
--2025-01-27 19:33:05--  https://raw.githubusercontent.com/linuxacademy/content-terraform-2021/main/lab_kubernetes_resources.tf
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.109.133, 185.199.110.133, 185.199.111.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.109.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 768 [text/plain]
Saving to: ‘lab_kubernetes_resources.tf’

100%[==============================================================================>] 768         --.-K/s   in 0s

2025-01-27 19:33:05 (15.5 MB/s) - ‘lab_kubernetes_resources.tf’ saved [768/768]

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$


[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ cat lab_kubernetes_resources.tf
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "long-live-the-bat"
    labels = {
      App = "longlivethebat"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "longlivethebat"
      }
    }
    template {
      metadata {
        labels = {
          App = "longlivethebat"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "batman"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$

terraform plan; terraform apply; kubectl get deployments

[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$ terraform plan; terraform apply; kubectl get deployments

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_deployment.nginx will be created
  + resource "kubernetes_deployment" "nginx" {
      + id               = (known after apply)
      + wait_for_rollout = true

      + metadata {
          + generation       = (known after apply)
          + labels           = {
              + "App" = "longlivethebat"
            }
          + name             = "long-live-the-bat"
          + namespace        = "default"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }

      + spec {
          + min_ready_seconds         = 0
          + paused                    = false
          + progress_deadline_seconds = 600
          + replicas                  = "2"
          + revision_history_limit    = 10

          + selector {
              + match_labels = {
                  + "App" = "longlivethebat"
                }
            }

          + strategy {
              + type = (known after apply)

              + rolling_update {
                  + max_surge       = (known after apply)
                  + max_unavailable = (known after apply)
                }
            }

          + template {
              + metadata {
                  + generation       = (known after apply)
                  + labels           = {
                      + "App" = "longlivethebat"
                    }
                  + name             = (known after apply)
                  + resource_version = (known after apply)
                  + uid              = (known after apply)
                }

              + spec {
                  + automount_service_account_token  = true
                  + dns_policy                       = "ClusterFirst"
                  + enable_service_links             = true
                  + host_ipc                         = false
                  + host_network                     = false
                  + host_pid                         = false
                  + hostname                         = (known after apply)
                  + node_name                        = (known after apply)
                  + restart_policy                   = "Always"
                  + scheduler_name                   = (known after apply)
                  + service_account_name             = (known after apply)
                  + share_process_namespace          = false
                  + termination_grace_period_seconds = 30

                  + container {
                      + image                      = "nginx:1.7.8"
                      + image_pull_policy          = (known after apply)
                      + name                       = "batman"
                      + stdin                      = false
                      + stdin_once                 = false
                      + termination_message_path   = "/dev/termination-log"
                      + termination_message_policy = (known after apply)
                      + tty                        = false

                      + port {
                          + container_port = 80
                          + protocol       = "TCP"
                        }

                      + resources {
                          + limits   = {
                              + "cpu"    = "0.5"
                              + "memory" = "512Mi"
                            }
                          + requests = {
                              + "cpu"    = "250m"
                              + "memory" = "50Mi"
                            }
                        }
                    }

                  + image_pull_secrets {
                      + name = (known after apply)
                    }

                  + readiness_gate {
                      + condition_type = (known after apply)
                    }
                }
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_deployment.nginx will be created
  + resource "kubernetes_deployment" "nginx" {
      + id               = (known after apply)
      + wait_for_rollout = true

      + metadata {
          + generation       = (known after apply)
          + labels           = {
              + "App" = "longlivethebat"
            }
          + name             = "long-live-the-bat"
          + namespace        = "default"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }

      + spec {
          + min_ready_seconds         = 0
          + paused                    = false
          + progress_deadline_seconds = 600
          + replicas                  = "2"
          + revision_history_limit    = 10

          + selector {
              + match_labels = {
                  + "App" = "longlivethebat"
                }
            }

          + strategy {
              + type = (known after apply)

              + rolling_update {
                  + max_surge       = (known after apply)
                  + max_unavailable = (known after apply)
                }
            }

          + template {
              + metadata {
                  + generation       = (known after apply)
                  + labels           = {
                      + "App" = "longlivethebat"
                    }
                  + name             = (known after apply)
                  + resource_version = (known after apply)
                  + uid              = (known after apply)
                }

              + spec {
                  + automount_service_account_token  = true
                  + dns_policy                       = "ClusterFirst"
                  + enable_service_links             = true
                  + host_ipc                         = false
                  + host_network                     = false
                  + host_pid                         = false
                  + hostname                         = (known after apply)
                  + node_name                        = (known after apply)
                  + restart_policy                   = "Always"
                  + scheduler_name                   = (known after apply)
                  + service_account_name             = (known after apply)
                  + share_process_namespace          = false
                  + termination_grace_period_seconds = 30

                  + container {
                      + image                      = "nginx:1.7.8"
                      + image_pull_policy          = (known after apply)
                      + name                       = "batman"
                      + stdin                      = false
                      + stdin_once                 = false
                      + termination_message_path   = "/dev/termination-log"
                      + termination_message_policy = (known after apply)
                      + tty                        = false

                      + port {
                          + container_port = 80
                          + protocol       = "TCP"
                        }

                      + resources {
                          + limits   = {
                              + "cpu"    = "0.5"
                              + "memory" = "512Mi"
                            }
                          + requests = {
                              + "cpu"    = "250m"
                              + "memory" = "50Mi"
                            }
                        }
                    }

                  + image_pull_secrets {
                      + name = (known after apply)
                    }

                  + readiness_gate {
                      + condition_type = (known after apply)
                    }
                }
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

kubernetes_deployment.nginx: Creating...
kubernetes_deployment.nginx: Still creating... [10s elapsed]
kubernetes_deployment.nginx: Creation complete after 16s [id=default/long-live-the-bat]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
NAME                READY   UP-TO-DATE   AVAILABLE   AGE
long-live-the-bat   2/2     2            2           17s
[cloud_user@ip-10-0-1-78 lab-deploy-kubernetes]$
