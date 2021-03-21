EXE = main
ADA_VERSION = -gnat12
GPIO_DIR = gpio
GPIO = $(GPIO_DIR)/gpio_raspberrypi.adb 
SPI_DIR = spi
SPI = $(SPI_DIR)/spi.adb
DISPLAY_DIR = display
DISPLAY = $(DISPLAY_DIR)/ssd1306.adb 
TYPES_DIR = types
TYPES = $(SPI_DIR)/ctypes.ads

SRC = main.adb $(SPI) $(GPIO) $(DISPLAY) 
INCLUDE = -I$(SPI_DIR) -I$(GPIO_DIR) -I$(TYPES_DIR) -I$(DISPLAY_DIR)
FLAGS = -gnato -gnatwa -fstack-check -g

all:
	gcc -c  $(SPI_DIR)/c_spi.c 
	gnatmake  $(ADA_VERSION) $(FLAGS) $(INCLUDE) $(SRC) -largs c_spi.o  --LINK=gcc  


clean:
	rm *.ali *~ *.o b~* $(EXE)  $(SPI_DIR)/*~ $(GPIO_DIR)/*~ $(TYPES_DIR)/*~ $(DISPLAY_DIR)/*~
