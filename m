From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] input: Default to only using PNP for i8042 probing on x86
Date: Fri, 14 May 2010 12:10:03 -0400
Message-ID: <1273853403-2870-3-git-send-email-mjg@redhat.com>
References: <1273853403-2870-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958Ab0ENQKw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 May 2010 12:10:52 -0400
In-Reply-To: <1273853403-2870-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Matthew Garrett <mjg@redhat.com>

Experimenting with Windows has revealed that it will not probe the
keyboard controller unless a valid PNPACPI device is present. Change our
behaviour to match, and add a new i8042.forcedprobe parameter to allow
people to override it.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h |    5 +++++
 drivers/input/serio/i8042.c           |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 6168469..2c5d9c0 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1,6 +1,8 @@
 #ifndef _I8042_X86IA64IO_H
 #define _I8042_X86IA64IO_H
 
+#include <linux/acpi.h>
+
 /*
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -747,6 +749,9 @@ static int __init i8042_pnp_init(void)
 #if defined(__ia64__)
 		return -ENODEV;
 #else
+		if (!acpi_disabled && !i8042_forceprobe)
+			return -ENODEV;
+
 		printk(KERN_INFO "PNP: No PS/2 controller found. Probing ports directly.\n");
 		return 0;
 #endif
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 6440a8f..413c5a6 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -75,6 +75,9 @@ MODULE_PARM_DESC(dritek, "Force enable the Dritek keyboard extension");
 static bool i8042_nopnp;
 module_param_named(nopnp, i8042_nopnp, bool, 0);
 MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
+static bool i8042_forceprobe;
+module_param_named(forceprobe, i8042_forceprobe, bool, 0);
+MODULE_PARM_DESC(forceprobe, "Force probing even if no PNP devices were found");
 #endif
 
 #define DEBUG
-- 
1.7.0.1

