From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver rebased on 4.3
Date: Wed, 25 Nov 2015 16:07:18 -0800
Message-ID: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:3272 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750972AbbKZAHh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 19:07:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>

This is a new patch series which squashes all of the development
history of the RMI4 driver into patches based on functionality. The
first patch adds the core RMI4 functionality needed by all RMI4 devices
and then the additional patches add transport and function drivers for
supporting various devices.

Touchpads which are currently using hid-rmi should have the same
functionality, but now knowledge of RMI is handled in the core instead
of in hid-rmi. These patches also provide basic finger reporting for a
wide range of RMI4 touchscreens connected to I2C and SPI busses.
However, additional work may need to be done to implement product specific
features.

I tried to include all of the feedback I received from the previous
patches I posted. However, I did not come up with a satisfactory solution
for allowing function drivers to be built as modules. I think it is fine
to allow function drivers to be enabled or disabled in the core at build
time. However, if supporting function drivers as modules is a must have
for upstreaming I can continue to try to find a solution. Also, I went
ahead and removed support for polling.

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

 .../bindings/input/rmi4/rmi_2d_sensor.txt          |   55 +
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   40 +
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   53 +
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   57 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/hid/hid-rmi.c                              |  922 ++-----------
 drivers/input/Kconfig                              |    2 +
 drivers/input/Makefile                             |    2 +
 drivers/input/rmi4/Kconfig                         |   94 ++
 drivers/input/rmi4/Makefile                        |   15 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  323 +++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |   88 ++
 drivers/input/rmi4/rmi_bus.c                       |  419 ++++++
 drivers/input/rmi4/rmi_bus.h                       |  195 +++
 drivers/input/rmi4/rmi_driver.c                    | 1112 ++++++++++++++++
 drivers/input/rmi4/rmi_driver.h                    |  126 ++
 drivers/input/rmi4/rmi_f01.c                       |  570 ++++++++
 drivers/input/rmi4/rmi_f11.c                       | 1354 ++++++++++++++++++++
 drivers/input/rmi4/rmi_f12.c                       |  487 +++++++
 drivers/input/rmi4/rmi_f30.c                       |  419 ++++++
 drivers/input/rmi4/rmi_i2c.c                       |  270 ++++
 drivers/input/rmi4/rmi_spi.c                       |  464 +++++++
 include/linux/rmi.h                                |  415 ++++++
 include/uapi/linux/input.h                         |    1 +
 24 files changed, 6638 insertions(+), 846 deletions(-)
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

