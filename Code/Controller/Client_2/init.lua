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

print("ESP8266 Controller Client UDP 1.05")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
--wifi.sta.config("Controller","nXdyKnM484Bm9QKd") -- connecting to server
wifi.sta.config("Controller","") -- connecting to server
wifi.sta.connect()
print("Looking for a connection")

tmr.alarm(1, 500, 1, function()
     if(wifi.sta.getip()~=nil) then
          tmr.stop(1)
          print("Connected to IP Address:",wifi.sta.getip())
          cl=net.createConnection(net.UDP, 0)
          cl:connect(5000, "192.168.4.1")
          gpio.write(LED, 1)      
          tmr.alarm(2, 15, 1, readSPI)
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

    local dataOut = "[" --Start of string

    gpio.write(LATCH, 1)
    gpio.write(LATCH, 0)

    inputs = 0

    for i = 1, 16, 1
    do
        if gpio.read(MISO) == 1 then    --Add to string
            dataOut = dataOut .. "1"
        else
            dataOut = dataOut .. "0"
        end
        --inputs = lShift(inputs, 1) + gpio.read(MISO)
        gpio.write(CLK, 1)
        gpio.write(CLK, 0)
    end
    
    dataOut = dataOut .. "]"    --End of string
    --print(inputs)

    --cl:send(inputs)
    cl:send(dataOut)            --Send string
    collectgarbage()

end

function lShift(x, by)
    return x * 2 ^ by
end
