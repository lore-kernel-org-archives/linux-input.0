From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 0/9] Goodix touchscreen enhancements
Date: Mon, 12 Oct 2015 18:24:28 +0300
Message-ID: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

v9 only adds GPIOLIB dependency in Kconfig for patch 2:
"Input: goodix - reset device at init". There are no other code
changes from v8.

Thanks for testing these changes, Bastien and Aleksei!

Karsten, there is no need to rebase your series on top of v9.

Thanks,
Irina

Changes in v9:
 - add GPIOLIB to driver dependencies
 - add Tested-by tag from Bastien and Aleksei

Changes in v8:
 - only allow new functionality for devices that declare named
gpios (using _DSD properties in ACPI or named DT properties)

Changes in v7:
 - add dmi quirk to skip gpio pins setup and functionality that
depends on them for Onda v975w, WinBook TW100 and WinBook TW700.
 - add support for named gpio pins
 - rework the runtime pm patch to fix a couple of issues
 - sort includes using inverse Xmas tree ordering

Changes in v6:
 - skip runtime power manangent calls in open/close if the device
ACPI/DT configuration does not declare interrupt and reset gpio pins.
 - reset the device before starting i2c communication
 - add Bastien's ack to the first 2 patches

Changes in v5:
 - add some more style cleanup (reorder includes, use error instead
of ret for return values)
 - add runtime power management patch

Changes in v4:
 - use dmi quirk to determine the order of irq and reset pins
 - use actual config length depending on device
 - add sysfs interface to dump config
 - initialize esd timeout from ACPI/DT properly

Changes in v3:
 - dropped the first 3 patches that got merged
 - handle -EPROBE_DEFER and -ENOENT for gpio pins
 - skip functionality depending on the gpio pins if the pins are not
properly initialized from ACPI/DT (reset, write config, power management,
ESD)
 - dropped #ifdef CONFIG_PM_SLEEP and annotated with __maybe_unused instead
 - use sysfs property to set ESD timeout instead of ACPI/DT property
 - use request_firmware_nowait to read configuration firmware and use
defaults if firmware is not found
 - use ACPI IDs to determine the order of the GPIO pins in the ACPI tables
(interrupt pin first or reset pin first)

Changes in v2:
 - use request_firmware instead of ACPI/DT property for config
 - dropped "input: goodix: add ACPI IDs for GT911 and GT9271" patch
 - add ACPI DSDT excerpt in commit message where necessary
 - add comments for suspend/resume sleep values
 - dropped the checkpatch fixes that did not make sense
 - added Bastien's ack to the first patch

Irina Tirdea (9):
  Input: goodix - use actual config length for each device type
  Input: goodix - reset device at init
  Input: goodix - write configuration data to device
  Input: goodix - add power management support
  Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_send
  Input: goodix - add support for ESD
  Input: goodix - add sysfs interface to dump config
  Input: goodix - add runtime power management support
  Input: goodix - sort includes using inverse Xmas tree order

 .../bindings/input/touchscreen/goodix.txt          |  11 +
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/goodix.c                 | 766 +++++++++++++++++++--
 3 files changed, 733 insertions(+), 45 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
