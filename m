From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [RESEND] [PATCHv6 0/4] DA9052 hardware monitoring improvements
Date: Mon, 21 Aug 2017 16:54:00 +0200
Message-ID: <20170821145404.18902-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Hi,

GE Healthcare's PPD [0] uses DA9053's touchscreen pins
for hardware monitoring purposes. This adds support for
the feature.

The proposed merge solution is, that mfd queues the
mfd patches and provides an immutable branch for hwmon,
since the last patch depends on the other ones.

[0] https://patchwork.kernel.org/patch/9809681/

Changes since original PATCHv6
 - No functional changes
 - Added Acked-by from Lee Jones [MFD]
 - Added Acked-by from Guenter Roeck [HWMON]

Changes since PATCHv5
 - drop patch 1 & 2 (applied to mfd)
 - use one line for da9052_tsi_subdev_info[]

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

Sebastian Reichel (4):
  mfd: da9052: add register details for TSI
  mfd: da9052: make touchscreen registration optional
  hwmon: da9052: replace S_IRUGO with 0444
  hwmon: da9052: add support for TSI channel

 drivers/hwmon/da9052-hwmon.c      | 285 +++++++++++++++++++++++++++++++++++---
 drivers/mfd/da9052-core.c         |  26 +++-
 include/linux/mfd/da9052/da9052.h |   6 +
 include/linux/mfd/da9052/reg.h    |  11 +-
 4 files changed, 302 insertions(+), 26 deletions(-)

-- 
2.14.1

