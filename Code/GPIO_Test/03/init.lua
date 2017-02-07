print("GPIO TEST")
lighton = 0

CLK = 5             --> GPIO12
MISO = 6
MOSI = 7
CS = 8              --> GPIO13

test = 4

gpio.mode(test, gpio.OUTPUT)

tmr.alarm(1, 8, 1, function()
   if lighton == 0 then
     lighton = 1
     --gpio.write(MISO, gpio.LOW)
     gpio.write(test, gpio.LOW)

     --print("\tGPIO LOW\n")
   else
   
     lighton = 0

     gpio.write(test, gpio.HIGH)
     
    end
   end)
