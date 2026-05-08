# Exercise 3.2 — Módulo Serverless (Lambda + API Gateway)

Despliegue de infraestructura basada en Terraform para una API serverless en AWS que permite la conversión de monedas mediante AWS Lambda y API Gateway.  
El proyecto implementa infraestructura como código, CI/CD con GitHub Actions y validación de despliegue mediante evidencia en AWS.

---

# Descripción General

En este ejercicio:

- Módulo reutilizable de Terraform para AWS Lambda
- Integración con API Gateway (REST API)
- Configuración de IAM Role para ejecución de Lambda
- Empaquetado y despliegue de función Node.js
- Pipeline de CI/CD con GitHub Actions
- Validación mediante endpoint HTTP
- Evidencia de despliegue en AWS

La función Lambda expone un endpoint `/convert` que recibe una solicitud JSON con monedas de origen, destino y monto, devolviendo el resultado convertido.

---

# Estructura del Repositorio

```text
oyd-exercise-3-2/
│
├── app/
│ └── index.js
│
├── infra/
│ ├── provider.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── main.tf
│ │
│ ├── envs/
│ │ └── dev/
│ │ └── dev.tfvars
│ │
│ ├── modules/
│ │ └── compute_lambda/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ │
│ └── evidence/
│ └── function.txt
│
├── .github/
│ └── workflows/
│ └── terraform-ci.yml
│
├── .gitignore
└── README.md
```

---

# Componentes de Infraestructura

El módulo de Terraform aprovisiona los siguientes recursos en AWS:

- AWS Lambda Function (Node.js)
- API Gateway REST API
- IAM Role para ejecución de Lambda
- CloudWatch Logs
- Integración Lambda + API Gateway

La infraestructura está parametrizada mediante variables para soportar múltiples entornos (dev, staging, prod).

---

# Endpoint Convert

POST /convert

---

# Solicitud

```bash
curl -X POST https://bemar1bvwd.execute-api.us-west-2.amazonaws.com/convert \
-H "Content-Type: application/json" \
-d '{"from":"USD","to":"GTQ","amount":100}'
```

---

# Respuesta

```json
{
  "from": "USD",
  "to": "GTQ",
  "amount": 100,
  "result": 780.5
}
```

---

# Evidencia

```json
{
  "FunctionArn": "arn:aws:lambda:us-west-2:504599819545:function:currency-converter-dev",
  "State": "Active",
  "Arch": ["arm64"]
}
```

---

# Pipeline CI/CD

Se configuró GitHub Actions para validar Terraform en cada Pull Request hacia main.

Incluye:

- terraform init
- terraform validate
- terraform plan
- publicación del plan en PR

---

# Comandos Terraform Utilizados

## Inicializar Terraform

```bash
terraform init
```

## Validar Configuración

```bash
terraform validate
```

## Generar Plan de Ejecución

```bash
terraform plan -var-file=envs/dev/dev.tfvars
```

## Aplicar Infraestructura

```bash
terraform apply -var-file=envs/dev/dev.tfvars
```

## Destruir Infraestructura

```bash
terraform destroy -var-file=envs/dev/dev.tfvars
```

---
