# astrviktor_infra
astrviktor Infra repository

## ДЗ 3: Знакомство с облачной инфраструктурой Yandex.Cloud

#### Способ подключения к someinternalhost в одну команду:

ssh -i ~/.ssh/appuser -J appuser@51.250.72.46 appuser@10.128.0.16

#### Подключение при помощи команды вида ssh someinternalhost по алиасу:

nano ~/.ssh/config
```
Host someinternalhost
  ProxyJump appuser@51.250.72.46
  HostName 10.128.0.16
  User appuser
  IdentityFile ~/.ssh/appuser
```
ssh someinternalhost

#### Дополнительно
- 0.5 GB RAM маловато для mongodb, добавил до 2 GB
- С репозиторием mongodb возникли проблемы, запустил mongodb через docker

#### Данные для подключения
```
bastion_IP = 51.250.72.46
someinternalhost_IP = 10.128.0.16
```

## ДЗ 4: Деплой тестового приложения

#### Создание нового инстанса через yc
```
yc compute instance create \
 --name reddit-app \
 --hostname reddit-app \
 --cores=2 \
 --core-fraction=5 \
 --memory=4 \
 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
 --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
 --zone=ru-central1-a \
 --metadata serial-port-enable=1 \
 --ssh-key ~/.ssh/yc-user.pub
```
#### Создание нового инстанса через yc с startup script
```
yc compute instance create \
 --name reddit-app \
 --hostname reddit-app \
 --cores=2 \
 --core-fraction=5 \
 --memory=4 \
 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
 --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
 --zone=ru-central1-a \
 --metadata serial-port-enable=1 \
 --metadata ssh-keys="yc-user:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjmPEV2dARySR5FmtTtAI2ysH3x1uj1eo6KvlMTlv8IqLmwCWm9hMc/3kgVgKmNGOU6VcLtflT1dnn8Yn9vGmKXZST126KEfej0VFJmSBFrRtinhbwJMrr0vX+YjzB26l/Tu2YhUNsuKLVi0N+XPY/bMKjE8fuOTQPRr9JSkCB2fAMOIbG75xuCp6Css+Fc6XTagZ0WjW/B+oa6sk0RKBKpIWLBmm3l9Dq+TjhjbbdmE987imnefkVDuHwkhKz4vZNvM9kFDRrBBgBowQp2V++rEJhhUaNezAYnMvUkLautzcQvHsgvN1+kItsBK4a4dmb0onQ/He5+kH+AMeW0djt yc-user" \
 --metadata-from-file user-data=deploy_yc.sh
```

#### Данные для подключения
```
testapp_IP = 51.250.82.139
testapp_port = 9292
```
## ДЗ 5: Сборка образов VM при помощи Packer

Валидация конфигурации
```
packer validate -var-file=variables.json ubuntu16.json
```

Запуск сборки
```
packer build -var-file=variables.json ubuntu16.json
```

## ДЗ 6: Практика IaC с использованием Terraform
Подготовка инфраструктуры с помощью Terraform:
1. Перейти в папку **terraform**
2. Скопировать **terraform.tfvars.example** в **terraform.tfvars** и подставить нужные значения
3. Запустить командой `terraform apply --auto-approve`
4. Удалить командой `terraform destroy`

Выполнено дополнительное задание с созданием балансировщика

В выходных переменных есть адреса инстанса и балансировщика

Зайти через браузер
```
http://IP_инстанса:9292 или http://IP_балансировщика:9292
```

## ДЗ 7: Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform

Запуск сборки образов "reddit-app-base" и "reddit-db-base"
```
packer build -var-file=variables.json app.json
packer build -var-file=variables.json db.json
```

Создание файлов **app.tf**, **db.tf**, **vpc.tf**, меняем **main.tf**
для того чтобы поднимать отдельные инстансы на приложение и базу данных

Нужно проверить работоспособность:
```
terraform apply
terraform destroy
```

### Перевод на модульную струкутру

Загрузка модулей:
```
terraform get
```
Нужно проверить работоспособность:
```
terraform apply
terraform destroy
```
### Перевод на окружения stage и prod

Перенос файлам по папкам stage и prod, исправление путей к модулям

Загрузка модулей и проверка работоспособности

## ДЗ 8: Управление конфигурацией. Основные DevOps инструменты. Знакомство с Ansible

Нужно выполнить playbook
```
ansible-playbook clone.yml
```
В результате изменений нет:
```
appserver                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
Изменений не было, так как директория **reddit** уже есть

Затем нужно удалить папку **reddit** и заново выполнить playbook
```
ansible app -m command -a 'rm -rf ~/reddit'
ansible-playbook clone.yml
```
В результате изменения были:
```
appserver                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

##### inventory.json

Для генерации файла **inventory.json** выполнить:
```
python inventory.py
```
Для выполнения ansible с файлом **inventory.json** выполнить:
```
ansible all -m ping -i inventory.json
```

## ДЗ 9: Деплой и управление конфигурацией с Ansible

В процессе выполнения ДЗ было сделано

1. Создание плейбука с одним сценарием, использование шаблона, переменных, Handlers
2. Создание одного плейбука с несколькими сценариями
3. Создание нескольких плейбуков
4. Настройка и деплой с помощью ansible
5. Изменение провиженинга в packer на ansible, обновление образов

Для пересборки packer нужно выполнить:

```
packer build -var-file=packer/variables.json packer/app.json
packer build -var-file=packer/variables.json packer/db.json
```

## ДЗ 10: Ansible: работа с ролями и окружениями

В процессе выполнения ДЗ было сделано

1. Перенос созданных плейбуков в раздельные роли (шаблон через ansible-galaxy init)
2. Описание окружений stage и prod
3. Использование коммьюнити роли nginx - jdauphant.nginx
4. Использование Ansible Vault для безопасной работы с приватными данными

Для проверки нужно выполнить:
```
ansible-playbook -i environments/stage/inventory playbooks/site.yml --check
ansible-playbook -i environments/stage/inventory playbooks/site.yml
```

## ДЗ 11: Разработка и тестирование Ansible ролей и плейбуков. Локальная разработка с Vagrant

В процессе выполнения ДЗ было сделано
1. Установка Vagrant
2. Изменение и параметризация ролей Ansible
3. Тестирование с помощью Molecule

Vagrant предложил поменять сеть на Ranges: 192.168.56.0/21, увеличил память до 2Gb

Команды Vargant:

```
# Проверка версии
vagrant -v

# создание VM по Vagrantfile
vagrant up

# Удаление VM
vagrant destroy -f

# Информация
vagrant box list
vagrant status
```

Команды Molecule:

```
# Инициализация сценария
molecule init scenario -r db -d delegated default

# Создание VM для проверки роли
molecule create

# Список созданных инстансов для molecule
molecule list

# Применение плейбука
molecule converge

# Прогон тестов
molecule verify
```
