# 📡 Введение в сетевые технологии

## Проверка интерфейсов
```
show ip interface brief
```
*Показывает IP-адреса, статус и протокол интерфейсов*

## Таблица маршрутов
```
show ip route
```

## ARP таблица
```
show arp
```

## Проверка доступности
```
ping 192.168.1.1
```

## Трассировка маршрута
```
traceroute 8.8.8.8
```

---

# 🛠 Основы коммутации и маршрутизации

## MAC-таблица
```
show mac address-table
```

## VLAN'ы
```
show vlan brief
```

## Trunk-интерфейсы
```
show interfaces trunk
```

## Очистка MAC-таблицы
```
clear mac address-table dynamic
```

---

# 🌐 VLAN — Конфигурация

### Создание VLAN
```
vlan 10
 name HR
exit
```

### Назначение VLAN на порт
```
interface fa0/1
 switchport mode access
 switchport access vlan 10
exit
```

### Trunk-порт
```
interface fa0/24
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 switchport trunk native vlan 99
exit
```

---

# 🧭 L2 / L3 проверка пути

### Layer 2
```
show mac address-table
show interfaces status
show vlan brief
```

### Layer 3
```
show ip route
show ip interface brief
show ip arp
ping 192.168.1.1
traceroute 8.8.8.8
```

---

# 🚪 Шлюз и маршруты

### IP на интерфейсе
```
interface g0/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
exit
```

### IP на SVI
```
interface vlan 1
 ip address 192.168.1.2 255.255.255.0
 no shutdown
exit
```

### Шлюз по умолчанию
```
ip default-gateway 192.168.1.1
```

### Статический маршрут
```
ip route 10.0.0.0 255.255.255.0 192.168.1.2
```

---

# 🔄 Отказоустойчивость

### STP
```
show spanning-tree
```

### Включение RSTP
```
spanning-tree mode rapid-pvst
```

### EtherChannel (L2)
```
interface range fa0/1 - 2
 channel-group 1 mode active
 switchport mode trunk
exit
```

---

# 📡 Динамическая маршрутизация

### RIP
```
router rip
 version 2
 network 192.168.1.0
exit
```

### OSPF
```
router ospf 1
 network 192.168.1.0 0.0.0.255 area 0
exit
```

### EIGRP
```
router eigrp 100
 network 192.168.1.0 0.0.0.255
exit
```

### Проверка
```
show ip protocols
show ip route
```

---

# 🔐 Безопасность: Port Security

```
interface fa0/1
 switchport mode access
 switchport port-security
 switchport port-security maximum 1
 switchport port-security mac-address sticky
 switchport port-security violation shutdown
exit
```

### Проверка
```
show port-security interface fa0/1
```

---

# 🔒 ACL — Access Control List

```
access-list 10 permit 192.168.1.0 0.0.0.255

interface g0/0
 ip access-group 10 in
exit
```

### Проверка
```
show access-lists
```

---

# 📶 Беспроводная сеть

### Настройка SSID
```
dot11 ssid MyWiFi
 authentication open
 vlan 10
exit

interface dot11Radio 0
 ssid MyWiFi
exit
```

### Проверка
```
show wireless ssid summary
```

---

# 🎚 QoS для VoIP

```
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
```

---

# 🏛 Архитектура корпоративных сетей

### SVI + маршрутизация
```
interface vlan 10
 ip address 192.168.10.1 255.255.255.0
 no shutdown
exit

ip routing
```

---

# 🧰 Полезные команды

```
show processes cpu sorted
show processes memory
copy running-config startup-config
copy startup-config running-config
copy running-config tftp:
```

---

# ☎️ IP-телефония

### Voice VLAN
```
interface vlan 10
 description Voice VLAN
 ip address 192.168.10.1 255.255.255.0
exit
```

### Настройка порта
```
interface fa0/10
 switchport voice vlan 10
 switchport access vlan 20
exit
```

### DHCP для телефонов
```
ip dhcp pool VOICE
 network 192.168.10.0 255.255.255.0
 default-router 192.168.10.1
 option 150 ip 192.168.10.10
exit
```

---

# 🌉 Router-on-a-Stick

```
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
```

---

# 📦 DHCP сервер на маршрутизаторе

```
ip dhcp excluded-address 192.168.1.1 192.168.1.10

ip dhcp pool LAN
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.1
 dns-server 8.8.8.8
exit
```

---

# 🌍 NAT

### Static NAT
```
ip nat inside source static 192.168.1.100 203.0.113.1
```

### Dynamic NAT
```
access-list 1 permit 192.168.1.0 0.0.0.255
ip nat pool MYPOOL 203.0.113.100 203.0.113.110 netmask 255.255.255.0
ip nat inside source list 1 pool MYPOOL
```

### PAT
```
ip nat inside source list 1 interface g0/0 overload
```

### Назначение NAT зон
```
interface g0/0
 ip nat outside
exit

interface g0/1
 ip nat inside
exit
```

---

# 📈 SNMP

```
snmp-server community public RO
snmp-server community private RW
```

### Проверка
```
show snmp
```

---

# 🕒 NTP

```
ntp server 192.168.1.100
clock timezone MSK 3
```

### Проверка
```
show clock
show ntp status
```

---

# 🔁 Loopback интерфейс

```
interface loopback0
 ip address 1.1.1.1 255.255.255.255
exit
```

---

# 🛡 Floating static route

```
ip route 0.0.0.0 0.0.0.0 192.168.1.1
ip route 0.0.0.0 0.0.0.0 192.168.2.1 200
```

---

# 🔐 SSH-доступ

```
hostname Router
ip domain-name example.com

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
```

### Проверка
```
show ip ssh
```

---

# 💥 Сброс конфигурации

```
write erase
reload
```

---

# 🧪 Диагностика

```
show running-config
show startup-config
show cdp neighbors
show cdp neighbors detail
show lldp neighbors
```
