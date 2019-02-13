From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 00/11] mfd: add support for max77650 PMIC
Date: Wed, 13 Feb 2019 14:43:24 +0100
Message-ID: <20190213134335.10838-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds support for max77650 ultra low-power PMIC. It provides
the core mfd driver and a set of five sub-drivers for the regulator,
power supply, gpio, leds and input subsystems.

Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devices().
Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for this
device.

The regulator part has already been picked up into the regulator tree.

v1 -> v2:
=========

General:
- use C++ style comments for the SPDX license identifier and the
  copyright header
- s/MODULE_LICENSE("GPL")/MODULE_LICENSE("GPL v2")/
- lookup the virtual interrupt numbers in the MFD driver, setup
  resources for child devices and use platform_get_irq_byname()
  in sub-drivers
- picked up review tags
- use devm_request_any_context_irq() for interrupt requests

LEDs:
- changed the max77650_leds_ prefix to max77650_led_
- drop the max77650_leds structure as the only field it held was the
  regmap pointer, move said pointer to struct max77650_led
- change the driver name to "max77650-led"
- drop the last return value check and return the result of
  regmap_write() directly
- change the labeling scheme to one consistent with other LED drivers

ONKEY:
- drop the key reporting helper and call the input functions directly
  from interrupt handlers
- rename the rv local variable to error
- drop parent device asignment

Regulator:
- drop the unnecessary init_data lookup from the driver code
- drop unnecessary include

Charger:
- disable the charger on driver remove
- change the power supply type to POWER_SUPPLY_TYPE_USB

GPIO:
- drop interrupt support until we have correct implementation of hierarchical
  irqs in gpiolib

v2 -> v3:
=========

General:
- dropped regulator patches as they're already in Mark Brown's branch

LED:
- fix the compatible string in the DT binding example
- use the max_brightness property
- use a common prefix ("MAX77650_LED") for all defines in the driver

MFD:
- add the MODULE_DEVICE_TABLE()
- add a sentinel to the of_device_id array
- constify the pointers to irq names
- use an enum instead of defines for interrupt indexes

v3 -> v4:
=========

GPIO:
- as discussed with Linus Walleij: the gpio-controller is now part of
  the core mfd module (we don't spawn a sub-node anymore), the binding
  document for GPIO has been dropped, the GPIO properties have been
  defined in the binding document for the mfd core, the interrupt
  functionality has been reintroduced with the irq directly passed from
  the mfd part
- due to the above changes the Reviewed-by tag from Linus was dropped

v4 -> v5:
=========

General:
- add a patch documenting mfd_add_devices()

MFD:
- pass the regmap irq_chip irq domain to mfd over mfd_add_devices so that
  the hw interrupts from resources can be correctly mapped to virtual irqs
- remove the enum listing cell indexes
- extend Kconfig help
- add a link to the programming manual
- use REGMAP_IRQ_REG() for regmap interrupts (except for GPI which has
  is composed of two hw interrupts for rising and falling edge)
- add error messages in probe
- use PLATFORM_DEVID_NONE constant in devm_mfd_add_devices()
- set irq_base to 0 in regmap_add_irq_chip() as other users to, it's only
  relevant if it's > 0

Charger:
- use non-maxim specific property names for minimum input voltage and current
  limit
- code shrink by using the enable/disable charger helpers everywhere
- use more descriptive names for constants

Onkey:
- use EV_SW event type for slide mode

LED:
- remove stray " from Kconfig help

Bartosz Golaszewski (11):
  dt-bindings: mfd: add DT bindings for max77650
  dt-bindings: power: supply: add DT bindings for max77650
  dt-bindings: leds: add DT bindings for max77650
  dt-bindings: input: add DT bindings for max77650
  mfd: core: document mfd_add_devices()
  mfd: max77650: new core mfd driver
  power: supply: max77650: add support for battery charger
  gpio: max77650: add GPIO support
  leds: max77650: add LEDs support
  input: max77650: add onkey support
  MAINTAINERS: add an entry for max77650 mfd driver

 .../bindings/input/max77650-onkey.txt         |  26 ++
 .../bindings/leds/leds-max77650.txt           |  57 +++
 .../devicetree/bindings/mfd/max77650.txt      |  47 +++
 .../power/supply/max77650-charger.txt         |  27 ++
 MAINTAINERS                                   |  14 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-max77650.c                  | 190 ++++++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/max77650-onkey.c           | 131 +++++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max77650.c                  | 147 ++++++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77650.c                        | 234 ++++++++++++
 drivers/mfd/mfd-core.c                        |  14 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77650-charger.c       | 353 ++++++++++++++++++
 include/linux/mfd/max77650.h                  |  59 +++
 22 files changed, 1347 insertions(+)
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
2.20.1
