! hostname и базовые настройки
hostname ASAv-LAB
enable password YOUR_PASSWORD pbkdf2
names

! Интерфейсы
interface GigabitEthernet0/0
nameif printer
security-level 30
ip address 192.168.2.1 255.255.255.0
!
interface GigabitEthernet0/1
nameif dmz
security-level 50
ip address 192.168.3.1 255.255.255.0
!
interface GigabitEthernet0/2
nameif inside
security-level 100
ip address 192.168.1.1 255.255.255.0
!
interface GigabitEthernet0/3
nameif outside
security-level 0
ip address 10.10.10.1 255.255.255.0
!
same-security-traffic permit inter-interface
same-security-traffic permit intra-interface

! NAT (NO NAT для всего)
object network NO_NAT_ALL
subnet 0.0.0.0 0.0.0.0
nat (inside,printer) source static NO_NAT_ALL NO_NAT_ALL no-proxy-arp

! ACLs

! INSIDE → OUTSIDE: только ICMP
access-list INSIDE_IN extended permit icmp any any
access-list INSIDE_IN extended deny ip any any log

! INSIDE → DMZ: только HTTP
access-list INSIDE_IN extended permit tcp any 192.168.3.0 255.255.255.0 eq www

! INSIDE → PRINTER: только ICMP
access-list INSIDE_IN extended permit icmp any 192.168.2.0 255.255.255.0

! OUTSIDE → DMZ: TCP 80
access-list OUTSIDE_IN extended permit tcp any 192.168.3.0 255.255.255.0 eq www
access-list OUTSIDE_IN extended permit ip any any

! DMZ → OUTSIDE: ICMP
access-list DMZ_IN extended permit icmp any 10.10.10.0 255.255.255.0
access-list DMZ_IN extended permit ip any any

! PRINTER: запрет инициирования трафика
access-list PRINTER_IN extended deny ip any any log

! Применение ACL к интерфейсам
access-group INSIDE_IN in interface inside
access-group DMZ_IN in interface dmz
access-group OUTSIDE_IN in interface outside
access-group PRINTER_IN in interface printer

! Политики инспекции (по умолчанию)
class-map inspection_default
match default-inspection-traffic
policy-map global_policy
class inspection_default
inspect icmp
inspect http
service-policy global_policy global
