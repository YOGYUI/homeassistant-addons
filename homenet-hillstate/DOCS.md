# 애드온 설정 방법
앱 구동에 필요한 파라미터들을 HA 애드온 `구성`에서 설정할 수 있다<br>
(애드온 사용법 예시는 [개발자 블로그](https://yogyui.tistory.com/entry/Home-Assistant-add-on-%EA%B0%9C%EB%B0%9C-%EC%9D%BC%EC%A7%80-2-%EB%B2%A0%ED%83%80%EB%B2%84%EC%A0%84-%EB%A6%B4%EB%A6%AC%EC%A6%88) 참고)

### MQTT 브로커 설정
```yaml
mqtt_broker:
  host: core-mosquitto
  port: 1883
  username: username
  password: password
  client_id: yogyui_hyundai_ht
  tls_enable: false
  tls_ca_certs: /config/ssl/cacert.pem
  tls_certfile: /config/ssl/fullchain.pem
  tls_keyfile: /config/ssl/privkey.pem
```
- host: MQTT 브로커 호스트 주소 (ip주소 혹은 dns)
- port: MQTT 브로커 TCP 포트 번호 (default 1883)
- username: MQTT 브로커 접속 계정
- password: MQTT 브로커 계정 패스워드
- client_id: MQTT 브로커에 접속할 클라이언트 아이디
- tls_enable: TLS/SSL 보안접속 활성화 여부
- tls_ca_certs: CA 인증서 파일 경로
- tls_certfile: 클라이언트 인증서 파일 경로 (PEM 인코딩)
- tls_keyfile: 클라이언트 개인키 파일 경로 (PEM 인코딩)

`NOTE`: HA의 [mosquitto 애드온](https://github.com/home-assistant/addons/tree/master/mosquitto)을 사용하지 않을 경우 host를 적절하게 수정해줘야 한다<br>
`TODO`: ssl 보안 접속 기능은 향후 추가 예정<br>

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
    check_connection: true
    cmd_interval_ms: 100
    cmd_retry_count: 50
```
- name: 컨버터 이름 (로그에 찍히는 이름), 아무렇게나 임의로 정하면 됨
- index: 0부터 시작해 컨버터 순서대로 1씩 증가해야 함, 기기간 중복되면 안됨
- enable: `false` 설정 시 해당 컨버터는 동작하지 않음
- hwtype: 
  - `0`일 경우 **USB-to-RS485** 컨버터 (PC와 연결된 기기) <br>
    아래 설정들만 유효하게 적용된다
    - serial: 디바이스 이름 (ex: /dev/ttyUSB0)
    - baudrate: 보레이트 (9600, 115200 등)
    - databit: 데이터비트 (5, 6, 7, 8 중 하나의 값)
    - parity: 패리티비트 ("N", "O", "E" 중 하나의 문자)
    - stopbits: 스탑비트 (1, 1.5, 2 중 하나의 값)
  - `1`일 경우 EW-11과 같은 네트워크 소켓 통신 타입 컨버터 <br>
    아래 설정들만 유효하게 적용됨
    - socketaddr: 기기의 IP 주소
    - socketport: 기기의 TCP 포트 번호
- packettype: `0` (`1`일 경우 주방 비디오폰용으로 사용해야 함)
- check_connection: 주기적으로 연결 상태 확인(패킷 송수신 여부) 및 재접속 시도 여부
- cmd_interval_ms: 명령 패킷 반복 전송 간격 (단위: 밀리세컨드, 지정하지 않을 시 default값은 100ms)
- cmd_retry_count: 명령 패킷 반복 전송 횟수 (상태 변경 응답 확인 시 종료, 지정하지 않을 시 default값은 50회)

`NOTE`: 와이파이 컨버터의 경우 현재 TCP 소켓 통신만 지원함
`NOTE`: 2개 이상의 컨버터를 사용하고자 하는 경우 설정을 아래와 같이 추가해줘야 함
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
    - name: port2
      index: 1
      enable: true
      hwtype: 0
      packettype: 0
      serial: /dev/ttyUSB1
      baudrate: 9600
      databit: 8
      parity: "N"
      stopbits: 1
      socketaddr: 127.0.0.1
      socketport: 8899
  ```

### 디바이스 자동 탐색 설정
```yaml
discovery:
  activate: false
  prefix: homeassistant
  timeout: 60
```
- activate: `true`일 경우 RS-485 패킷을 해석해 기기들을 자동으로 추가됨(**discovery 완료 후 자동으로 false로 전환됨**)
- prefix: HA MQTT 애드온의 디바이스 디스커버리 접두어 (따로 설정하지 않았을 경우 `homeassistant`로 그대로 두면 됨)
- timeout: 디바이스 자동 탐색 시간 (시간이 지난 후 앱이 자동으로 재시작되며, **자동으로 discovery 기능은 deactivate됨**)

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
  emotionlight: 0
  dimminglight: 0
```
- light: 전등 장비(일반조명)와 연결된 RS-485 컨버터의 `index` 값
- outlet: 콘센트 장비와 연결된 RS-485 컨버터의 `index` 값
- gasvalve: 가스 밸브 장비와 연결된 RS-485 컨버터의 `index` 값
- thermostat: 난방 장비와 연결된 RS-485 컨버터의 `index` 값
- ventilator: 환기(전열교환기) 장비와 연결된 RS-485 컨버터의 `index` 값
- airconditioner: 에어컨 장비와 연결된 RS-485 컨버터의 `index` 값
- elevator: 엘리베이터 장비와 연결된 RS-485 컨버터의 `index` 값
- subphone: 주방 비디오폰 장비와 연결된 RS-485 컨버터의 `index` 값
- batchoffsw: 일괄 소등 장비와 연결된 RS-485 컨버터의 `index` 값
- hems: 주방 비디오폰 장비와 연결된 RS-485 컨버터의 `index` 값
- emotionlight: 감성조명과 연결된 RS-485 컨버터의 `index` 값
- dimminglight: 디밍조명과 연결된 RS-485 컨버터의 `index` 값

`NOTE`: 2개 이상의 컨버터가 연결된 경우, 각 컨버터의 인덱스 값을 매핑해줘야 한다.<br>
각각의 RS-485 포트가 어떤 장비와의 통신을 담당하는지 사전에 알고 있어야 한다.

### 주기적 쿼리 패킷 전송 설정
월패드가 연결된 기기들에게 평소에 쿼리 패킷을 주기적으로 전송하지 않는 경우 사용
```yaml
periodic_query_state:
  enable: false
  period: 1000
  verbose: false
```
- enable: 1일 경우 주기적으로 쿼리 패킷을 순차적으로 전송
- period: 쿼리 주기 (단위: ms, 1000 = 1초)
- verbose: 로그 기록 여부 (디버깅용)

### 기타 설정
```yaml
etc: 
  thermo_len_per_dev: 3
  thermostat_range_min: 18
  thermostat_range_max: 35
  airconditioner_range_min: 18
  airconditioner_range_max: 35
  elevator_packet_call_type: 0
  elevator_check_command_method: 0
  elevator_packet_command_call_down_value: 6
  elevator_verbose_packet: false
  dimminglight_max_brightness_level: 7
  dimminglight_convert_method: 0
  clear_all_devices: false
  change_device_state_after_command: false
```
- thermo_len_per_dev: 난방 평소 쿼리-응답 패킷의 기기별 패킷 길이 (`3` 혹은 `8`)
- thermostat_range_min: 난방 기기 설정 온도 최소값
- thermostat_range_max: 난방 기기 설정 온도 최대값
- airconditioner_range_min: 에어컨 기기 설정 온도 최소값
- airconditioner_range_max: 에어컨 기기 설정 온도 최대값
- elevator_packet_call_type: 엘리베이터 호출 패킷 타입 (`0` 혹은 `1`) - 개발자에게 문의
- elevator_check_command_method: 엘리베이터 호출 상태 확인 방법 (`0` 혹은 `1`) - 개발자에게 문의
- elevator_packet_command_call_down_value: 엘리베이터 하행 호출 명령값 (`6` 혹은 `7`) - 개발자에게 문의
- elevator_verbose_packet: 엘리베이터 관련 RS-485 패킷 로깅 여부
- dimminglight_max_brightness_level: 디밍조명 최고 밝기 레벨 (`1` ~ `255` 사이 값)
- dimminglight_convert_method: 디밍조명 밝기값 변환 방법 (`0`: 반올림, `1`: 내림, `2`: 올림)
- clear_all_devices: 추가된 모든 RS-485 디바이스를 어플리케이션에서 삭제 (어플리케이션 재시작 후 자동으로 false로 전환됨)<br>
  `Note`: HA의 entry를 삭제하지는 않음
- change_device_state_after_command: 디바이스 상태 변경 명령 직후 해당 명령값으로 갱신할 지 여부

### 주방 비디오폰(Subphone) 설정
```yaml
subphone:
  enable: false
  enable_video_streaming: false
  conf_file_path: /etc/ffserver.conf
  feed_path: http://0.0.0.0:8090/feed.ffm
  input_device: /dev/video0
  frame_rate: 30
  width: 640
  height: 480
  enable_auto_open_front_door: false
  auto_open_front_door_interval: 3
  enable_auto_open_communal_door: false
  auto_open_communal_door_interval: 3
```
- enable: 주방 비디오폰 연동 여부
- enable_video_streaming: 주방 비디오폰의 영상 신호 연동 여부 (FFMpeg + FFServer)
- conf_file_path: FFServer 설정 파일 경로
- feed_path: FFServer 스트리밍 경로
- input_device: 비디오 디바이스 경로
- frame_rate: 스트리밍 프레임율(fps)
- width: 스트리밍 영상의 폭
- height: 스트리밍 영상의 높이
- enable_auto_open_front_door: 세대현관문 초인종 울림 후 자동 열림 기능 활성화 여부 (지정하지 않을 시 default값은 false)
- auto_open_front_door_interval: 세대현관문 초인종 울림 후 자동으로 열리기까지의 시간 (단위: 초, 지정하지 않을 시 default값은 3.0)
- enable_auto_open_communal_door: 공동현관문 초인종 울림 후 자동 열림 기능 활성화 여부 (지정하지 않을 시 default값은 false)
- auto_open_communal_door_interval: 공동현관문 초인종 울림 후 자동으로 열리기까지의 시간 (단위: 초,지정하지 않을 시 default값은 3.0)
