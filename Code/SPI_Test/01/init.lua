print("SPI TEST")

local MISO = 5            --> GPIO14
local CLK = 6             --> GPIO12
local CS = 7              --> GPIO13
local duration = 3000     --> 3 seconds
local i = 0
local result = 0

-- Pin Initialization
gpio.mode(CS, gpio.OUTPUT)
gpio.mode(CLK, gpio.OUTPUT)
gpio.mode(MISO, gpio.INPUT)
gpio.write(CS,gpio.HIGH)

-- Function to read SPI
function readSPI()
    gpio.write(CS, gpio.LOW)      -->Activate the chip 
    tmr.delay(1)                  -->1us Delay

    gpio.write(CLK, gpio.HIGH)    -->First bit is dummy, ignore it(refer MAX6675 datasheet)
    tmr.delay(2)
    gpio.write(CLK, gpio.LOW)
    tmr.delay(2)

    result = 0
    
   for i=15,1,-1 
    do 
      result = bit.lshift(result, 1)
      result = bit.bor(result ,(bit.band(gpio.read(MISO),0x01)))
      gpio.write(CLK, gpio.HIGH)    
      tmr.delay(2)
      gpio.write(CLK, gpio.LOW)
      tmr.delay(2)
    end
    if(bit.isset(result,2)) then 
        print("Sensor not connected")
        gpio.write(CS, gpio.HIGH)
        do return end
    end
        
    gpio.write(CS, gpio.HIGH)
    print(bit.rshift(result,3)*0.25)

end

-- Create an interval
tmr.alarm(0, duration, 1, readSPI)



