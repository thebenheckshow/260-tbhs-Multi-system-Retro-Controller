--WORKING TRANSMITTER CLIENT MODULE-9-9-16------------------------------------------

LED = 4

CLK = 7
LATCH = 6
MISO = 5

inputs = 0
blinker = 1

gpio.mode(LED, gpio.OUTPUT)
gpio.mode(CLK, gpio.OUTPUT)
gpio.mode(MISO, gpio.INPUT)
gpio.mode(LATCH, gpio.OUTPUT)

print("ESP8266 Controller Client TCP 1.01")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
wifi.sta.config("Controller","nXdyKnM484Bm9QKd") -- connecting to server
wifi.sta.connect()
print("Looking for a connection")

tmr.alarm(1, 500, 1, function()
     if(wifi.sta.getip()~=nil) then
          tmr.stop(1)
          print("Connected to IP Address:",wifi.sta.getip())
          cl=net.createConnection(net.TCP, 0)
          cl:connect(80, "192.168.4.1")
          gpio.write(LED, 1)
          tmr.alarm(2, 8, 1, readSPI)
      else
         print("Connecting...")
         gpio.write(LED, blinker)
         if blinker == 1 then
            blinker = 0
         else
            blinker = 1
         end
      end
end)

function readSPI()

    gpio.write(LATCH, 1)
    gpio.write(LATCH, 0)

    inputs = 0

    for i = 0, 15, 1
    do
        inputs = lShift(inputs, 1) + gpio.read(MISO)
        gpio.write(CLK, 1)
        gpio.write(CLK, 0)
    end

    --print(inputs)

    cl:send(inputs)

end

function lShift(x, by)
    return x * 2 ^ by
end
