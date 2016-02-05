From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 0/6] EC-based USB Power Delivery support for Chrome machines
Date: Fri,  5 Feb 2016 14:32:55 +0100
Message-ID: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-input@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-input@vger.kernel.org

Hi,

this series contains a driver that exposes a power_supply to userspace
representing a port that support USB PD charging.

Allows userspace to display to the user if the machine is charging and
on which port, and if another device is being charged by a port. Also
allows to limit the current draw for thermal reasons.

Thanks,

Tomeu


Benson Leung (1):
  power_supply: Add types for USB Type C and PD chargers

Sameer Nanda (1):
  power: cros_usbpd-charger: Add EC-based USB PD charger driver

Tomeu Vizoso (2):
  mfd: cros_ec: small kerneldoc fix
  platform/chrome: Register USB PD charger device

Vic Yang (1):
  mfd: cros_ec: Add MKBP event support

Vincent Palatin (1):
  platform/chrome: Check the USB PD feature before creating a charger

 drivers/input/keyboard/cros_ec_keyb.c   | 135 ++---
 drivers/mfd/cros_ec.c                   |  72 ++-
 drivers/platform/chrome/cros_ec_dev.c   |  72 +++
 drivers/platform/chrome/cros_ec_proto.c | 139 +++++
 drivers/power/Kconfig                   |  10 +
 drivers/power/Makefile                  |   1 +
 drivers/power/cros_usbpd-charger.c      | 907 ++++++++++++++++++++++++++++++++
 drivers/power/power_supply_sysfs.c      |   3 +-
 include/linux/mfd/cros_ec.h             |  77 ++-
 include/linux/mfd/cros_ec_commands.h    | 442 +++++++++++++++-
 include/linux/power_supply.h            |   3 +
 11 files changed, 1747 insertions(+), 114 deletions(-)
 create mode 100644 drivers/power/cros_usbpd-charger.c

-- 
2.5.0
