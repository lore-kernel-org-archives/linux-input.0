From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 0/6] EC-based USB Power Delivery support for Chrome machines
Date: Fri, 18 Mar 2016 14:36:09 +0100
Message-ID: <1458308175-9508-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-input@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-input@vger.kernel.org

Hi,

this series contains a driver that exposes a power_supply to userspace
representing a port that support USB PD charging.

Allows userspace to display to the user if the machine is charging and
on which port, and if another device is being charged by a port.

This series may be best integrated through the MFD tree, for which we'll
need ACKs from Olof (for the changes to platform/chrome), from Dmitry
(for changes to cros_ec_keyb.c) and from Sebastian Reichel for the
new driver.

Thanks,

Tomeu

Changes in v6:
- Return 0 if the EC doesn't support MKBP, as expected by callers.

Changes in v5:
- Check explicitly for !EC_RES_SUCCESS as suggested by Benson Leung.
- Fix type of variable passed to do_div.

Changes in v4:
- Calculate correctly the size of the payloads in
  cros_ec_get_host_command_version_mask.
- Declare size parameters in ec_command as size_t

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

