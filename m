From: Anthony Olech <anthony.olech.opensource@diasemi.com>
Subject: [NEW DRIVER V3 0/8] DA9058 PMIC - please comment on this new driver
Date: Wed, 15 Aug 2012 16:05:25 +0100
Message-ID: <201208151518.q7FFI98a011599@latitude.olech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay1.diasemi.com ([82.210.246.133]:61901 "EHLO
	mailrelay1.diasemi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab2HOPS1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 11:18:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Anton Vorontov <cbou@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Axel Lin <axel.lin@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Andersson <eric.andersson@unixphere.com>, Grant Likely <grant.likely@secretlab.ca>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Michael Krufky <mkrufky@kernellabs.com>, Paul Gortmaker <p_gortmaker@yahoo.com>, Randy Dunlap <rdunlap@xenotime.net>, rtc-linux@googlegroups.com, Samuel Ortiz <sameo@linux.intel.com>, Steven Toth <stoth@kernellabs.com>

This is submission attempt number 3 to have this driver included in
the linux kernel source tree. This is the driver for the Dialog DA9058.

The DA9058 is a low power Power Management Integrated Circuit with extra
functionality. It is a Multi Function Device controlled only from an I2C
bus whose components can raise an interrupt request on a single IRQ line.

The driver for the DA9058 consists of a core (i2c) device driver that
instantiates the individual component device drivers for:

adc - 5 ADC channels
gpio - 2 available pins
onkey - 1 device
regulator - 4 BUCKS, 19 LDO and 3 fixed
rtc - low power clock
hwmon - 5 monitored voltages/temperatures
power - battery information

All the above seven component device drivers depend on the 'core'
component driver, which is number one in the patch series.

This driver has been tested on a Samsung SMDK6410 connected to a Dialog
DA9058 Evaluation Board via one GPIO and a 3-wire I2C connection.

All the components can be builtin to the kernel or compiled as modules.
As far as I can tell, all the latest APIs both for the core driver and
all the component drivers have been adhered to, but if I have missed
something please let me know.

Many thanks,
Anthony Olech, Dialog Semiconductor Ltd.

Tony Olech (at Home) (8):
  DA9058 MFD core driver
  DA9058 ADC driver
  DA9058 ONKEY driver
  DA9058 POWER driver
  DA9058 RTC driver
  DA9058 GPIO driver
  DA9058 HWMON driver
  DA9058 REGULATOR driver

 Documentation/hwmon/da9058           |   30 ++
 drivers/gpio/Kconfig                 |   12 +
 drivers/gpio/Makefile                |    1 +
 drivers/gpio/gpio-da9058.c           |  367 +++++++++++++
 drivers/hwmon/Kconfig                |   10 +
 drivers/hwmon/Makefile               |    1 +
 drivers/hwmon/da9058-hwmon.c         |  425 +++++++++++++++
 drivers/iio/adc/Kconfig              |   10 +
 drivers/iio/adc/Makefile             |    1 +
 drivers/iio/adc/da9058-adc.c         |  397 ++++++++++++++
 drivers/input/misc/Kconfig           |   10 +
 drivers/input/misc/Makefile          |    1 +
 drivers/input/misc/da9058_onkey.c    |  177 +++++++
 drivers/mfd/Kconfig                  |   18 +
 drivers/mfd/Makefile                 |    3 +
 drivers/mfd/da9058-core.c            |   83 +++
 drivers/mfd/da9058-i2c.c             |   97 ++++
 drivers/mfd/da9058-info.c            |  935 ++++++++++++++++++++++++++++++++++
 drivers/mfd/da9058-irq.c             |   56 ++
 drivers/power/Kconfig                |   10 +
 drivers/power/Makefile               |    1 +
 drivers/power/da9058_power.c         |  397 ++++++++++++++
 drivers/regulator/Kconfig            |   11 +
 drivers/regulator/Makefile           |    1 +
 drivers/regulator/da9058-regulator.c |  251 +++++++++
 drivers/rtc/Kconfig                  |   10 +
 drivers/rtc/Makefile                 |    1 +
 drivers/rtc/rtc-da9058.c             |  458 +++++++++++++++++
 include/linux/mfd/da9058/bat.h       |   33 ++
 include/linux/mfd/da9058/codec.h     |   22 +
 include/linux/mfd/da9058/conf.h      |   22 +
 include/linux/mfd/da9058/core.h      |   66 +++
 include/linux/mfd/da9058/gpio.h      |   19 +
 include/linux/mfd/da9058/hwmon.h     |   36 ++
 include/linux/mfd/da9058/i2c.h       |   22 +
 include/linux/mfd/da9058/irq.h       |   50 ++
 include/linux/mfd/da9058/onkey.h     |   17 +
 include/linux/mfd/da9058/pdata.h     |   32 ++
 include/linux/mfd/da9058/registers.h |  480 +++++++++++++++++
 include/linux/mfd/da9058/regulator.h |   33 ++
 include/linux/mfd/da9058/rtc.h       |   17 +
 41 files changed, 4623 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/da9058
 create mode 100644 drivers/gpio/gpio-da9058.c
 create mode 100644 drivers/hwmon/da9058-hwmon.c
 create mode 100644 drivers/iio/adc/da9058-adc.c
 create mode 100644 drivers/input/misc/da9058_onkey.c
 create mode 100644 drivers/mfd/da9058-core.c
 create mode 100644 drivers/mfd/da9058-i2c.c
 create mode 100644 drivers/mfd/da9058-info.c
 create mode 100644 drivers/mfd/da9058-irq.c
 create mode 100644 drivers/power/da9058_power.c
 create mode 100644 drivers/regulator/da9058-regulator.c
 create mode 100644 drivers/rtc/rtc-da9058.c
 create mode 100644 include/linux/mfd/da9058/bat.h
 create mode 100644 include/linux/mfd/da9058/codec.h
 create mode 100644 include/linux/mfd/da9058/conf.h
 create mode 100644 include/linux/mfd/da9058/core.h
 create mode 100644 include/linux/mfd/da9058/gpio.h
 create mode 100644 include/linux/mfd/da9058/hwmon.h
 create mode 100644 include/linux/mfd/da9058/i2c.h
 create mode 100644 include/linux/mfd/da9058/irq.h
 create mode 100644 include/linux/mfd/da9058/onkey.h
 create mode 100644 include/linux/mfd/da9058/pdata.h
 create mode 100644 include/linux/mfd/da9058/registers.h
 create mode 100644 include/linux/mfd/da9058/regulator.h
 create mode 100644 include/linux/mfd/da9058/rtc.h

-- 
end-of-patch for NEW DRIVER V3

