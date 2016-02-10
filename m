From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v4 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Tue, 9 Feb 2016 17:40:07 -0800
Message-ID: <1455068407-11863-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:43728 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754382AbcBJBkQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 20:40:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

This is the v4 patch series which fixes the issues identified in the
previous patch series. These include:

- Use devm_request_threaded_irq since I have forgotten to add a free_irq
  when I moved irq handling into the transport drivers.
- This patch series also includes Linus Walleij's changes to get the
  trigger type from the irq data from spi and i2c.
- The device tree bindings have been updated to use the appropriate
  timeout suffixes.
- Moved spi-tx-delay-us and spi-rx-delay-us to be common SPI properties.

Thanks,
Andrew

Andrew Duggan (10):
  Input: synaptics-rmi4: Add support for Synaptics RMI4 devices
  Input: synaptics-rmi4: Add I2C transport driver
  Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
  Input: synaptics-rmi4: Add support for 2D sensors and F11
  Input: synaptics-rmi4: Add device tree support for 2d sensors and F11
  Input: synaptics-rmi4: Add support for F12
  Input: synaptics-rmi4: Add support for F30
  Input: synaptics-rmi4: Add SPI transport driver
  Input: synaptics-rmi4: Add device tree support to the SPI transport
    driver
  HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4

 .../bindings/input/rmi4/rmi_2d_sensor.txt          |   56 +
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   39 +
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   53 +
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   57 +
 .../bindings/input/touchscreen/touchscreen.txt     |    2 +
 Documentation/devicetree/bindings/spi/spi-bus.txt  |    2 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/hid/Kconfig                                |    2 +-
 drivers/hid/hid-rmi.c                              |  891 ++-----------
 drivers/input/Kconfig                              |    2 +
 drivers/input/Makefile                             |    2 +
 drivers/input/rmi4/Kconfig                         |   63 +
 drivers/input/rmi4/Makefile                        |   13 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  329 +++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |   87 ++
 drivers/input/rmi4/rmi_bus.c                       |  422 +++++++
 drivers/input/rmi4/rmi_bus.h                       |  182 +++
 drivers/input/rmi4/rmi_driver.c                    | 1055 ++++++++++++++++
 drivers/input/rmi4/rmi_driver.h                    |  105 ++
 drivers/input/rmi4/rmi_f01.c                       |  624 ++++++++++
 drivers/input/rmi4/rmi_f11.c                       | 1317 ++++++++++++++++++++
 drivers/input/rmi4/rmi_f12.c                       |  457 +++++++
 drivers/input/rmi4/rmi_f30.c                       |  408 ++++++
 drivers/input/rmi4/rmi_i2c.c                       |  398 ++++++
 drivers/input/rmi4/rmi_spi.c                       |  590 +++++++++
 include/linux/rmi.h                                |  359 ++++++
 include/uapi/linux/input.h                         |    1 +
 27 files changed, 6699 insertions(+), 818 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
 create mode 100644 drivers/input/rmi4/Kconfig
 create mode 100644 drivers/input/rmi4/Makefile
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h
 create mode 100644 drivers/input/rmi4/rmi_bus.c
 create mode 100644 drivers/input/rmi4/rmi_bus.h
 create mode 100644 drivers/input/rmi4/rmi_driver.c
 create mode 100644 drivers/input/rmi4/rmi_driver.h
 create mode 100644 drivers/input/rmi4/rmi_f01.c
 create mode 100644 drivers/input/rmi4/rmi_f11.c
 create mode 100644 drivers/input/rmi4/rmi_f12.c
 create mode 100644 drivers/input/rmi4/rmi_f30.c
 create mode 100644 drivers/input/rmi4/rmi_i2c.c
 create mode 100644 drivers/input/rmi4/rmi_spi.c
 create mode 100644 include/linux/rmi.h

-- 
2.5.0

