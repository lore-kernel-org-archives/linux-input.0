From: Roman Volkov <rvolkov@v1ros.org>
Subject: [PATCH v4 0/4] FDT support for i8042 driver
Date: Sat,  4 Jul 2015 20:35:40 +0300
Message-ID: <1436031344-15455-1-git-send-email-rvolkov@v1ros.org>
References: <342234234esdfewrewrwer@dkoi.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v1ros.org ([109.234.34.72]:53240 "EHLO smtp.v1ros.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755346AbbGEJAr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Jul 2015 05:00:47 -0400
In-Reply-To: <342234234esdfewrewrwer@dkoi.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Roman Volkov <rvolkov@v1ros.org>

The i8042 interface is used not only on the x86 architecture. Some of
non-x86 architectures are using Open Firmware device tree, like SPARC
and PowerPC. There is also non-x86 platforms with the FDT support, such
as ARM SoCs. There is no code in Linux to support i8042-capable input
devices on these newer platforms.

This patch creates one more file (i8042-of.h), with OF parsing code
for the ePAPR-compatible binding with the 'compatible' property. The
binding is based on existing OF code for older platforms, making it
possible to reuse this code for these platforms.

 v2:
 -Changes in the documentation.
 -Errors fixed in the initialization function.
 -Redundant parameters removed from Device Tree bindings (init-reset, etc.).

 v3:
 -Reduced amount of 'ifdefs' in the i8042.c file. Initialization order
    is now the same for all architectures.

 Warning: the change in v3 is more controversial and needs more testing
 since affects all architectures which use the driver. Please give
 information regarding required steps to get this patch accepted. Would
 be great to find testers to get additional tested-by records.

 v4:
 -Rename i8042-dt.h to i8042-of.h, rewrite init/probe/remove functions with
    OF code to be compatible with SPARC/PowerPC.
 -Add MODULE_DEVICE_TABLE (it was a mistake to forget about it)
 -Remove 'command-reg', 'status-reg', 'data-reg' from the binding; it is not
    required for now.
 -Yet another variant of changes in i8042.c. Unfortunately, it is not possible
    to avoid these changes.
 -Move the documentation file into the right place
    (thanks to Hans de Goede for the hint)
 -Change the order of patches
 Tested on: x86, ARM-vt8500, both as a module\built-in.

Roman Volkov (4):
  i8042: Add i8042_of.h header
  i8042: Kernel configuration for OF/FDT support
  i8042: Add OF/FDT support to the driver
  Documentation: Add 'intel,8042' FDT bindings

 .../devicetree/bindings/serio/intel,8042.txt       |  82 ++++++++++
 drivers/input/serio/i8042-of.h                     | 168 +++++++++++++++++++++
 drivers/input/serio/i8042.c                        |  43 +++++-
 drivers/input/serio/i8042.h                        |   3 +
 4 files changed, 291 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serio/intel,8042.txt
 create mode 100644 drivers/input/serio/i8042-of.h

-- 
2.4.2

