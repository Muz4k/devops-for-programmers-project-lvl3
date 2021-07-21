### Hexlet tests and linter status:
[![Actions Status](https://github.com/Muz4k/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/Muz4k/devops-for-programmers-project-lvl3/actions)

Этот проект про [strapi-app](https://project.gitpushforce.club/) <- он вот здесь

## Инфраструктура
- Сервер-балансировщик - 1 шт.
- Серверы с приложением - 2 шт.
- База данных - PostgreSQL - 1 шт.

### Разворачивание инфраструктуры 
- На [Digital-Ocean](https://www.digitalocean.com/)
- С помощью [Terraform](https://www.terraform.io/)
- С хранением состояния и переменных в Terraform Cloud

#### Команды
```
make tf-init
```
```
make tf-plan
```
```
make tf-apply
```

## Подготовка серверов и разворачивание приложения 

- C помощью [Ansible](https://www.ansible.com/)
  - 2.9+
- [Docker-коллекцией](https://docs.ansible.com/ansible/latest/collections/community/docker/index.html)
  - 1.8.0
- [Шифрованием переменных](https://docs.ansible.com/ansible/latest/user_guide/vault.html)
  - путь до файла-дешифровщика ```~/.ansible_pass.txt```

#### Команды
1. Запуск плейбука
```
make start-playbook
```
2. Шифрование переменных
```
make encrypt_string secret_value=test_value secret_name=test_name
```
3. Дешифровка переменных
```
make show-encrypted-string secret_name=test_name path_to_file=ansible/group_vars/webservers.yml
```
4. Тестирование ответа балансера
```
make test-app
```

## Мониторинг
- http_check [Datadog](https://www.datadoghq.com/)
  - Alert на почту при отсутствии ответа от сервера с приложением
- [freshping](https://www.freshworks.com/website-monitoring/signup/)