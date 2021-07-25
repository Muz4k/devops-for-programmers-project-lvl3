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

## Мониторинг
- http_check [Datadog](https://www.datadoghq.com/)
  - Alert на почту при отсутствии ответа от сервера с приложением
- [freshping](https://www.freshworks.com/website-monitoring/signup/)

### Шифрование переменных

Шифрование переменных используется для безопасного сохранения и использования секретных данных для Ansible.

В данном проекте это pg_pass - пароль к базе данных и datadog_api_key - ключ доступа к датадогу
- создать файла-дешифровщик с ограниченными правами
    ```
    make create-pass-file
    ```
- сохранить пароль для дешифровки в файле-дешифровщике ```~/.ansible_pass.txt```
- файл-дешифровщик ```~/.ansible_pass.txt``` должен содержать _только_ пароль без пробелов и переводов строк

Само шифрование производить командой
```
make encrypt_string secret_name=pg_pass
```
Где secret_name - имя переменной для шифрования. После чего ввести значение переменной и нажать Ctrl+D.

В консоли появится имя переменной и зашифрованное значение, которое нужно скопировать в файл для переменных Ansible
(В данном проекте - ```ansible/group_vars/webservers.yml```)

Команда для дешифровки:
```
make show-encrypted-string secret_name=test_name path_to_file=ansible/group_vars/webservers.yml
```
#### Команды
1. Запуск плейбука
```
make start-playbook
```
2. Тестирование ответа балансера
```
make test-app
```
