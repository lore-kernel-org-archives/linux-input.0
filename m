From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.15-rc0
Date: Tue, 14 Nov 2017 10:08:04 -0800
Message-ID: <20171114180804.qmj3eistln7xt3l3@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:44865 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754242AbdKNSII (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 13:08:08 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- 3 new touchscreen drivers: EETI EXC3000, HiDeep, and Samsung S6SY761

- the timer API conversion (setup_timer() -> timer_setup())

- a few drivers swiytched to using managed API for creating custom
  device attributes

- other assorted fixed and cleanups.

Changelog:
---------

Ahmet Inan (1):
      Input: add I2C attached EETI EXC3000 multi touch driver

Andi Shyti (9):
      Input: stmfts - use devm_device_add_group
      Input: elants_i2c - use managed devm_device_add_group
      Input: melfas_mip4 - use managed devm_device_add_group
      Input: raydium_i2c_ts - use managed devm_device_add_group
      Input: rohm_bu21023 - use managed devm_device_add_group
      Input: wdt87xx_i2c - use managed devm_device_add_group
      Input: edt-ft5x06 - use managed devm_device_add_group
      Input: ad7879 - use managed devm_device_add_group
      Input: add support for the Samsung S6SY761 touchscreen

Anthony Kim (1):
      Input: add support for HiDeep touchscreen

Arnd Bergmann (1):
      Input: adxl34x - do not treat FIFO_MODE() as boolean

Colin Ian King (2):
      Input: synaptics-rmi4 - make array rmi_f54_report_type_names static
      Input: mxs-lradc - remove redundant assignment to pointer input

Dan Carpenter (1):
      Input: uinput - unlock on allocation failure in ioctl

Dmitry Torokhov (6):
      Input: elan_i2c - do not clobber interrupt trigger on x86
      Input: uinput - allow FF requests to time out
      Input: uinput - fix coding style in uinput_ioctl_handler()
      Input: uinput - remove uinput_allocate_device()
      Input: uinput - fold header into the driver proper
      Input: ps2-gpio - actually abort probe when connected to sleeping GPIOs

Geert Uytterhoeven (1):
      Input: st1232 - remove obsolete platform device support

Gustavo A. R. Silva (3):
      Input: spaceball - mark expected switch fall-throughs
      Input: sidewinder - mark expected switch fall-throughs
      Input: gamecon - mark expected switch fall-throughs

Kees Cook (8):
      Input: byd - convert to using timer_setup()
      Input: alps - convert to using timer_setup()
      Input: ff_memless - convert to using timer_setup()
      Input: keyboard - convert timers to use timer_setup()
      Input: touchsceen - convert timers to use timer_setup()
      Input: hp_sdc - convert to using timer_setup()
      Input: hil_mlc - convert to using timer_setup()
      Input: convert autorepeat timer to use timer_setup()

Linus Walleij (5):
      Input: gpio_mouse - kill off platform data
      Input: gpio_mouse - rename platform data variables
      Input: gpio_mouse - add DT bindings
      Input: gpio_mouse - convert to use GPIO descriptors
      Input: gpio_mouse - add device tree probing

Marcin Niestroj (1):
      Input: goodix - support gt1151 touchpanel

Nik Nyby (1):
      Input: elan_i2c - remove duplicate ELAN0605 id

Randy Dunlap (1):
      Input: usbtouchscreen - use EXPERT instead of EMBEDDED for EasyTouch

Russell King (3):
      Input: sa1111ps2 - use sa1111_get_irq() to obtain IRQ resources
      Input: sa1111ps2 - remove special sa1111 mmio accessors
      Input: sa1111ps2 - extend test delay

Sean Young (1):
      media: ttpci: remove autorepeat handling and use timer_setup

Simon Budig (2):
      Input: edt-ft5x06 - make distinction between m06/m09/generic more clear
      Input: edt-ft5x06 - implement support for the EDT-M12 series

Vince Kim (1):
      Input: cyttsp4 - avoid overflows when calculating memory sizes

stephen lu (2):
      Input: gpio-keys - convert timers to use timer_setup()
      Input: ad7877 - convert to using timer_setup()

Diffstat:
--------

 .../devicetree/bindings/input/gpio-mouse.txt       |   32 +
 .../bindings/input/touchscreen/exc3000.txt         |   27 +
 .../bindings/input/touchscreen/goodix.txt          |    3 +-
 .../bindings/input/touchscreen/hideep.txt          |   42 +
 .../bindings/input/touchscreen/samsung,s6sy761.txt |   34 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/ff-memless.c                         |    8 +-
 drivers/input/input.c                              |   11 +-
 drivers/input/joystick/gamecon.c                   |    3 +
 drivers/input/joystick/sidewinder.c                |   10 +-
 drivers/input/joystick/spaceball.c                 |    4 +
 drivers/input/keyboard/bf54x-keys.c                |    7 +-
 drivers/input/keyboard/gpio_keys.c                 |    7 +-
 drivers/input/keyboard/imx_keypad.c                |    8 +-
 drivers/input/keyboard/locomokbd.c                 |    7 +-
 drivers/input/keyboard/omap-keypad.c               |    6 +-
 drivers/input/keyboard/snvs_pwrkey.c               |    7 +-
 drivers/input/keyboard/tegra-kbc.c                 |    6 +-
 drivers/input/misc/adxl34x.c                       |    2 +-
 drivers/input/misc/uinput.c                        |  305 +++---
 drivers/input/mouse/alps.c                         |    8 +-
 drivers/input/mouse/byd.c                          |   10 +-
 drivers/input/mouse/elan_i2c_core.c                |   11 +-
 drivers/input/mouse/gpio_mouse.c                   |  206 ++--
 drivers/input/rmi4/rmi_f54.c                       |    2 +-
 drivers/input/serio/hil_mlc.c                      |    4 +-
 drivers/input/serio/hp_sdc.c                       |    5 +-
 drivers/input/serio/ps2-gpio.c                     |    1 +
 drivers/input/serio/sa1111ps2.c                    |   69 +-
 drivers/input/touchscreen/Kconfig                  |   34 +-
 drivers/input/touchscreen/Makefile                 |    3 +
 drivers/input/touchscreen/ad7877.c                 |    6 +-
 drivers/input/touchscreen/ad7879.c                 |   19 +-
 drivers/input/touchscreen/atmel-wm97xx.c           |   10 +-
 drivers/input/touchscreen/cyttsp4_core.c           |   59 +-
 drivers/input/touchscreen/edt-ft5x06.c             |  173 ++-
 drivers/input/touchscreen/elants_i2c.c             |   19 +-
 drivers/input/touchscreen/exc3000.c                |  223 ++++
 drivers/input/touchscreen/goodix.c                 |  125 ++-
 drivers/input/touchscreen/hideep.c                 | 1120 ++++++++++++++++++++
 drivers/input/touchscreen/melfas_mip4.c            |   17 +-
 drivers/input/touchscreen/mxs-lradc-ts.c           |    2 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   18 +-
 drivers/input/touchscreen/rohm_bu21023.c           |   17 +-
 drivers/input/touchscreen/s6sy761.c                |  559 ++++++++++
 drivers/input/touchscreen/st1232.c                 |   16 +-
 drivers/input/touchscreen/stmfts.c                 |    4 +-
 drivers/input/touchscreen/tsc200x-core.c           |    6 +-
 drivers/input/touchscreen/w90p910_ts.c             |    7 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   10 +-
 drivers/media/pci/ttpci/av7110.h                   |    2 +-
 drivers/media/pci/ttpci/av7110_ir.c                |   56 +-
 include/linux/gpio_mouse.h                         |   61 --
 include/linux/platform_data/st1232_pdata.h         |   14 -
 include/linux/uinput.h                             |   81 --
 55 files changed, 2776 insertions(+), 731 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
 create mode 100644 drivers/input/touchscreen/exc3000.c
 create mode 100644 drivers/input/touchscreen/hideep.c
 create mode 100644 drivers/input/touchscreen/s6sy761.c
 delete mode 100644 include/linux/gpio_mouse.h
 delete mode 100644 include/linux/platform_data/st1232_pdata.h
 delete mode 100644 include/linux/uinput.h

Thanks.


-- 
Dmitry
