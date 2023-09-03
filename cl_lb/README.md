# Домашнее задание к занятию 2 «Кластеризация и балансировка нагрузки» - Логинов Даниил 

### Задание 1 

1. Запустите два simple python сервера на своей виртуальной машине на разных портах
2. Установите и настройте HAProxy, воспользуйтесь материалами к лекции по ссылке
3. Настройте балансировку Round-robin на 4 уровне.
4. На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

### Ответ 1

[Конифг HAProxy](https://github.com/Loginochka/sflt.hw/tree/main/cl_lb/haproxy.cfg)

[Скриншот запросов](https://github.com/Loginochka/sflt.hw/blob/main/media/request-hapr.png)

-----

### Задание 2

1. Запустите три simple python сервера на своей виртуальной машине на разных портах
2. Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
3. HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
3. На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.

### Ответ 2 

[Конфигг HAPrpxy](https://github.com/Loginochka/sflt.hw/tree/main/cl_lb/haproxy-2.cfg)

[Скриншот запросов](https://github.com/Loginochka/sflt.hw/blob/main/media/dif_weight_request_hapr.png)
