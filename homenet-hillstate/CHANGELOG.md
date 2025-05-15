## 1.1.7

- add parameter for changing device state right after sending command

## 1.1.6

- add parameter for logging elevator related rs-485 packet

## 1.1.5

- add parameter for calling elevator downside value

## 1.1.4

- add parameters for auto-open front/communal door (kitchen subphone)

## 1.1.3

- add parameters for sending RS-485 command packets (interval and retry count)

## 1.1.2

- add device type: 'Dimming Light' 

## 1.1.1

- add option for periodic checking RS485 instance connection status

## 1.1.0

- add 'Subphone' configuration

## 1.0.9

- add device type: 'Emotion Light' 

## 1.0.8

- bugfix: usb serial converter connection issue
- add 'clear all devices' function
- support mqtt tls/ssl secured connection

## 1.0.7

- run flask app using uwsgi
- implement 'send periodic query state' function

## 1.0.6

- specify git pull strategy (rebase)

## 1.0.5

- automatic deactivate device discovery after action done
- add elevator 'packet call type', 'check command method' options
- add thermostat / elevator range min max options

## 1.0.4

- config.xml container sharing
- apparmor
- document (configuration)

## 1.0.3

- add optional add-on configurations
- chmod run.sh 

## 1.0.2

- change config: remove ports, ports_description

## 1.0.1

- change config: ingress stream as false

## 1.0.0

- Initial release