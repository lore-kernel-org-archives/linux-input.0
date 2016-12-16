From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.10-rc0
Date: Fri, 16 Dec 2016 14:35:32 -0800
Message-ID: <20161216223532.GA22632@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34498 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbcLPWfg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 17:35:36 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- updated support for Synaptics RMI4 devices, including support for
  SMBus controllers, firmware update support, sensor tuning, and PS/2
  guest support;
- ALPS driver now supports tracksticks on SS5 controllers;
- i8042 now uses chassis info to skip selftest on Asus laptops as
  list of individual models became too unwieldy;
- miscellaneous fixes to other drivers.

Note that there will be a merge conflict in
drivers/input/rmi4/rmi_driver.c. Please resolve by dropping
linux/kconfig.h include and keeping linux/irq.h

Changelog:
---------

Andrew Duggan (4):
      Input: synaptics-rmi4 - handle incomplete input data
      Input: synaptics-rmi4 - add parameters for dribble packets and palm detect gesture
      Input: synaptics-rmi4 - add support for controlling dribble packets in F12
      Input: synaptics-rmi4 - set the ABS_MT_TOOL_TYPE bit to report tool type

Arnd Bergmann (1):
      Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning

Benjamin Tissoires (12):
      Input: elan_i2c - always output the device information
      Input: synaptics-rmi4 - add SMBus support
      Input: soc_button_array - use gpio_is_valid()
      Input: soc_button_array - bail out earlier if gpiod_count is zero
      Input: synaptics-rmi4 - fix documentation of rmi_2d_sensor_platform_data
      Input: synaptics-rmi4 - remove unused fields in struct rmi_driver_data
      Input: synaptics-rmi4 - add rmi_enable/disable_irq
      Input: synaptics-rmi4 - remove mutex calls while updating the firmware
      Input: synaptics-rmi4 - remove EXPORT_SYMBOL_GPL for internal functions
      Input: synaptics-rmi4 - have only one struct platform data
      Input: synaptics-rmi4 - allow to add attention data
      Input: synaptics-rmi4 - store the attn data in the driver

Bjorn Andersson (1):
      Input: synaptics-rmi4 - move IRQ handling to rmi_driver

Cameron Gutman (2):
      Input: xpad - add product ID for Xbox One S pad
      Input: xpad - fix Xbox One rumble stopping after 2.5 secs

Colin Ian King (2):
      Input: pxa27x_keypad - fix typo "debpunce" -> "debounce"
      Input: raydium_i2c_ts - fix spelling mistake in dev_err message

Dan Carpenter (1):
      Input: synaptics-rmi4 - unlock on error

Dennis Wassenberg (1):
      Input: synaptics-rmi4 - f03 - grab data passed by transport device

Dmitry Torokhov (7):
      Input: gpio_keys_polled - keep button data constant
      Input: gpio_keys_polled - always use gpiod_get_value_cansleep
      Input: gpio_keys - annotate PM methods as __maybe_unused
      Input: gpio_keys - fix leaking DT node references
      Input: gpio_keys - switch to using generic device properties
      Input: drv260x - fix initializing overdrive voltage
      Input: drv260x - use temporary for &client->dev

Florian Vaussard (2):
      Input: drv2665 - fix misuse of regmap_update_bits
      Input: drv2667 - fix misuse of regmap_update_bits

Geert Uytterhoeven (1):
      Input: gpio_keys - add support for GPIO descriptors

Guenter Roeck (2):
      Input: synaptics-rmi4 - add support for F55 sensor tuning
      Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54

Guy Shapiro (3):
      Input: imx6ul_tsc - add support for sample averaging
      Input: imx6ul_tsc - convert int to u32
      Input: imx6ul_tsc - generalize the averaging property

Haibo Chen (1):
      Input: imx6ul_tsc - add mask when set REG_ADC_CFG

Hans de Goede (2):
      Input: bma150 - avoid binding to bma180 if IIO bma180 driver present
      Input: silead - add regulator support

Javier Martinez Canillas (2):
      Input: fsl-imx25-tcq - fix module autoload when registered via OF
      Input: da9063 - fix module autoload when registered via OF

Jingkui Wang (2):
      Input: drv260x - fix input device's parent assignment
      Input: drv260x - use generic device properties

Lyude Paul (1):
      Input: synaptics-rmi4 - add support for F03

Marcos Paulo de Souza (4):
      Input: i8042 - use chassis info to skip selftest on Asus laptops
      Input: i8042 - fix typo from i8042_aux_close to i8042_port_close
      Input: i8042 - comment #else/#endif of CONFIG_PNP
      Input: ALPS - fix protcol -> protocol

Nick Dyer (6):
      Input: synaptics-rmi4 - stop scanning PDT after two empty pages
      Input: synaptics-rmi4 - factor out functions from probe
      Input: synaptics-rmi4 - add a couple of debug lines
      Input: synaptics-rmi4 - add support for F34 device reflash
      Input: synaptics-rmi4 - fix debug for sensor clip
      Input: synaptics-rmi4 - add support for F34 V7 bootloader

Paul Donohue (3):
      Input: ALPS - fix TrackStick support for SS5 hardware
      Input: ALPS - clean up TrackStick handling for SS5 hardware
      Input: ALPS - clean up code for SS5 hardware

Sangwon Jee (3):
      Input: melfas_mip4 - add product_id sysfs attribute
      Input: melfas_mip4 - use product id for firmware name
      Input: melfas_mip4 - add product ID reporting

Steve Twiss (2):
      Input: da9061 - onkey driver
      Input: da9062 - update bindings docs to account for da9061

Sudeep Holla (1):
      Input: gpio_keys - set input direction explicitly

Vladimir Zapolskiy (1):
      Input: lpc32xx-keys - fix invalid error handling of a requested irq


Diffstat:
--------

 .../devicetree/bindings/input/da9062-onkey.txt     |   45 +-
 .../bindings/input/touchscreen/imx6ul_tsc.txt      |    3 +
 .../bindings/input/touchscreen/silead_gsl1680.txt  |    2 +
 .../bindings/input/touchscreen/touchscreen.txt     |    3 +
 drivers/input/joystick/xpad.c                      |    7 +-
 drivers/input/keyboard/gpio_keys.c                 |  190 +--
 drivers/input/keyboard/gpio_keys_polled.c          |  128 +-
 drivers/input/keyboard/lpc32xx-keys.c              |    2 +-
 drivers/input/keyboard/pxa27x_keypad.c             |    2 +-
 drivers/input/keyboard/tca8418_keypad.c            |   21 +-
 drivers/input/misc/Kconfig                         |    7 +-
 drivers/input/misc/bma150.c                        |    9 +-
 drivers/input/misc/da9063_onkey.c                  |    9 +-
 drivers/input/misc/drv260x.c                       |  119 +-
 drivers/input/misc/drv2665.c                       |    6 +-
 drivers/input/misc/drv2667.c                       |    4 +-
 drivers/input/misc/soc_button_array.c              |    8 +-
 drivers/input/mouse/alps.c                         |   56 +-
 drivers/input/mouse/alps.h                         |   24 +-
 drivers/input/mouse/elan_i2c_core.c                |   17 +-
 drivers/input/rmi4/Kconfig                         |   42 +
 drivers/input/rmi4/Makefile                        |    4 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |   10 +-
 drivers/input/rmi4/rmi_2d_sensor.h                 |    2 +
 drivers/input/rmi4/rmi_bus.c                       |   12 +
 drivers/input/rmi4/rmi_bus.h                       |   12 +
 drivers/input/rmi4/rmi_driver.c                    |  420 ++++--
 drivers/input/rmi4/rmi_driver.h                    |   31 +-
 drivers/input/rmi4/rmi_f01.c                       |   12 +-
 drivers/input/rmi4/rmi_f03.c                       |  250 ++++
 drivers/input/rmi4/rmi_f11.c                       |   98 +-
 drivers/input/rmi4/rmi_f12.c                       |  146 ++-
 drivers/input/rmi4/rmi_f30.c                       |   22 +-
 drivers/input/rmi4/rmi_f34.c                       |  516 ++++++++
 drivers/input/rmi4/rmi_f34.h                       |  314 +++++
 drivers/input/rmi4/rmi_f34v7.c                     | 1372 ++++++++++++++++++++
 drivers/input/rmi4/rmi_f54.c                       |   19 +-
 drivers/input/rmi4/rmi_f55.c                       |  131 ++
 drivers/input/rmi4/rmi_i2c.c                       |   74 +-
 drivers/input/rmi4/rmi_smbus.c                     |  447 +++++++
 drivers/input/rmi4/rmi_spi.c                       |   72 +-
 drivers/input/serio/i8042-x86ia64io.h              |   78 +-
 drivers/input/serio/i8042.c                        |    2 +-
 drivers/input/touchscreen/fsl-imx25-tcq.c          |    1 +
 drivers/input/touchscreen/imx6ul_tsc.c             |   83 +-
 drivers/input/touchscreen/melfas_mip4.c            |   51 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |    2 +-
 drivers/input/touchscreen/silead.c                 |   29 +
 include/linux/gpio_keys.h                          |    5 +-
 include/linux/platform_data/drv260x-pdata.h        |   28 -
 include/linux/rmi.h                                |   60 +-
 51 files changed, 4228 insertions(+), 779 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f03.c
 create mode 100644 drivers/input/rmi4/rmi_f34.c
 create mode 100644 drivers/input/rmi4/rmi_f34.h
 create mode 100644 drivers/input/rmi4/rmi_f34v7.c
 create mode 100644 drivers/input/rmi4/rmi_f55.c
 create mode 100644 drivers/input/rmi4/rmi_smbus.c
 delete mode 100644 include/linux/platform_data/drv260x-pdata.h

Thanks!

-- 
Dmitry

