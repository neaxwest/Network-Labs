==================================
Введение в сетевые технологии
==================================

**Проверить состояние всех интерфейсов:** IP адрес, статус, протокол  
show ip interface brief

**Показать таблицу маршрутов** — как устройство выбирает куда отправлять пакеты  
show ip route

**Показать ARP таблицу** — сопоставление IP и MAC адресов в локальной сети  
show arp

**Проверить доступность IP адреса (пинговать)**  
ping 192.168.1.1

**Отследить путь до IP адреса** — какие маршрутизаторы по пути  
traceroute 8.8.8.8


==================================
Основы коммутации и маршрутизации
==================================

**Показать MAC адреса, которые известны коммутатору, и на каких портах они находятся**  
show mac address-table

**Показать список VLAN, их ID, имена и порты, к которым они назначены**  
show vlan brief

**Показать интерфейсы, настроенные как trunk, и какие VLAN разрешены на них**  
show interfaces trunk

**Очистить динамическую MAC таблицу — для обновления связей MAC с портами**  
clear mac address-table dynamic


==================================
VLAN — Конфигурация
==================================

**Создать VLAN с номером 10 и задать имя "HR"** для удобства идентификации  
vlan 10  
 name HR  
 exit

**Настроить порт fa0/1 как access-порт и назначить его в VLAN 10**  
interface fa0/1  
 switchport mode access  
 switchport access vlan 10  
 exit

**Настроить порт fa0/24 как trunk и разрешить VLAN 10,20,30 с native VLAN 99**  
interface fa0/24  
 switchport mode trunk  
 switchport trunk allowed vlan 10,20,30  
 switchport trunk native vlan 99  
 exit


==================================
Путь пакета в L2 и L3 среде
==================================

**Layer 2:**  
show mac address-table  
show interfaces status  
show vlan brief

**Layer 3:**  
show ip route  
show ip interface brief  
show ip arp  
ping 192.168.1.1  
traceroute 8.8.8.8


==================================
Шлюз по умолчанию и маршрутизация
==================================

**Назначение IP-адреса интерфейсу g0/0:**  
interface g0/0  
 ip address 192.168.1.1 255.255.255.0  
 no shutdown  
 exit

**Назначение IP на SVI (Switch Virtual Interface):**  
interface vlan 1  
 ip address 192.168.1.2 255.255.255.0  
 no shutdown  
 exit

**Настройка шлюза по умолчанию:**  
ip default-gateway 192.168.1.1

**Статический маршрут:**  
ip route 10.0.0.0 255.255.255.0 192.168.1.2

**Проверка таблицы маршрутизации:**  
show ip route


==================================
Построение отказоустойчивых сетей
==================================

**Проверка состояния STP:**  
show spanning-tree

**Включение RSTP (если нужно):**  
spanning-tree mode rapid-pvst

**Настройка EtherChannel (L2):**  
interface range fa0/1 - 2  
 channel-group 1 mode active  
 switchport mode trunk  
 exit


==================================
Динамическая маршрутизация (RIP, OSPF, EIGRP)
==================================

**RIP:**  
router rip  
 version 2  
 network 192.168.1.0  
 exit

**OSPF:**  
router ospf 1  
 network 192.168.1.0 0.0.0.255 area 0  
 exit

**EIGRP:**  
router eigrp 100  
 network 192.168.1.0 0.0.0.255  
 exit

**Проверка:**  
show ip protocols  
show ip route


==================================
Сетевая безопасность
==================================

**Port Security:**  
interface fa0/1  
 switchport mode access  
 switchport port-security  
 switchport port-security maximum 1  
 switchport port-security mac-address sticky  
 switchport port-security violation shutdown  
 exit

**ACL — списки контроля доступа:**  
access-list 10 permit 192.168.1.0 0.0.0.255

interface g0/0  
 ip access-group 10 in  
 exit

**Проверка:**  
show port-security interface fa0/1  
show access-lists


==================================
Беспроводные сети
==================================

**Настройка SSID (на контроллере или маршрутизаторе с wireless):**  
dot11 ssid MyWiFi  
 authentication open  
 vlan 10  
 exit

interface dot11Radio 0  
 ssid MyWiFi  
 exit

**Проверка:**  
show wireless ssid summary


==================================
QoS (Качество обслуживания)
==================================

**Настройка QoS на интерфейсе (пример с приоритезацией трафика VoIP):**  
class-map match-any VOICE  
 match ip dscp ef  
 exit

policy-map QOS-POLICY  
 class VOICE  
  priority percent 70  
 exit  
 exit

interface g0/0  
 service-policy output QOS-POLICY  
 exit


==================================
Основы проектирования корпоративных сетей
==================================

> Используются концепции уровня доступа, распределения и ядра. Ниже — команды для настройки маршрутизации между уровнями.

**Настройка SVIs (на L3 Switch):**  
interface vlan 10  
 ip address 192.168.10.1 255.255.255.0  
 no shutdown  
 exit

**Включение маршрутизации на уровне коммутатора:**  
ip routing


==================================
Инструменты эксплуатации
==================================

**Проверка загрузки CPU:**  
show processes cpu sorted

**Проверка использования памяти:**  
show processes memory

**Сохранение конфигурации:**  
copy running-config startup-config

**Загрузка конфигурации:**  
copy startup-config running-config

**Резервное копирование через TFTP:**  
copy running-config tftp:


==================================
Основы IP-телефонии
==================================

**Настройка голоса на интерфейсе (пример):**  
interface vlan 10  
 description Voice VLAN  
 ip address 192.168.10.1 255.255.255.0  
 exit

interface fa0/10  
 switchport voice vlan 10  
 switchport access vlan 20  
 exit

**DHCP для IP-телефонов:**  
ip dhcp pool VOICE  
 network 192.168.10.0 255.255.255.0  
 default-router 192.168.10.1  
 option 150 ip 192.168.10.10  ! IP адрес CUCM  
 exit


==================================
Дополнительные темы
==================================

**1. Router-on-a-Stick (Межвлановая маршрутизация на роутере):**  
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


**2. DHCP-сервер на маршрутизаторе:**  
ip dhcp excluded-address 192.168.1.1 192.168.1.10

ip dhcp pool LAN  
 network 192.168.1.0 255.255.255.0  
 default-router 192.168.1.1  
 dns-server 8.8.8.8  
 exit


**3. NAT (Преобразование адресов):**  
! Статический NAT  
ip nat inside source static 192.168.1.100 203.0.113.1

! Динамический NAT  
access-list 1 permit 192.168.1.0 0.0.0.255  
ip nat pool MYPOOL 203.0.113.100 203.0.113.110 netmask 255.255.255.0  
ip nat inside source list 1 pool MYPOOL

! PAT (маскарадинг)  
ip nat inside source list 1 interface g0/0 overload

! Назначение зон NAT  
interface g0/0  
 ip nat outside  
 exit

interface g0/1  
 ip nat inside  
 exit


**4. Базовый SNMP-мониторинг:**  
snmp-server community public RO  
snmp-server community private RW

**Проверка:**  
show snmp


**5. NTP (Синхронизация времени):**  
ntp server 192.168.1.100  
clock timezone MSK 3

**Проверка:**  
show clock  
show ntp status


**6. Настройка Loopback-интерфейса:**  
interface loopback0  
 ip address 1.1.1.1 255.255.255.255  
 exit

**Проверка:**  
show ip interface brief


**7. Резервные маршруты (Floating static route):**  
! Основной маршрут (AD = 1)  
ip route 0.0.0.0 0.0.0.0 192.168.1.1

! Резервный маршрут (AD = 200)  
ip route 0.0.0.0 0.0.0.0 192.168.2.1 200


**8. SSH-доступ на устройство:**  
hostname Router                    ! Настройка имени устройства  
ip domain-name example.com        ! Настройка доменного имени (нужно для SSH)

! Генерация ключей для SSH  
crypto key generate rsa modulus 2048

! Создание локального пользователя с привилегиями  
username admin privilege 15 secret cisco123

! Установка пароля для режима enable (привилегированный режим)  
enable secret ciscoEnableSecret123

! Включение AAA (Authentication, Authorization, Accounting)  
aaa new-model                                      ! Включение AAA  
aaa authentication login default local            ! Аутентификация при логине по локальной БД  
aaa authentication enable default enable          ! Аутентификация для перехода в режим enable

! Настройка линий VTY (удалённый доступ)  
line vty 0 4  
 login authentication default                     ! Использование AAA аутентификации  
 transport input ssh                              ! Разрешение только SSH-доступа  
 exit

**Проверка работы SSH:**  
show ip ssh


**9. Сброс настроек (Reset до заводских):**  
write erase  
reload


**10. Полезные команды диагностики:**  
show running-config  
show startup-config

! Проверка CDP (Cisco Discovery Protocol)  
show cdp neighbors  
show cdp neighbors detail

! Проверка LLDP  
show lldp neighbors
