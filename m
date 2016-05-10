From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/3] Input: soc_button_array fixes and question
Date: Tue, 10 May 2016 17:37:50 +0200
Message-ID: <1462894673-26560-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbcEJPiB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2016 11:38:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Alexandre Courbot <acourbot@nvidia.com>, Lejun Zhu <lejun.zhu@linux.intel.com>

Hi,

This series has been triggered by the Surface 3 I have been given.
The way Microsoft follows its own specs is always intriguing. As
written in drivers/platform/x86/surfacepro3_button.c, the PNP0C40
ACPI device which should follow the specification doesn't have any
GPIO listed (thus the first 2 patches).

Also, the actual ACPI device that has the GPIO described is declared
as an I2C one, even if there is no such device attached to the bus.
This particular device could use the soc_button_array driver after a
little bit of ACPI magic (patches to follow, later), but each GPIO in
this device is declared twice (as Int and Io), so the 3rd patch.

Here is my question mentioned in $subject:

Why are we using gpiod_get_index(dev, KBUILD_MODNAME, acpi_index, GPIOD_ASIS);
in soc_button_lookup_gpio()?

>From what I can test here, it works the first time, but if we rmmod the module
and modprobe it again, it leads to a page fault.

My understanding is to use gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
instead, which survives a module removal.

However, I do not have the ACPI spec for this and I do not have real hardware
following this spec, so I am just speculating with my Surface 3.

Cheers,
Benjamin

Benjamin Tissoires (3):
  Input - soc_button_array: use gpio_is_valid()
  Input - soc_button_array: bail out earlier if gpiod_count is null
  Input - soc_button_array: make sure one GPIO is not assigned twice

 drivers/input/misc/soc_button_array.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.5.0

