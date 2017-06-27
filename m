From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/3] DA9052 hardware monitoring improvements
Date: Tue, 27 Jun 2017 16:38:56 +0200
Message-ID: <20170627143859.21312-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Hi,

GE Healthcare's PPD [0] uses DA9053's touchscreen pins
for hardware monitoring purposes. This adds support for
the feature and fixes a bug, which came up during
stress-testing of the driver.

[0] https://patchwork.kernel.org/patch/9809681/

Changes since PATCHv1:
 - convert tsiref-microvolt property into proper regulator
 - drop error message for timeout
 - simplify da9052_channel_is_visible()
 - fix checkpatch warnings

-- Sebastian

Sebastian Reichel (3):
  mfd: da9052: fix manual ADC read after timed out read
  hwmon: da9052: fix checkpatch warnings
  hwmon: da9052: add support for TSI channel

 .../devicetree/bindings/mfd/da9052-i2c.txt         |   8 +
 drivers/hwmon/da9052-hwmon.c                       | 288 +++++++++++++++++++--
 drivers/input/touchscreen/da9052_tsi.c             |   5 +
 drivers/mfd/da9052-core.c                          |   2 +
 include/linux/mfd/da9052/da9052.h                  |   6 +
 5 files changed, 287 insertions(+), 22 deletions(-)

-- 
2.11.0

