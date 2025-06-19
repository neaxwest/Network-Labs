# 🛠️ Cisco VLAN & Switching

## 📦 Работа с VLAN

```bash
# Создание VLAN
Switch(config)# vlan 10
Switch(config-vlan)# name HR
Switch(config-vlan)# exit

# Назначение access-порта в VLAN
Switch(config)# interface fa0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10

# Проверка VLAN и портов
Switch# show vlan brief

## 🌉 Trunk-порты

# Настройка trunk-порта
Switch(config)# interface fa0/24
Switch(config-if)# switchport mode trunk

# Указание allowed VLANs
Switch(config-if)# switchport trunk allowed vlan 10,20,30

# Назначение native VLAN
Switch(config-if)# switchport trunk native vlan 99

# Проверка trunk-интерфейсов
Switch# show interfaces trunk

## 🔎 Диагностика и MAC-адреса

# Показать MAC-таблицу (CAM table)
Switch# show mac address-table

# Очистить MAC-таблицу
Switch# clear mac address-table dynamic

🔁 🔁 Дополнительно

# Назначить порт обратно в VLAN по умолчанию
Switch(config)# interface fa0/1
Switch(config-if)# switchport access vlan 1

# Назначение порта в режим dynamic desirable
Switch(config)# interface fa0/2
Switch(config-if)# switchport mode dynamic desirable