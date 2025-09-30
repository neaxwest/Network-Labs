$ptPath = "C:\Program Files\Cisco Packet Tracer 8.2.2\bin\PacketTracer.exe"

# Блокируем весь исходящий трафик TCP и UDP
New-NetFirewallRule -DisplayName "Block PacketTracer Outbound All" `
  -Direction Outbound `
  -Program $ptPath `
  -Action Block `
  -Profile Any `
  -Protocol Any

# Блокируем весь входящий трафик TCP и UDP
New-NetFirewallRule -DisplayName "Block PacketTracer Inbound All" `
  -Direction Inbound `
  -Program $ptPath `
  -Action Block `
  -Profile Any `
  -Protocol Any