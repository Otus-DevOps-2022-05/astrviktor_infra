# astrviktor_infra
astrviktor Infra repository

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
testapp_IP = 51.250.84.60
testapp_port = 9292
```
