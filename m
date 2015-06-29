From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/5] Goodix touchscreen enhancements
Date: Mon, 29 Jun 2015 19:28:19 +0300
Message-ID: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add several enhancements to the Goodix touchscreen driver:
 - write configuration data to the device
 - power management support
 - ESD

For testing the ACPI changes "ACPI: Translate Linux IRQ number directly
from GpioInt" patchset might be needed [1]. This patchset has been merged
in the GPIO tree.

This patches are based on Goodix datasheets for GT911 and GT9271 and
on Goodix driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices). Commit 771d8f1b178e ("Input: goodix - add
device tree support") references a set of public datasheets that can
be used for reference.

[1] https://lkml.org/lkml/2015/5/6/281

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

Irina Tirdea (5):
  Input: goodix - reset device at init
  Input: goodix - write configuration data to device
  Input: goodix - add power management support
  Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_send
  Input: goodix - add support for ESD

 .../bindings/input/touchscreen/goodix.txt          |   5 +
 drivers/input/touchscreen/goodix.c                 | 591 +++++++++++++++++++--
 2 files changed, 558 insertions(+), 38 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
