From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/13] mfd: add support for max77650 PMIC
Date: Fri, 18 Jan 2019 14:42:31 +0100
Message-ID: <20190118134244.22253-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds support for max77650 ultra low-power PMIC. It provides
the core mfd driver and a set of five sub-drivers for the regulator,
power supply, gpio, leds and input subsystems.

Patches 1-6 add the DT binding documents. Patches 7-12 add all drivers.
Last patch adds a MAINTAINERS entry for this device.

Note that patch 8/13 depends on commit 03c87b95ac04 ("regulator: provide
rdev_get_regmap()") which was picked up by Mark Brown for v5.1.

Bartosz Golaszewski (13):
  dt-bindings: mfd: add DT bindings for max77650
  dt-bindings: regulator: add DT bindings for max77650
  dt-bindings: power: supply: add DT bindings for max77650
  dt-bindings: gpio: add DT bindings for max77650
  dt-bindings: leds: add DT bindings for max77650
  dt-bindings: input: add DT bindings for max77650
  mfd: max77650: new core mfd driver
  regulator: max77650: add regulator support
  power: supply: max77650: add support for battery charger
  gpio: max77650: add GPIO support
  leds: max77650: add LEDs support
  input: max77650: add onkey support
  MAINTAINERS: add an entry for max77650 mfd driver

 .../bindings/gpio/gpio-max77650.txt           |  34 ++
 .../bindings/input/max77650-onkey.txt         |  26 +
 .../bindings/leds/leds-max77650.txt           |  57 ++
 .../devicetree/bindings/mfd/max77650.txt      |  28 +
 .../power/supply/max77650-charger.txt         |  27 +
 .../bindings/regulator/max77650-regulator.txt |  41 ++
 MAINTAINERS                                   |  14 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-max77650.c                  | 189 ++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/max77650-onkey.c           | 135 +++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max77650.c                  | 162 ++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77650.c                        | 212 +++++++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77650-charger.c       | 347 +++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77650-regulator.c        | 537 ++++++++++++++++++
 include/linux/mfd/max77650.h                  |  73 +++
 26 files changed, 1936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 drivers/regulator/max77650-regulator.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
2.19.1
