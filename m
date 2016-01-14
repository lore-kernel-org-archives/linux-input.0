From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Thu, 14 Jan 2016 15:43:31 -0800
Message-ID: <1452815011-22842-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:35799 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756256AbcANXnj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 18:43:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

This is the v2 patch series which fixes the issues identified in the
previous patch series. This time the series is based on v4.4 since
I wanted to keep current. Moving to v4.4 only required a minor change to
hid-rmi.

Benjamin identified some general issues in the first patch series which I
have addressed. First, I changed how function handlers are registered. As
suggested I created a static array of function handlers and functions to
iterate through the array to register and unregister the handlers.
I export the various function handlers which are defined in the the
function drivers. It does simplify the registration of function handlers,
but having to export the function handlers still seems a bit awkward to me.
I'm open any ideas on a better way to do it.

Second, I removed interrupt handling in the rmi core and moved it into
the two transports which which need to handle irqs directly (i2c and spi).
The transport then calls rmi_process_interrupt_requests() when there is
RMI data to process. Either from the irq thread in i2c and spi or from
a callback in the case of HID and soon SMBus.

Third, I removed registration with the pm subsystem from rmi_core and
the function drivers. Instead, transport drivers can call
rmi_driver_suspend / _resume directly from their pm callbacks. The
rmi_driver suspend and resume function then call the suspend and resume
callbacks in the function drivers.

In addition I also made some changes to how logging is done and added
functionaliy to print the firmware id in F01. I also changed the names
of the driver from rmi to rmi4 to be a bit more specific based on Rob
Herring's suggestion on the device tree binding.

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
 Documentation/devicetree/bindings/input/touch.txt  |    2 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/hid/Kconfig                                |    2 +-
 drivers/hid/hid-rmi.c                              |  919 ++------------
 drivers/input/Kconfig                              |    2 +
 drivers/input/Makefile                             |    2 +
 drivers/input/rmi4/Kconfig                         |   82 ++
 drivers/input/rmi4/Makefile                        |   13 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  329 +++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |   87 ++
 drivers/input/rmi4/rmi_bus.c                       |  422 +++++++
 drivers/input/rmi4/rmi_bus.h                       |  185 +++
 drivers/input/rmi4/rmi_driver.c                    | 1052 +++++++++++++++
 drivers/input/rmi4/rmi_driver.h                    |  105 ++
 drivers/input/rmi4/rmi_f01.c                       |  625 +++++++++
 drivers/input/rmi4/rmi_f11.c                       | 1336 ++++++++++++++++++++
 drivers/input/rmi4/rmi_f12.c                       |  462 +++++++
 drivers/input/rmi4/rmi_f30.c                       |  408 ++++++
 drivers/input/rmi4/rmi_i2c.c                       |  395 ++++++
 drivers/input/rmi4/rmi_spi.c                       |  589 +++++++++
 include/linux/rmi.h                                |  363 ++++++
 include/uapi/linux/input.h                         |    1 +
 26 files changed, 6753 insertions(+), 834 deletions(-)
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

