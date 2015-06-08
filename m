From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 0/8]  Goodix touchscreen enhancements
Date: Mon,  8 Jun 2015 17:37:45 +0300
Message-ID: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52563 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111AbbFHOjq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jun 2015 10:39:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>

Add several enhancements to the Goodix touchscreen driver:
 - write configuration data to the device
 - power management support
 - cleanup and refactoring

I have kept the original patch for ESD ("input: goodix: add support
for ESD") since it is still under discussion. I have moved it to the
end of the patch set so it does not block the other changes. Once I have
an answer from DT folks on this I will make the necessary changes for it.

For testing the ACPI changes "ACPI: Translate Linux IRQ number directly
from GpioInt" patchset is needed [1]. This patchset has been merged in
the GPIO tree.

This patches are based on Goodix datasheets for GT911 and GT9271 and
on Goodix driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices). Commit 771d8f1b178e ("Input: goodix - add
device tree support") references a set of public datasheets that can
be used for reference.

[1] https://lkml.org/lkml/2015/5/6/281

Changes in v2:
 - use request_firmware instead of ACPI/DT property for config
 - dropped "input: goodix: add ACPI IDs for GT911 and GT9271" patch
 - add ACPI DSDT excerpt in commit message where necessary
 - add comments for suspend/resume sleep values
 - dropped the checkpatch fixes that did not make sense
 - added Bastien's ack to the first patch

Irina Tirdea (8):
  input: goodix: fix alignment issues
  input: goodix: fix variable length array warning
  input: goodix: export id and version read from device
  input: goodix: reset device at init
  input: goodix: write configuration data to device
  input: goodix: add power management support
  input: goodix: use goodix_i2c_write_u8 instead of i2c_master_send
  input: goodix: add support for ESD

 .../bindings/input/touchscreen/goodix.txt          |  12 +
 drivers/input/touchscreen/goodix.c                 | 467 +++++++++++++++++++--
 2 files changed, 449 insertions(+), 30 deletions(-)

-- 
1.9.1

