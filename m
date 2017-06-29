From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 0/4] DA9052 hardware monitoring improvements
Date: Thu, 29 Jun 2017 14:43:42 +0200
Message-ID: <20170629124346.22325-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdF2Mn5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 08:43:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Hi,

GE Healthcare's PPD [0] uses DA9053's touchscreen pins
for hardware monitoring purposes. This adds support for
the feature and fixes a bug, which came up during
stress-testing of the driver.

[0] https://patchwork.kernel.org/patch/9809681/

Changes since PATCHv2:
 - switch from diag, to dlg, prefix
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
  mfd: da9052: fix manual ADC read after timed out read
  hwmon: da9052: replace S_IRUGO with 0444
  dt-bindings: mfd: da9052: support TSI as ADC
  hwmon: da9052: add support for TSI channel

 .../devicetree/bindings/mfd/da9052-i2c.txt         |   8 +
 drivers/hwmon/da9052-hwmon.c                       | 284 +++++++++++++++++++--
 drivers/input/touchscreen/da9052_tsi.c             |   9 +
 drivers/mfd/da9052-core.c                          |   2 +
 include/linux/mfd/da9052/da9052.h                  |   6 +
 include/linux/mfd/da9052/reg.h                     |  11 +-
 6 files changed, 297 insertions(+), 23 deletions(-)

-- 
2.11.0

