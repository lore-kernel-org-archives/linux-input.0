From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 0/6] EC-based USB Power Delivery support for Chrome machines
Date: Wed, 17 Feb 2016 11:25:20 +0100
Message-ID: <1455704726-9342-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35637 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbcBQKZ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2016 05:25:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-input@vger.kernel.org, Olof Johansson <olof@lixom.net>

Hi,

this series contains a driver that exposes a power_supply to userspace
representing a port that support USB PD charging.

Allows userspace to display to the user if the machine is charging and
on which port, and if another device is being charged by a port.

Thanks,

Tomeu

Changes in v3:
- Remove duplicated prototype of cros_ec_get_host_event.
- Use do_div so it builds on 32bit (suggested by 0-day kbuild bot).
- Remove sysfs attributes ext_current_lim and ext_voltage_lim because
  I don't know yet where they should be placed (and don't have HW to
  test them).
- Remove superfluous pre-allocated buffers ec_inbuf and ec_outbuf.
- Lots of misc comments from Stephen Boyd were addressed.
- Unregister notification listener in .remove callback.
- Only register the PD charger device if there are any PD ports in this
  EC.
- Dropped patch using EC_CMD_GET_FEATURES to decide whether to create a
  charger device because we are now only creating one if a EC has any PD
  ports.
- Dropped patch adding power_supply types because it has been merged
  already.

Changes in v2:
- Allocate enough for the structs in cros_ec_get_host_command_version_mask,
  not their pointers.
- Allocate msg in the stack in get_next_event and
  get_keyboard_state_event, as suggested by Gwendal.
- Split out changes to cros_ec_commands.h and the helpers added to
  mfd/cros_ec.h from the patch that adds the charger driver, as
  suggested by Lee.
- Actually call get_ec_num_ports.
- Move cros_ec_usb_pd_charger_register into cros_ec_dev.c.

Sameer Nanda (1):
  power: cros_usbpd-charger: Add EC-based USB PD charger driver

Tomeu Vizoso (4):
  mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
  mfd: cros_ec: Add cros_ec_get_host_event
  mfd: cros_ec: Add more definitions for PD commands
  platform/chrome: Register USB PD charger device

Vic Yang (1):
  mfd: cros_ec: Add MKBP event support

 drivers/input/keyboard/cros_ec_keyb.c   | 135 ++----
 drivers/mfd/cros_ec.c                   |  57 ++-
 drivers/platform/chrome/cros_ec_dev.c   |  44 ++
 drivers/platform/chrome/cros_ec_proto.c | 129 ++++++
 drivers/power/Kconfig                   |  10 +
 drivers/power/Makefile                  |   1 +
 drivers/power/cros_usbpd-charger.c      | 780 ++++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  62 +++
 include/linux/mfd/cros_ec_commands.h    | 358 ++++++++++++++-
 9 files changed, 1464 insertions(+), 112 deletions(-)
 create mode 100644 drivers/power/cros_usbpd-charger.c

-- 
2.5.0

