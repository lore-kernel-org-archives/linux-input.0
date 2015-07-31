From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/8] Goodix touchscreen enhancements
Date: Fri, 31 Jul 2015 20:42:04 +0300
Message-ID: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add several enhancements to the Goodix touchscreen driver.

I have added the esd_timeout DT property only for initialization to
get more feedback on this variant of the ESD patch.

Bastien, I have considered that both your boards (specified for rotated
screen quirk) have the reset pin declared first in the ACPI table.
Please let me know if that is correct.

I have also added an entry in sysfs to dump the config and a script that will
help create a new config for the device, if you want to look into the problem
with the Baytrail pinctrl warning.

Thanks,
Irina

Changes in v4:
 - use dmi quirk to determine the order of irq and reset pins
 - use actual config length depending on device
 - add sysfs interface to dump config
 - initialize esd timeout from ACPI/DT propery

Changes in v3:
 - dropped the first 3 patches that got merged
 - handle -EPROBE_DEFER and -ENOENT for gpio pins
 - skip functionality depending on the gpio pins if the pins are not
properly initialized from ACPI/DT (reset, write config, power management,
ESD)
 - dropped #ifdef CONFIG_PM_SLEEP and annotated with __maybe_unused instead
 - use sysfs property to set ESD timeout instead of ACPI/DT property
 - use request_firmware_nowait to read configuration firmware and use defaults
if firmware is not found
 - use ACPI IDs to determine the order of the GPIO pins in the ACPI tables
(interrupt pin first or reset pin first)

Changes in v2:
 - use request_firmware instead of ACPI/DT property for config
 - dropped "input: goodix: add ACPI IDs for GT911 and GT9271" patch
 - add ACPI DSDT excerpt in commit message where necessary
 - add comments for suspend/resume sleep values
 - dropped the checkpatch fixes that did not make sense
 - added Bastien's ack to the first patch

Irina Tirdea (8):
  Input: goodix - reset device at init
  Input: goodix - use actual config length for each device type
  Input: goodix - write configuration data to device
  Input: goodix - add power management support
  Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_send
  Input: goodix - add support for ESD
  Input: goodix - add sysfs interface to dump config
  DO NOT APPLY! goodix configuration update helper

 .../bindings/input/touchscreen/goodix.txt          |  11 +
 drivers/input/touchscreen/goodix.c                 | 652 +++++++++++++++++++--
 tools/touch-goodix-generate-fw.sh                  |  39 ++
 3 files changed, 665 insertions(+), 37 deletions(-)
 create mode 100755 tools/touch-goodix-generate-fw.sh

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
