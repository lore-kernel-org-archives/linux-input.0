From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v11 0/8] Goodix touchscreen enhancements
Date: Thu, 19 Nov 2015 14:26:33 +0200
Message-ID: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44120 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbbKSM2A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 07:28:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

This patchset depends on Dmitry's patch that fixes the
GPIO ACPI API[1], so devm_gpiod_get_optional can be properly
used in the code. 

[1] https://lkml.org/lkml/2015/11/11/465

Changes in v11:
 - renamed irq-gpio and reset-gpio to irq-gpios and reset-gpios
 - added Rob's Acked-by for the binding in patch 6.

Changes in v10:
 - use devm_gpiod_get_optional and no longer ignore errors returned
by it
 - use completion to signal other code paths in the driver that
the config firmware is loaded on the device
 - dropped the patch that ordered the includes

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

Irina Tirdea (8):
  Input: goodix - use actual config length for each device type
  Input: goodix - reset device at init
  Input: goodix - write configuration data to device
  Input: goodix - add power management support
  Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_send
  Input: goodix - add support for ESD
  Input: goodix - add sysfs interface to dump config
  Input: goodix - add runtime power management support

 .../bindings/input/touchscreen/goodix.txt          |  13 +
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/goodix.c                 | 766 ++++++++++++++++++++-
 3 files changed, 742 insertions(+), 38 deletions(-)

-- 
1.9.1

