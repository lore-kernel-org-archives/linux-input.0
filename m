From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v6 0/9] Goodix touchscreen enhancements
Date: Tue, 15 Sep 2015 17:31:14 +0300
Message-ID: <1442327483-19407-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Add several enhancements to the Goodix touchscreen driver.
This version includes a couple of fixes.

Thanks,
Irina

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

Irina Tirdea (9):
  Input: goodix - sort includes alphabetically
  Input: goodix - use actual config length for each device type
  Input: goodix - reset device at init
  Input: goodix - write configuration data to device
  Input: goodix - add power management support
  Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_send
  Input: goodix - add support for ESD
  Input: goodix - add sysfs interface to dump config
  Input: goodix - add runtime power management support

 .../bindings/input/touchscreen/goodix.txt          |  11 +
 drivers/input/touchscreen/goodix.c                 | 721 +++++++++++++++++++--
 2 files changed, 690 insertions(+), 42 deletions(-)

-- 
1.9.1
