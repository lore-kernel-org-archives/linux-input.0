From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v4 00/18] new MFD LoCoMo driver set
Date: Mon, 25 May 2015 14:41:35 +0300
Message-ID: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-spi@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array.
With this patchset I tried to modernise and restructure the LoCoMo drivers.

* Use platform bus and mfd core code
* Use GPIO API instead of custom locomo GPIO code
* Use irqdomains to manage IRQs
* Split mixed locomolcd driver to lcd and backlight parts
* Implement IRQ handling in GPIO driver
* Implement SPI driver used as a host for mmc_spi device to control SD cards

Changes since v3:
* Removed magic values in locomo irq handling code
* Using mutex in locomokbd driver
* Dropped empty locomokbd_remove
* Small rearrangement of headers/comments/etc in core and input drivers

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/dbaryshkov/zaurus.git locomo-v4

for you to fetch changes up to 7c8e8e05ca27a4ad82356eb57ad12a7ca39bfd95:

  ARM: drop old LoCoMo driver (2015-05-25 14:29:23 +0300)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (18):
      mfd: add new driver for Sharp LoCoMo
      leds: port locomo leds driver to new locomo core
      input: convert LoCoMo keyboard driver to use new locomo core
      input: locomokbd: differentiate between two Enter keys
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
 drivers/input/keyboard/locomokbd.c         | 262 ++++-----
 drivers/leds/Kconfig                       |   2 +-
 drivers/leds/leds-locomo.c                 | 117 ++--
 drivers/mfd/Kconfig                        |  10 +
 drivers/mfd/Makefile                       |   1 +
 drivers/mfd/locomo.c                       | 336 +++++++++++
 drivers/spi/Kconfig                        |  10 +
 drivers/spi/Makefile                       |   1 +
 drivers/spi/spi-locomo.c                   | 332 +++++++++++
 drivers/video/backlight/Kconfig            |  16 +-
 drivers/video/backlight/Makefile           |   3 +-
 drivers/video/backlight/locomo_bl.c        | 153 +++++
 drivers/video/backlight/locomo_lcd.c       | 285 +++++++++
 drivers/video/backlight/locomolcd.c        | 255 --------
 include/linux/mfd/locomo.h                 | 169 ++++++
 sound/soc/pxa/poodle.c                     |  52 +-
 34 files changed, 2205 insertions(+), 1703 deletions(-)
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

