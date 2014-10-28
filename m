From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 00/15] new locomo driver
Date: Tue, 28 Oct 2014 03:01:53 +0300
Message-ID: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
drivers present in Linux kernel has some problems:

 * It uses custom bus instead of platform bus/mfd core.
 * Device drivers are not well layered/separated.
 * It uses custom gpio accessors instead of using GPIOLIB.

With this patchset I tried to modernise and restructure the LoCoMo driver.
Also I added an experimental SPI driver that will be used by mmc-spi on
Sharp SL-5500 collie devices.

----------------------------------------------------------------
Dmitry Eremin-Solenikov (15):
      mfd: add new driver for Sharp LoCoMo
      GPIO: port LoCoMo gpio support from old driver
      leds: port locomo leds driver to new locomo core
      input: convert LoCoMo keyboard driver to use new locomo core
      video: backlight: add new locomo backlight driver
      video: lcd: add LoCoMo LCD driver
      video: backlight: drop old locomo bl/lcd driver
      ARM: sa1100: make collie use new locomo drivers
      ARM: sa1100: don't preallocate IRQ space for locomo
      ARM: pxa: poodle: use new LoCoMo driver
      sound: soc: poodle: make use of new locomo GPIO interface
      ARM: pxa: poodle: don't preallocate IRQ space for locomo
      ARM: drop old LoCoMo driver
      gpio: locomo: implement per-pin irq handling
      spi: add locomo SPI driver

 arch/arm/common/Kconfig                            |   3 -
 arch/arm/common/Makefile                           |   1 -
 arch/arm/common/locomo.c                           | 914 ---------------------
 arch/arm/mach-pxa/Kconfig                          |   1 -
 arch/arm/mach-pxa/include/mach/poodle.h            |  16 +-
 arch/arm/mach-pxa/poodle.c                         |  23 +-
 arch/arm/mach-sa1100/Kconfig                       |   1 -
 arch/arm/mach-sa1100/collie.c                      | 112 +--
 arch/arm/mach-sa1100/include/mach/collie.h         |  25 +-
 arch/arm/mach-sa1100/include/mach/irqs.h           |  19 +-
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-locomo.c                         | 386 +++++++++
 drivers/input/keyboard/Kconfig                     |   1 -
 drivers/input/keyboard/locomokbd.c                 | 165 ++--
 drivers/leds/Kconfig                               |   1 -
 drivers/leds/leds-locomo.c                         | 104 ++-
 drivers/mfd/Kconfig                                |   8 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/locomo.c                               | 644 +++++++++++++++
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-locomo.c                           | 370 +++++++++
 drivers/video/backlight/Kconfig                    |  14 +-
 drivers/video/backlight/Makefile                   |   3 +-
 drivers/video/backlight/locomo_bl.c                | 171 ++++
 drivers/video/backlight/locomo_lcd.c               | 224 +++++
 drivers/video/backlight/locomolcd.c                | 255 ------
 .../asm/hardware => include/linux/mfd}/locomo.h    | 148 ++--
 sound/soc/pxa/poodle.c                             |  51 +-
 30 files changed, 2185 insertions(+), 1493 deletions(-)
 delete mode 100644 arch/arm/common/locomo.c
 create mode 100644 drivers/gpio/gpio-locomo.c
 create mode 100644 drivers/mfd/locomo.c
 create mode 100644 drivers/spi/spi-locomo.c
 create mode 100644 drivers/video/backlight/locomo_bl.c
 create mode 100644 drivers/video/backlight/locomo_lcd.c
 delete mode 100644 drivers/video/backlight/locomolcd.c
 rename {arch/arm/include/asm/hardware => include/linux/mfd}/locomo.h (55%)
