From: Anthony Olech <anthony.olech.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [NEW DRIVER V4 0/7] DA9058 PMIC - please comment on this new driver
Date: Fri, 12 Apr 2013 14:05:29 +0100
Message-ID: <201304121307.r3CD7tDi011782@latitude>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Andrew Jones <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ashish Jangam <ashish.jangam-edWfh0lVHvKWbvRemg0rlA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Andersson <eric.andersson-TStm8jYLEPpl57MIdRCFDg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Michael Krufky <mkrufky-eb9eJ82Ua7k9XoPSrs7Ehg@public.gmane.org>, Paul Gortmaker <p_gortmaker-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Steven Toth <stoth-eb9eJ82Ua7k9XoPSrs7Ehg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is submission attempt number 4 to have this driver included in
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

Tony Olech (at Home) (7):
  DA9058 MFD core driver
  DA9058 ADC driver
  DA9058 ONKEY driver
  DA9058 RTC driver
  DA9058 GPIO driver
  DA9058 HWMON driver
  DA9058 REGULATOR driver

 Documentation/hwmon/da9058           |   38 ++
 drivers/gpio/Kconfig                 |   12 +
 drivers/gpio/Makefile                |    1 +
 drivers/gpio/gpio-da9058.c           |  377 ++++++++++++++
 drivers/hwmon/Kconfig                |   10 +
 drivers/hwmon/Makefile               |    3 +-
 drivers/hwmon/da9058-hwmon.c         |  341 +++++++++++++
 drivers/iio/adc/Kconfig              |   14 +
 drivers/iio/adc/Makefile             |    1 +
 drivers/iio/adc/da9058-adc.c         |  397 +++++++++++++++
 drivers/input/misc/Kconfig           |   10 +
 drivers/input/misc/Makefile          |    1 +
 drivers/input/misc/da9058_onkey.c    |  177 +++++++
 drivers/mfd/Kconfig                  |   18 +
 drivers/mfd/Makefile                 |    3 +
 drivers/mfd/da9058-core.c            |   74 +++
 drivers/mfd/da9058-i2c.c             |   97 ++++
 drivers/mfd/da9058-info.c            |  929 ++++++++++++++++++++++++++++++++++
 drivers/mfd/da9058-irq.c             |   57 +++
 drivers/regulator/Kconfig            |   11 +
 drivers/regulator/Makefile           |    1 +
 drivers/regulator/da9058-regulator.c |  228 +++++++++
 drivers/rtc/Kconfig                  |   10 +
 drivers/rtc/Makefile                 |    1 +
 drivers/rtc/rtc-da9058.c             |  458 +++++++++++++++++
 include/linux/mfd/da9058/bat.h       |   33 ++
 include/linux/mfd/da9058/codec.h     |   22 +
 include/linux/mfd/da9058/conf.h      |   22 +
 include/linux/mfd/da9058/core.h      |   66 +++
 include/linux/mfd/da9058/gpio.h      |   19 +
 include/linux/mfd/da9058/hwmon.h     |   33 ++
 include/linux/mfd/da9058/i2c.h       |   22 +
 include/linux/mfd/da9058/irq.h       |   50 ++
 include/linux/mfd/da9058/onkey.h     |   17 +
 include/linux/mfd/da9058/pdata.h     |   30 ++
 include/linux/mfd/da9058/registers.h |  480 ++++++++++++++++++
 include/linux/mfd/da9058/regulator.h |   33 ++
 include/linux/mfd/da9058/rtc.h       |   17 +
 38 files changed, 4112 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hwmon/da9058
 create mode 100644 drivers/gpio/gpio-da9058.c
 create mode 100644 drivers/hwmon/da9058-hwmon.c
 create mode 100644 drivers/iio/adc/da9058-adc.c
 create mode 100644 drivers/input/misc/da9058_onkey.c
 create mode 100644 drivers/mfd/da9058-core.c
 create mode 100644 drivers/mfd/da9058-i2c.c
 create mode 100644 drivers/mfd/da9058-info.c
 create mode 100644 drivers/mfd/da9058-irq.c
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
end-of-patch for NEW DRIVER V4
