From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 00/26] Consolidate patches and add support for new devices
Date: Thu, 5 Nov 2015 15:34:00 -0800
Message-ID: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:30529 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965308AbbKEXek (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:34:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

NOTE: This patch set applies to synaptics-rmi4 branch in
Dmitry Torokhov's input tree.

This patch set consolidates some outstanding patches and then builds on
that to add support for new devices. The first 11 patches were provided
by Benjamin Tissoires with slight modifications. The remainder of the
patches remove unused functionality, consolidates the code for
2D sensors, and adds support for newer devices which use F12 for
reporting 2D sensing.

This patchset applies cleanly to the synaptics-rmi4 branch, but does not
successfully build because the synaptics-rmi4 branch is based on the 3.14
kernel and the patches make use of functionality introduced in later
kernels. I would suggest updating the synaptics-rmi4 branch to something
more resent. I also have some additional patches which convert hid-rmi
into a transport driver for rmi_core. I held off submitting since 3.14
doesn't contain hid-rmi. However, if we want to stick with 3.14 I can
make the appropriate modifications.

Thanks,
Andrew

Andrew Duggan (14):
  Input: synaptics-rmi4: Use generic interrupt handling
  Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
  Input: synaptics-rmi4: Clean up Makefile
  Input: synaptics-rmi4: Remove unused debugfs code
  Input: synaptics-rmi4: Use ifdef to check if CONFIG_PM_SLEEP is set
  Input: synaptics-rmi4: Remove unused firmware_name variable
  Input: synaptics-rmi4: Add SPI transport driver
  Input: synaptics-rmi4: Add support for packet register descriptors
  Input: synaptics-rmi4: Create common functions for 2D sensors
  Input: synaptics-rmi4: Add support for F12
  Input: synaptics-rmi4: move structures and definitions to rmi.h
  Input: synaptics-rmi4: use device managed memory for the data packet
    buffer
  Input: synaptics-rmi4: remove sensor_name in platform data
  Input: synaptics-rmi4: Change the rmi device's name to be less generic

Benjamin Tissoires (12):
  Input: synaptics-rmi4 - embed the function modules in rmi_core
  Input: synaptics-rmi4 - add a common input device in rmi_driver
  Input: synaptics-rmi4 - explicitly request polling when needed
  Input: synaptics-rmi4 - prevent oopses when irq arrives while the
    device is not bound
  Input: synaptics-rmi4 - call rmi_driver_process_config_requests in
    enable_sensor
  Input: synaptics-rmi4 - add a reset callback
  Input: synaptics-rmi4 - f11: fix bitmap irq check
  Input: synaptics-rmi4 - f11: use the unified input node if available
  Input: synaptics-rmi4 - f11: clean up rmi_f11_finger_handler
  Input: synaptics-rmi4 - f11: allow the top software button property to
    be set
  Input: synaptics-rmi4 - f11: add support for kernel tracking
  Input: synaptics-rmi4 - Add F30 support

 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  55 +++
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |  40 ++
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  55 +++
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |  57 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/rmi4/Kconfig                         |  47 +-
 drivers/input/rmi4/Makefile                        |  23 +-
 drivers/input/rmi4/rmi_2d_sensor.c                 | 370 ++++++++++++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |  87 ++++
 drivers/input/rmi4/rmi_bus.c                       | 205 ++++----
 drivers/input/rmi4/rmi_bus.h                       | 129 +----
 drivers/input/rmi4/rmi_driver.c                    | 468 +++++++++++++-----
 drivers/input/rmi4/rmi_driver.h                    | 119 ++---
 drivers/input/rmi4/rmi_f01.c                       |  57 ++-
 drivers/input/rmi4/rmi_f11.c                       | 540 ++++++---------------
 drivers/input/rmi4/rmi_f12.c                       | 461 ++++++++++++++++++
 drivers/input/rmi4/rmi_f30.c                       | 403 +++++++++++++++
 drivers/input/rmi4/rmi_i2c.c                       |  62 +--
 drivers/input/rmi4/rmi_spi.c                       | 464 ++++++++++++++++++
 include/linux/rmi.h                                | 270 +++++++++--
 20 files changed, 3027 insertions(+), 886 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h
 create mode 100644 drivers/input/rmi4/rmi_f12.c
 create mode 100644 drivers/input/rmi4/rmi_f30.c
 create mode 100644 drivers/input/rmi4/rmi_spi.c

-- 
2.1.4

