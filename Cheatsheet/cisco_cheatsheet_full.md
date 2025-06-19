! ==============================
! Введение в сетевые технологии
! ==============================

! Проверить состояние всех интерфейсов: IP адрес, статус, протокол
show ip interface brief

! Показать таблицу маршрутов — как устройство выбирает куда отправлять пакеты
show ip route

! Показать ARP таблицу — сопоставление IP и MAC адресов в локальной сети
show arp

! Проверить доступность IP адреса (пинговать)
ping 192.168.1.1

! Отследить путь до IP адреса — какие маршрутизаторы по пути
traceroute 8.8.8.8


! ==============================
! Основы коммутации и маршрутизации
! ==============================

! Показать MAC адреса, которые известны коммутатору, и на каких портах они находятся
show mac address-table

! Показать список VLAN, их ID, имена и порты, к которым они назначены
show vlan brief

! Показать интерфейсы, настроенные как trunk, и какие VLAN разрешены на них
show interfaces trunk

! Очистить динамическую MAC таблицу — для обновления связей MAC с портами
clear mac address-table dynamic


! ==============================
! VLAN — Конфигурация
! ==============================

! Создать VLAN с номером 10 и задать имя "HR" для удобства идентификации
vlan 10
 name HR
 exit

! Настроить порт fa0/1 как access-порт и назначить его в VLAN 10
interface fa0/1
 switchport mode access
 switchport access vlan 10
 exit

! Настроить порт fa0/24 как trunk и разрешить VLAN 10, 20, 30, указать native VLAN 99
interface fa0/24
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 switchport trunk native vlan 99
 exit


! ==============================
! Путь пакета в L2 и L3
! ==============================

! Показать MAC-адреса и статусы интерфейсов (L2)
show mac address-table
show interfaces status
show vlan brief

! Показать маршруты, интерфейсы и ARP таблицу (L3)
show ip route
show ip interface brief
show ip arp

! Проверить доступность узлов
ping 192.168.1.1
traceroute 8.8.8.8


! ==============================
! Шлюз по умолчанию и маршрутизация
! ==============================

! Назначить IP-адрес интерфейсу g0/0 и включить его
interface g0/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
 exit

! Назначить IP-адрес на SVI VLAN 1
interface vlan 1
 ip address 192.168.1.2 255.255.255.0
 no shutdown
 exit

! Назначить шлюз по умолчанию
ip default-gateway 192.168.1.1

! Добавить статический маршрут
ip route 10.0.0.0 255.255.255.0 192.168.1.2

! Проверить таблицу маршрутизации
show ip route


! ==============================
! Отказоустойчивость: STP, RSTP, EtherChannel
! ==============================

! Проверить состояние Spanning Tree Protocol
show spanning-tree

! Включить RSTP (Rapid PVST)
spanning-tree mode rapid-pvst

! Настроить EtherChannel на интерфейсах fa0/1 и fa0/2 (L2)
interface range fa0/1 - 2
 channel-group 1 mode active
 switchport mode trunk
 exit


! ==============================
! Динамическая маршрутизация: RIP, OSPF, EIGRP
! ==============================

! Включить RIP и объявить сеть
router rip
 version 2
 network 192.168.1.0
 exit

! Включить OSPF с идентификатором 1, добавить сеть в area 0
router ospf 1
 network 192.168.1.0 0.0.0.255 area 0
 exit

! Включить EIGRP с автономной системой 100 и сеть 192.168.1.0
router eigrp 100
 network 192.168.1.0 0.0.0.255
 exit

! Проверить протоколы маршрутизации и таблицу маршрутов
show ip protocols
show ip route


! ==============================
! Сетевая безопасность: Port Security и ACL
! ==============================

! Включить Port Security на порту fa0/1 с максимальным количеством MAC 1
interface fa0/1
 switchport mode access
 switchport port-security
 switchport port-security maximum 1
 switchport port-security mac-address sticky
 switchport port-security violation shutdown
 exit

! Создать ACL, разрешающую сеть 192.168.1.0/24
access-list 10 permit 192.168.1.0 0.0.0.255

! Применить ACL к интерфейсу g0/0 входящему трафику
interface g0/0
 ip access-group 10 in
 exit

! Проверить состояние Port Security и ACL
show port-security interface fa0/1
show access-lists


! ==============================
! Беспроводные сети (WiFi)
! ==============================

! Создать SSID MyWiFi, открытая аутентификация, VLAN 10
dot11 ssid MyWiFi
 authentication open
 vlan 10
 exit

! Назначить SSID интерфейсу беспроводного радиомодуля
interface dot11Radio 0
 ssid MyWiFi
 exit

! Проверить состояние беспроводных сетей
show wireless ssid summary


! ==============================
! QoS — Качество обслуживания
! ==============================

! Определить класс трафика VOICE с DSCP ef
class-map match-any VOICE
 match ip dscp ef

! Настроить политику с приоритетом 70% для VOICE
policy-map QOS-POLICY
 class VOICE
  priority percent 70

! Применить политику QoS на выходном интерфейсе g0/0
interface g0/0
 service-policy output QOS-POLICY
 exit


! ==============================
! Основы проектирования корпоративных сетей
! ==============================

! Создать SVI для VLAN 10 с IP адресом
interface vlan 10
 ip address 192.168.10.1 255.255.255.0
 no shutdown
 exit

! Включить маршрутизацию на L3 switch
ip routing


! ==============================
! Инструменты эксплуатации и диагностики
! ==============================

! Проверить загрузку процессора
show processes cpu sorted

! Проверить использование памяти
show processes memory

! Сохранить текущую конфигурацию в startup-config
copy running-config startup-config

! Загрузить конфигурацию из startup-config в running-config
copy startup-config running-config

! Сделать резервную копию конфигурации на TFTP сервер
copy running-config tftp:


! ==============================
! Основы IP-телефонии
! ==============================

! Настроить VLAN 10 для голосового трафика с IP адресом
interface vlan 10
 description Voice VLAN
 ip address 192.168.10.1 255.255.255.0
 no shutdown
 exit

! Настроить порт fa0/10 для голосового VLAN 10 и access VLAN 20
interface fa0/10
 switchport voice vlan 10
 switchport access vlan 20
 exit

! Настроить DHCP пул для IP телефонов
ip dhcp pool VOICE
 network 192.168.10.0 255.255.255.0
 default-router 192.168.10.1
 option 150 ip 192.168.10.10  ! IP адрес CUCM


! ==============================
! Дополнительные темы
! ==============================

! Router-on-a-Stick — настройка подинтерфейсов с dot1Q на роутере
interface g0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0
 exit

interface g0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0
 exit

interface g0/0
 no shutdown
 exit


! DHCP-сервер на маршрутизаторе
ip dhcp excluded-address 192.168.1.1 192.168.1.10

ip dhcp pool LAN
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.1
 dns-server 8.8.8.8


! NAT — трансляция адресов

! Статический NAT
ip nat inside source static 192.168.1.100 203.0.113.1

! Динамический NAT
access-list 1 permit 192.168.1.0 0.0.0.255
ip nat pool MYPOOL 203.0.113.100 203.0.113.110 netmask 255.255.255.0
ip nat inside source list 1 pool MYPOOL

! PAT (маскарадинг)
ip nat inside source list 1 interface g0/0 overload

! Определение зон NAT
interface g0/0
 ip nat outside
 exit

interface g0/1
 ip nat inside
 exit


! SNMP-мониторинг
snmp-server community public RO
snmp-server community private RW

! Проверка SNMP
show snmp


! NTP — синхронизация времени
ntp server 192.168.1.100
clock timezone MSK 3

! Проверка времени и статуса NTP
show clock
show ntp status


! Loopback интерфейс — виртуальный интерфейс для тестов и маршрутизации
interface loopback0
 ip address 1.1.1.1 255.255.255.255
 exit

! Проверка интерфейсов
show ip interface brief


! Резервные маршруты (Floating static routes)
! Основной маршрут с административной дистанцией 1
ip route 0.0.0.0 0.0.0.0 192.168.1.1

! Резервный маршрут с AD 200
ip route 0.0.0.0 0.0.0.0 192.168.2.1 200


! SSH-доступ — базовая настройка

! Задать имя устройства
hostname Router

! Настроить доменное имя (нужно для SSH)
ip domain-name example.com

! Сгенерировать ключи RSA для SSH
crypto key generate rsa modulus 2048

! Создать локального пользователя с привилегиями 15
username admin privilege 15 secret cisco123

! Установить пароль enable
enable secret ciscoEnableSecret123

! Включить AAA для аутентификации
aaa new-model
aaa authentication login default local
aaa authentication enable default enable

! Настроить VTY линии для SSH доступа
line vty 0 4
 login authentication default
 transport input ssh
 exit

! Проверить состояние SSH
show ip ssh


! Сброс настроек к заводским
write erase
reload


! Диагностика и полезные команды

! Показать текущую конфигурацию
show running-config

! Показать конфигурацию для запуска
show startup-config

! Показать соседей Cisco Discovery Protocol
show cdp neighbors

! Подробная информация о соседях CDP
show cdp neighbors detail

! Показать соседей LLDP
show lldp neighbors
