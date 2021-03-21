/**************************************************************************
--                Raspberry Pi SSD1306 interface
-- 
--           Copyright (C) 2020 By Ulrik Hørlyk Hjort
--
--  This Program is Free Software; You Can Redistribute It and/or
--  Modify It Under The Terms of The GNU General Public License
--  As Published By The Free Software Foundation; Either Version 2
--  of The License, or (at Your Option) Any Later Version.
--
--  This Program is Distributed in The Hope That It Will Be Useful,
--  But WITHOUT ANY WARRANTY; Without Even The Implied Warranty of
--  MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See The
--  GNU General Public License for More Details.
--
-- You Should Have Received A Copy of The GNU General Public License
-- Along with This Program; if not, See <Http://Www.Gnu.Org/Licenses/>.
***************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/spi/spidev.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdint.h>

struct spi_ioc_transfer spi;

/********************************************************************************
 *
 * Open the spi device for writing only (0 or 1) returns SPI handle on success
 *
 ********************************************************************************/
int spi_open (int device, int mode, unsigned int speed, int bits_pr_word) {

  assert((device == 0) || (device == 1));
  
  spi.delay_usecs = 0;
  spi.speed_hz = speed;
  spi.bits_per_word = bits_pr_word;
  spi.rx_buf = 0;

  char device_path[14];
  sprintf(device_path,"/dev/spidev0.%d", device);
    
  int spi_fd = open(device_path, O_RDWR);  
  
  if (spi_fd < 0) {
    perror("Error open SPI device ");
    exit(1);
  }
  
  if (ioctl(spi_fd, SPI_IOC_WR_MODE, &mode) < 0) {
    perror("Error setting SPIMode ");
    exit(1);
  }

  if (ioctl(spi_fd, SPI_IOC_WR_BITS_PER_WORD, &bits_pr_word) < 0) {
    perror("Error setting SPI bits pr word ");
    exit(1);
  }

  if (ioctl(spi_fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed) < 0) {
    perror("Error srtting SPI speed ");
    exit(1);
  }

  return spi_fd;
}

/********************************************************************************
 *
 * Close the spi device (0 or 1)
 *
 ********************************************************************************/
int spi_close (int spi_handle) {

  if (close(spi_handle) < 0) {
    perror("Error closing SPI device");
    exit(1);
  }
  
  return 0;
}

/********************************************************************************
 *
 * Write to the spi device (0 or 1) 
 * Keep cs low parameter (set to 1) keeps the cs low for multiple writes
 *
 ********************************************************************************/
int spi_write(int spi_handle, unsigned char *buffer, int length, int keep_cs_low) {

  spi.tx_buf = (unsigned long)buffer;
  spi.len = length;
  spi.cs_change = keep_cs_low; 
  
  if (ioctl(spi_handle, SPI_IOC_MESSAGE(1), &spi) < 0) {
    perror("Error writing spi data ");
    exit(1);
  }

  return 0;
}

