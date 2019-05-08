From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, GPIO, Input, LEDs and Power
 due for the v5.2 merge window
Date: Wed, 8 May 2019 12:11:18 +0100
Message-ID: <20190508111118.GR3995@dell>
References: <20190423090451.23711-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-input-leds-power-v5.2

for you to fetch changes up to 796fad0101d370567c2968bd933b865aa57efaa3:

  MAINTAINERS: Add an entry for MAX77650 PMIC driver (2019-05-08 12:07:12 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO, Input, LEDs and Power due for the v5.2 merge window

----------------------------------------------------------------
Bartosz Golaszewski (11):
      dt-bindings: mfd: Add DT bindings for max77650
      dt-bindings: power: supply: Add DT bindings for max77650
      dt-bindings: leds: Add DT bindings for max77650
      dt-bindings: input: Add DT bindings for max77650
      mfd: mfd-core: Document mfd_add_devices()
      mfd: Add new driver for MAX77650 PMIC
      power: supply: max77650: Add support for battery charger
      gpio: max77650: Add GPIO support
      leds: max77650: Add LEDs support
      input: max77650: Add onkey support
      MAINTAINERS: Add an entry for MAX77650 PMIC driver

 .../devicetree/bindings/input/max77650-onkey.txt   |  26 ++
 .../devicetree/bindings/leds/leds-max77650.txt     |  57 ++++
 Documentation/devicetree/bindings/mfd/max77650.txt |  46 +++
 .../bindings/power/supply/max77650-charger.txt     |  28 ++
 MAINTAINERS                                        |  14 +
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77650.c                       | 190 +++++++++++
 drivers/input/misc/Kconfig                         |   9 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max77650-onkey.c                | 121 +++++++
 drivers/leds/Kconfig                               |   6 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-max77650.c                       | 147 ++++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77650.c                             | 232 +++++++++++++
 drivers/mfd/mfd-core.c                             |  13 +
 drivers/power/supply/Kconfig                       |   7 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77650-charger.c            | 368 +++++++++++++++++++++
 include/linux/mfd/max77650.h                       |  59 ++++
 22 files changed, 1349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
