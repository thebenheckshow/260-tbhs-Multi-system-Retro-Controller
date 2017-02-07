-- Controller
-- Server 2
-- https://bigdanzblog.wordpress.com/2015/04/16/esp8266-readingwriting-gpio-and-transmittingreceiving-udp-packets/
-- http://stackoverflow.com/questions/36768381/esp8266-nodemcu-soft-ap-udp-server-like-soft-ap-independent-access-point
--- ESP8266 Server


LED = 4

CLK = 7
LATCH = 6
MOSI = 5

--inputs = 0
--blinker = 1

gpio.mode(LED, gpio.OUTPUT)
gpio.mode(CLK, gpio.OUTPUT)
gpio.mode(MOSI, gpio.OUTPUT)
gpio.mode(LATCH, gpio.OUTPUT)

print("ESP8266 Controller Server UDP 1.03")

wifi.setmode(wifi.STATIONAP);
wifi.ap.config({ssid="Controller",pwd="nXdyKnM484Bm9QKd"});
print("Server IP Address:",wifi.ap.getip())

srv=net.createServer(net.UDP)
srv:on("receive", function(srv, receivedData)
   --print(receivedData)
   shiftOut()
   collectgarbage()
   end)
srv:listen(5000)
--collectgarbage()

function shiftOut()

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
    
    --collectgarbage()

--end
end


--srv:listen(5000, function(conn)
--   conn:on("receive", function(conn, receivedData) 
--      print("Received Data: " .. receivedData)   
--        --print(receivedData)    
--   end) 
--    conn:on("sent", function(conn) 
 --    collectgarbage()
--   end)
--end) 
