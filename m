From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 0/6] DA9052 hardware monitoring improvements
Date: Mon,  3 Jul 2017 10:39:57 +0200
Message-ID: <20170703084003.31184-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Hi,

GE Healthcare's PPD [0] uses DA9053's touchscreen pins
for hardware monitoring purposes. This adds support for
the feature and fixes a bug, which came up during
stress-testing of the driver.

[0] https://patchwork.kernel.org/patch/9809681/

Changes since PATCHv4:
 - split mfd changes from main hwmon patch

Changes since PATCHv3:
 - use correct index in da9052_channel_is_visible()
 - disable touchscreen in mfd instead of in ts driver

Changes since PATCHv2:
 - switch from "diag," to "dlg," prefix
 - add/use defines for accessing bits in registers
 - provide more details in the comment above early exit
   in touchscreen driver
 - switch to da9052_group_read() to ensure MSB and LSB
   are in sync
 - move binding update into its own patch
 - rename patch

Changes since PATCHv1:
 - convert tsiref-microvolt property into proper regulator
 - drop error message for timeout
 - simplify da9052_channel_is_visible()
 - fix checkpatch warnings

-- Sebastian

Sebastian Reichel (6):
  mfd: da9052: fix manual ADC read after timed out read
  dt-bindings: mfd: da9052: support TSI as ADC
  mfd: da9052: add register details for TSI
  mfd: da9052: make touchscreen registration optional
  hwmon: da9052: replace S_IRUGO with 0444
  hwmon: da9052: add support for TSI channel

 .../devicetree/bindings/mfd/da9052-i2c.txt         |   8 +
 drivers/hwmon/da9052-hwmon.c                       | 285 +++++++++++++++++++--
 drivers/mfd/da9052-core.c                          |  30 ++-
 include/linux/mfd/da9052/da9052.h                  |   6 +
 include/linux/mfd/da9052/reg.h                     |  11 +-
 5 files changed, 314 insertions(+), 26 deletions(-)

-- 
2.11.0

