# Home Assistant Add-on: HomeNetwork for Hillstate
힐스테이트 (현대통신) 월패드 RS-485 통신 연동 애드온 설정 방법

## 애드온 설정 (yaml)

### MQTT 브로커 설정

```yaml
mqtt_broker:
  host: 127.0.0.1
  port: 1883
  username: username
  password: password
```
- host:
- port:
- username:
- password: 123

`note: ssl 보안 접속 기능은 향후 추가 예정`

### RS-485 컨버터 설정
```yaml
rs485:
  - name: port1
    index: 0
    enable: true
    hwtype: 0
    packettype: 0
    serial: /dev/ttyUSB0
    baudrate: 9600
    databit: 8
    parity: "N"
    stopbits: 1
    socketaddr: 127.0.0.1
    socketport: 8899
```
- name:
- index:
- enable:
- hwtype:
  - serial:
  - baudrate:
  - databit:
  - parity:
  - socketaddr:
  - socketport: 
- packettype:

### 디바이스 자동 탐색 설정
```yaml
discovery:
  activate: true
  prefix: homeassistant
  timeout: 60
```
- activate:
- prefix:
- timeout:

### 패킷 파서 인덱스 매핑
```yaml
parser_mapping:
  light: 0
  outlet: 0
  gasvalve: 0
  thermostat: 0
  ventilator: 0
  airconditioner: 0
  elevator: 0
  subphone: 0
  batchoffsw: 0
  hems: 0
```
- light:
- outlet:
- gasvalve:
- thermostat:
- ventilator:
- airconditioner:
- elevator:
- subphone:
- batchoffsw:
- hems:

### 기타 설정
