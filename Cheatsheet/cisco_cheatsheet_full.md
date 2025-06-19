==========================================
             Введение в сетевые технологии
==========================================

**Проверить состояние всех интерфейсов:**  
  show ip interface brief  
  _Показывает IP адрес, статус и протокол каждого интерфейса_

**Показать таблицу маршрутов:**  
  show ip route  
  _Как устройство выбирает куда отправлять пакеты_

**Показать ARP таблицу:**  
  show arp  
  _Отображает соответствие IP и MAC адресов в локальной сети_

**Проверить доступность IP адреса (пинг):**  
  ping 192.168.1.1

**Отследить путь до IP адреса:**  
  traceroute 8.8.8.8  
  _Показывает маршрутизаторы по пути_

------------------------------------------
          Основы коммутации и маршрутизации
------------------------------------------

**Показать MAC адреса и порты:**  
  show mac address-table  
  _MAC адреса, известные коммутатору и порты, к которым они привязаны_

**Показать список VLAN:**  
  show vlan brief  
  _ID, имена и порты VLAN_

**Показать trunk интерфейсы и разрешённые VLAN:**  
  show interfaces trunk

**Очистить динамическую MAC таблицу:**  
  clear mac address-table dynamic  
  _Обновляет связи MAC с портами_

------------------------------------------
                  VLAN — Конфигурация
------------------------------------------

**Создать VLAN 10 с именем HR:**  
  vlan 10  
  name HR  
  exit

**Настроить порт fa0/1 как access и назначить VLAN 10:**  
  interface fa0/1  
  switchport mode access  
  switchport access vlan 10  
  exit

**Настроить порт fa0/24 как trunk, разрешить VLAN 10,20,30, native VLAN 99:**  
  interface fa0/24  
  switchport mode trunk  
  switchport trunk allowed vlan 10,20,30  
  switchport trunk native vlan 99  
  exit

------------------------------------------
           Путь пакета в L2 и L3 среде
------------------------------------------

Layer 2:  
  show mac address-table  
  show interfaces status  
  show vlan brief

Layer 3:  
  show ip route  
  show ip interface brief  
  show ip arp  
  ping 192.168.1.1  
  traceroute 8.8.8.8

------------------------------------------
        Шлюз по умолчанию и маршрутизация
------------------------------------------

**Назначение IP интерфейсу g0/0:**  
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

------------------------------------------
        Построение отказоустойчивых сетей
------------------------------------------

**Проверка состояния STP:**  
  show spanning-tree

**Включение RSTP:**  
  spanning-tree mode rapid-pvst

**Настройка EtherChannel (L2):**  
  interface range fa0/1 - 2  
  channel-group 1 mode active  
  switchport mode trunk  
  exit

------------------------------------------
         Динамическая маршрутизация (RIP, OSPF, EIGRP)
------------------------------------------

RIP:  
  router rip  
  version 2  
  network 192.168.1.0  
  exit

OSPF:  
  router ospf 1  
  network 192.168.1.0 0.0.0.255 area 0  
  exit

EIGRP:  
  router eigrp 100  
  network 192.168.1.0 0.0.0.255  
  exit

Проверка:  
  show ip protocols  
  show ip route

------------------------------------------
              Сетевая безопасность
------------------------------------------

Port Security:  
  interface fa0/1  
  switchport mode access  
  switchport port-security  
  switchport port-security maximum 1  
  switchport port-security mac-address sticky  
  switchport port-security violation shutdown  
  exit

ACL (Access Control Lists):  
  access-list 10 permit 192.168.1.0 0.0.0.255

  interface g0/0  
  ip access-group 10 in  
  exit

Проверка:  
  show port-security interface fa0/1  
  show access-lists

------------------------------------------
              Беспроводные сети
------------------------------------------

Настройка SSID:  
  dot11 ssid MyWiFi  
  authentication open  
  vlan 10  
  exit

  interface dot11Radio 0  
  ssid MyWiFi  
  exit

Проверка:  
  show wireless ssid summary

------------------------------------------
             QoS (Качество обслуживания)
------------------------------------------

Настройка QoS (пример для VoIP):  
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

------------------------------------------
       Основы проектирования корпоративных сетей
------------------------------------------

Используются уровни: доступ, распределение, ядро.

Настройка SVIs на L3 Switch:  
  interface vlan 10  
  ip address 192.168.10.1 255.255.255.0  
  no shutdown  
  exit

Включение маршрутизации на коммутаторе:  
  ip routing

------------------------------------------
               Инструменты эксплуатации
------------------------------------------

Проверка загрузки CPU:  
  show processes cpu sorted

Проверка использования памяти:  
  show processes memory

Сохранение конфигурации:  
  copy running-config startup-config

Загрузка конфигурации:  
  copy startup-config running-config

Резервное копирование через TFTP:  
  copy running-config tftp:

------------------------------------------
             Основы IP-телефонии
------------------------------------------

Настройка VLAN для голоса:  
  interface vlan 10  
  description Voice VLAN  
  ip address 192.168.10.1 255.255.255.0  
  exit

Настройка порта для IP-телефонов:  
  interface fa0/10  
  switchport voice vlan 10  
  switchport access vlan 20  
  exit

DHCP для IP-телефонов:  
  ip dhcp pool VOICE  
  network 192.168.10.0 255.255.255.0  
  default-router 192.168.10.1  
  option 150 ip 192.168.10.10   ! IP адрес CUCM  
  exit

------------------------------------------
               Дополнительные темы
------------------------------------------

1. Router-on-a-Stick (Межвлановая маршрутизация):  
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

2. DHCP-сервер на маршрутизаторе:  
  ip dhcp excluded-address 192.168.1.1 192.168.1.10

  ip dhcp pool LAN  
  network 192.168.1.0 255.255.255.0  
  default-router 192.168.1.1  
  dns-server 8.8.8.8  
  exit

3. NAT (Преобразование адресов):  

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

4. SNMP мониторинг:  
  snmp-server community public RO  
  snmp-server community private RW

  Проверка:  
  show snmp

5. NTP (Синхронизация времени):  
  ntp server 192.168.1.100  
  clock timezone MSK 3

  Проверка:  
  show clock  
  show ntp status

6. Loopback интерфейс:  
  interface loopback0  
  ip address 1.1.1.1 255.255.255.255  
  exit

  Проверка:  
  show ip interface brief

7. Резервные маршруты (Floating static route):  
  ! Основной маршрут (AD=1)  
  ip route 0.0.0.0 0.0.0.0 192.168.1.1

  ! Резервный маршрут (AD=200)  
  ip route 0.0.0.0 0.0.0.0 192.168.2.1 200

8. SSH-доступ:  
  hostname Router                     ! Имя устройства  
  ip domain-name example.com          ! Дом. имя для SSH

  crypto key generate rsa modulus 2048

  username admin privilege 15 secret cisco123

  enable secret ciscoEnableSecret123

  aaa new-model  
  aaa authentication login default local  
  aaa authentication enable default enable

  line vty 0 4  
  login authentication default  
  transport input ssh  
  exit

  Проверка SSH:  
  show ip ssh

9. Сброс настроек:  
  write erase  
  reload

10. Диагностика:  
  show running-config  
  show startup-config

  show cdp neighbors  
  show cdp neighbors detail

  show lldp neighbors
