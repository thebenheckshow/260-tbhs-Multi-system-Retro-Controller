-- Controller
-- Server 2
-- https://bigdanzblog.wordpress.com/2015/04/16/esp8266-readingwriting-gpio-and-transmittingreceiving-udp-packets/
-- http://stackoverflow.com/questions/36768381/esp8266-nodemcu-soft-ap-udp-server-like-soft-ap-independent-access-point
--- ESP8266 Server


-- local LED = 4

-- local CLK = 7
-- local LATCH = 6
-- local MOSI = 5

local gpio_write = gpio.write
--inputs = 0
--blinker = 1

--gpio.mode(LED, gpio.OUTPUT)
gpio.mode(7, gpio.OUTPUT)
gpio.mode(5, gpio.OUTPUT)
gpio.mode(6, gpio.OUTPUT)

print("ESP8266 Controller Server UDP 1.06")

wifi.setmode(wifi.STATIONAP);
--wifi.ap.config({ssid="Controller",pwd="nXdyKnM484Bm9QKd",max=1, beacon=1});
wifi.ap.config({ssid="Controller",auth="wifi.OPEN",max=1, beacon=100});
print("Server IP Address:",wifi.ap.getip())

srv=net.createServer(net.UDP)

srv:listen(5000, "192.168.4.1")

srv:on("receive", function(sck, inputs)
    --print(inputs)
          
    gpio_write(6, 0)
              
    for i = 2, 17, 1
    do
        --bitCheck = string.sub(inputs, i,i)
        if string.sub(inputs, i,i)== "1" then
            --outputs = 0
            gpio_write(5, 1)         
        else
            --outputs = 1
            gpio_write(5, 0)         
        end
        
        gpio_write(7, 1)
        gpio_write(7, 0) 
           
    end

    gpio_write(6, 1)

   collectgarbage()   
    
end)

--srv:on("receive", function(receivedData)
----srv:on("connection", function(receivedData)
   --print(receivedData)
   --shiftOut()
   --collectgarbage()
--end)

--srv:listen(5000,"192.168.4.1")

--srv:listen(5000,"192.168.4.1", function(conn)
    --conn:on("receive", function(conn, receivedData)
    --print("Received Data: " .. receivedData)
    --shiftOut()
    --end)
    --conn:on("sent", function(conn)
    --collectgarbage()
    --end)
--end)

--srv:listen(5000, function(conn)
--  conn:on("receive", function(conn, receivedData)
--    print("Received Data: " .. receivedData)
--        --print(receivedData)
--   end)
--   conn:on("sent", function(conn)
--    collectgarbage()
--   end)
--end)
