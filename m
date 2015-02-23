From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v5 0/5] Add new MFD drvier for MAX77843
Date: Mon, 23 Feb 2015 20:34:08 +0900
Message-ID: <1424691253-11429-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch series adds MAX77843(Multi Function Device) driver.
The MAX77843 includes MUIC(Micro USB Interface Controller), Li+ Charger
with Fuel Gauge, 2 safeout LDOs for USB device and haptic controller using PWM.
It is interfaced to host controller using I2C. 

Changes in v5:
MFD Core
 - Use bracket in complex define.
 - Delete unnecessary letter '++'
Charger
 - fix Kconfig merge conflict with Kernel version4.0

Changes in v4:
MFD Core
 - Fix indentation
 - Add haptic register define in header
HAPTIC
 - Add haptic driver

Changes in v3:
MFD Core
 - Fix wrong description and indentation in header.
 - Remove unnecessary variable.
Regulator
 - Use ARRAY_SIZE() instead of define.

Changes in v2:
MFD Core
 - Fix charger regmap handle and typo.
MUIC
 - Cleanup enum list.
 - Set path before send excon event.
 - Fix variable names and typos for readability.
Charger
 - Remove unnecessary header.
 - Chnage error message more readable.
 - Remove unnecessary lines.
Fuelgauge
 - Fix regmap_config and use regmap_read.
 - Add i2c_unregister_device function on *_remove function.
 - Fix typo in Kconfig.
Doc
 - Remove unnecessary lines.
 - Add example of charger regulator.

Beomho Seo (2):
  power: max77843_charger: Add Max77843 charger device driver
  power: max77843_battery: Add Max77843 fuel gauge device driver

Jaewon Kim (3):
  mfd: max77843: Add max77843 MFD driver core driver
  Input: add haptic drvier on max77843
  Documentation: Add device tree bindings document for max77843

 Documentation/devicetree/bindings/mfd/max77843.txt |  110 +++++
 drivers/input/misc/Kconfig                         |   12 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/max77843-haptic.c               |  356 ++++++++++++++
 drivers/mfd/Kconfig                                |   14 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/max77843.c                             |  248 ++++++++++
 drivers/power/Kconfig                              |   16 +
 drivers/power/Makefile                             |    2 +
 drivers/power/max77843_battery.c                   |  286 +++++++++++
 drivers/power/max77843_charger.c                   |  508 ++++++++++++++++++++
 include/linux/mfd/max77843-private.h               |  454 +++++++++++++++++
 12 files changed, 2008 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77843.txt
 create mode 100644 drivers/input/misc/max77843-haptic.c
 create mode 100644 drivers/mfd/max77843.c
 create mode 100644 drivers/power/max77843_battery.c
 create mode 100644 drivers/power/max77843_charger.c
 create mode 100644 include/linux/mfd/max77843-private.h

-- 
1.7.9.5
