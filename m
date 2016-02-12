From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 0/8] EC-based USB Power Delivery support for Chrome machines
Date: Fri, 12 Feb 2016 13:56:57 +0100
Message-ID: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35395 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbcBLM50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 07:57:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-input@vger.kernel.org, Olof Johansson <olof@lixom.net>

Hi,

this series contains a driver that exposes a power_supply to userspace
representing a port that support USB PD charging.

Allows userspace to display to the user if the machine is charging and
on which port, and if another device is being charged by a port. Also
allows to limit the current draw for thermal reasons.

Thanks,

Tomeu

Changes in v2:
- Allocate enough for the structs in cros_ec_get_host_command_version_mask,
  not their pointers.
- Allocate msg in the stack in get_next_event and
  get_keyboard_state_event, as suggested by Gwendal.
- Remove the mention to Type C from the comments where it didn't make
  sense, as suggested by Benson Leung.
- Split out changes to cros_ec_commands.h and the helpers added to
  mfd/cros_ec.h from the patch that adds the charger driver, as
  suggested by Lee.
- Actually call get_ec_num_ports.
- Move cros_ec_usb_pd_charger_register into cros_ec_dev.c

Benson Leung (1):
  power_supply: Add types for USB Type C and PD chargers

Sameer Nanda (1):
  power: cros_usbpd-charger: Add EC-based USB PD charger driver

Tomeu Vizoso (4):
  mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
  mfd: cros_ec: Add cros_ec_get_host_event
  mfd: cros_ec: Add more definitions for PD commands
  platform/chrome: Register USB PD charger device

Vic Yang (1):
  mfd: cros_ec: Add MKBP event support

Vincent Palatin (1):
  platform/chrome: Check the USB PD feature before creating a charger

 drivers/input/keyboard/cros_ec_keyb.c   | 135 ++---
 drivers/mfd/cros_ec.c                   |  57 +-
 drivers/platform/chrome/cros_ec_dev.c   |  82 +++
 drivers/platform/chrome/cros_ec_proto.c | 129 +++++
 drivers/power/Kconfig                   |  10 +
 drivers/power/Makefile                  |   1 +
 drivers/power/cros_usbpd-charger.c      | 908 ++++++++++++++++++++++++++++++++
 drivers/power/power_supply_sysfs.c      |   3 +-
 include/linux/mfd/cros_ec.h             |  73 +++
 include/linux/mfd/cros_ec_commands.h    | 442 +++++++++++++++-
 include/linux/power_supply.h            |   3 +
 11 files changed, 1730 insertions(+), 113 deletions(-)
 create mode 100644 drivers/power/cros_usbpd-charger.c

-- 
2.5.0

