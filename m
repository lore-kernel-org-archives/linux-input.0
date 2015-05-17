From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v3 00/17] new LoCoMo driver set
Date: Sun, 17 May 2015 19:27:40 +0300
Message-ID: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array.
With this patchset I tried to modernise and restructure the LoCoMo drivers.

* Use platform bus and mfd core code
* Use GPIO API instead of custom locomo GPIO code
* Use irqdomains to manage IRQs
* Split mixed locomolcd driver to lcd and backlight parts
* Implement IRQ handling in GPIO driver
* Implement SPI driver used as a host for mmc_spi device to control SD cards

Changes since V2:
* Implemented most of review findings (lots of small changes)
* Added comments where the review feedback was ignored

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/dbaryshkov/zaurus.git locomo-v3

for you to fetch changes up to c7405f110836863287c505650ac2133fecabea7b:

  ARM: drop old LoCoMo driver (2015-05-17 19:23:20 +0300)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (17):
      mfd: add new driver for Sharp LoCoMo
      leds: port locomo leds driver to new locomo core
      input: convert LoCoMo keyboard driver to use new locomo core
      input: make LoCoMo keyboard driver support both poodle and collie
      video: backlight: add new locomo backlight driver
      video: lcd: add LoCoMo LCD driver
      gpio: port LoCoMo gpio support from old driver
      gpio: locomo: implement per-pin irq handling
      spi: add locomo SPI driver
      i2c: add locomo i2c driver
      ARM: sa1100: make collie use new locomo drivers
      ARM: sa1100: don't preallocate IRQ space for locomo
      ASoC: pxa: poodle: make use of new locomo GPIO interface
      ARM: pxa: poodle: use new LoCoMo driver
      ARM: pxa: poodle: don't preallocate IRQ space for locomo
      video: backlight: drop old locomo bl/lcd driver
      ARM: drop old LoCoMo driver

 arch/arm/common/Kconfig                    |   3 -
 arch/arm/common/Makefile                   |   1 -
 arch/arm/common/locomo.c                   | 914 -----------------------------
 arch/arm/include/asm/hardware/locomo.h     | 221 -------
 arch/arm/mach-pxa/Kconfig                  |   1 -
 arch/arm/mach-pxa/include/mach/poodle.h    |   8 +-
 arch/arm/mach-pxa/poodle.c                 |  58 +-
 arch/arm/mach-sa1100/Kconfig               |   1 -
 arch/arm/mach-sa1100/collie.c              | 213 +++++--
 arch/arm/mach-sa1100/include/mach/collie.h |  16 +-
 arch/arm/mach-sa1100/include/mach/irqs.h   |  19 +-
 drivers/gpio/Kconfig                       |  13 +
 drivers/gpio/Makefile                      |   1 +
 drivers/gpio/gpio-locomo.c                 | 285 +++++++++
 drivers/i2c/busses/Kconfig                 |  12 +
 drivers/i2c/busses/Makefile                |   1 +
 drivers/i2c/busses/i2c-locomo.c            | 135 +++++
 drivers/input/keyboard/Kconfig             |   2 +-
 drivers/input/keyboard/locomokbd.c         | 264 ++++-----
 drivers/leds/Kconfig                       |   2 +-
 drivers/leds/leds-locomo.c                 | 117 ++--
 drivers/mfd/Kconfig                        |  10 +
 drivers/mfd/Makefile                       |   1 +
 drivers/mfd/locomo.c                       | 346 +++++++++++
 drivers/spi/Kconfig                        |  10 +
 drivers/spi/Makefile                       |   1 +
 drivers/spi/spi-locomo.c                   | 332 +++++++++++
 drivers/video/backlight/Kconfig            |  16 +-
 drivers/video/backlight/Makefile           |   3 +-
 drivers/video/backlight/locomo_bl.c        | 153 +++++
 drivers/video/backlight/locomo_lcd.c       | 285 +++++++++
 drivers/video/backlight/locomolcd.c        | 255 --------
 include/linux/mfd/locomo.h                 | 167 ++++++
 sound/soc/pxa/poodle.c                     |  52 +-
 34 files changed, 2216 insertions(+), 1702 deletions(-)
 delete mode 100644 arch/arm/common/locomo.c
 delete mode 100644 arch/arm/include/asm/hardware/locomo.h
 create mode 100644 drivers/gpio/gpio-locomo.c
 create mode 100644 drivers/i2c/busses/i2c-locomo.c
 create mode 100644 drivers/mfd/locomo.c
 create mode 100644 drivers/spi/spi-locomo.c
 create mode 100644 drivers/video/backlight/locomo_bl.c
 create mode 100644 drivers/video/backlight/locomo_lcd.c
 delete mode 100644 drivers/video/backlight/locomolcd.c
 create mode 100644 include/linux/mfd/locomo.h

-- 
With best wishes
Dmitry

