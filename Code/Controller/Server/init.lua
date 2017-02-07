-- Rui Santos
-- Complete project details at http://randomnerdtutorials.com
--- ESP8266 Server


LED = 4

CLK = 7
LATCH = 6
MOSI = 5

inputs = 0
blinker = 1

gpio.mode(LED, gpio.OUTPUT)
gpio.mode(CLK, gpio.OUTPUT)
gpio.mode(MOSI, gpio.OUTPUT)
gpio.mode(LATCH, gpio.OUTPUT)

print("ESP8266 Controller Server TCP 1.01")

wifi.setmode(wifi.STATIONAP);
wifi.ap.config({ssid="Controller",pwd="nXdyKnM484Bm9QKd"});
print("Server IP Address:",wifi.ap.getip())

sv = net.createServer(net.TCP) 
sv:listen(80, function(conn)
    conn:on("receive", function(conn, receivedData) 
        --print("Received Data: " .. receivedData)   
        print(receivedData)
        --shiftOut()       
    end) 
    conn:on("sent", function(conn) 
      collectgarbage()
    end)
end)  

tmr.alarm(1, 50, 1, function()
--function shiftOut()

    outputs = 0

    for i = 0, 15, 1
    do
        if outputs == 1 then
            outputs = 0
            gpio.write(MOSI, 1)
        else
            outputs = 1
            gpio.write(MOSI, 0)
        end
        gpio.write(CLK, 1)
        gpio.write(CLK, 0)
    end
    
    gpio.write(LATCH, 1)
    gpio.write(LATCH, 0)

--end
end)

function lShift(x, by)
    return x * 2 ^ by
end
