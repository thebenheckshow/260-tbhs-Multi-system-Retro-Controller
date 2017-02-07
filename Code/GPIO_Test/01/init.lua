print("GPIO TEST")
led1 = 3
led2 = 4
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
while( true )
do(
   gpio.write(led1, gpio.HIGH)
   gpio.write(led2, gpio.LOW)
   tmr.delay(1000)
   gpio.write(led1, gpio.LOW)
   gpio.write(led2, gpio.HIGH)
end)