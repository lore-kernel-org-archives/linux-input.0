From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V5 6/8] watchdog: da9062/61: watchdog driver
Date: Thu, 15 Dec 2016 19:08:41 +0000
Message-ID: <c502612bcb924d2be069be81a612052462b14b26.1481828921.git.stwiss.opensource@diasemi.com>
References: <cover.1481828921.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139]:25321 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752803AbcLOTjO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 14:39:14 -0500
In-Reply-To: <cover.1481828921.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Zhang Rui <rui.zhang@intel.com>

From: Steve Twiss <stwiss.opensource@diasemi.com>

The of_device_id match array is added to support "dlg,da9062-watchdog"
as a valid .compatible string. A MODULE_DEVICE_TABLE() macro is added.

This patch assumes the use of a DA9062 fallback compatible string for the
DTS to pick up the DA9062 device driver for use with the DA9061 watchdog
hardware

Copyright header is updated to add DA9061 in its description and the module
description macro is extended to include DA9061.

Kconfig is updated to reflect support for DA9061/62.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.9

v4 -> v5
 - NO CODE CHANGE
 - Rebased from v4.8 to v4.9

v3 -> v4
 - NO CODE CHANGE
 - Patch renamed from [PATCH V3 7/9] to [PATCH V4 6/8]
 - Added reviewed by Guenter Roeck

v2 -> v3
 - Patch renamed from [PATCH V2 08/10] to [PATCH V3 7/9]
 - Removal of match->data and of_match_node search. There is only one
   compatible string now. and delete the .data = &da9062_watchdog_info
   association in the struct of_device_id compatible table.
 - Addition of MODULE_DEVICE_TABLE macro to allow modinfo additions:
   da9062_wdt.ko platform:da9062_watchdog
                 of:N*T*Cdlg,da9062_watchdogC*
                 of:N*T*Cdlg,da9062_watchdog

v1 -> v2
 - Patch renamed from [PATCH V1 04/10] to [PATCH V2 08/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order
 - Removal of the DA9061 compatible entries for this device driver.
 - Additional explanation in the patch description for the use of a
   fall-back compatible DTS string

Hi,

There are no code changes to this patch compared to the previous
submission in [PATCH V3 7/9]. The differences are in the patch version
rename and Reviewed-by tag.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/watchdog/Kconfig      |  4 ++--
 drivers/watchdog/da9062_wdt.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3eb58cb..bb4e7dd8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -104,11 +104,11 @@ config DA9063_WATCHDOG
 	  This driver can be built as a module. The module name is da9063_wdt.
 
 config DA9062_WATCHDOG
-	tristate "Dialog DA9062 Watchdog"
+	tristate "Dialog DA9062/61 Watchdog"
 	depends on MFD_DA9062
 	select WATCHDOG_CORE
 	help
-	  Support for the watchdog in the DA9062 PMIC.
+	  Support for the watchdog in the DA9062 and DA9061 PMICs.
 
 	  This driver can be built as a module. The module name is da9062_wdt.
 
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 7386111..a02cee6 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -1,5 +1,5 @@
 /*
- * da9062_wdt.c - WDT device driver for DA9062
+ * Watchdog device driver for DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -188,6 +188,13 @@ static int da9062_wdt_set_timeout(struct watchdog_device *wdd,
 	.set_timeout = da9062_wdt_set_timeout,
 };
 
+static const struct of_device_id da9062_compatible_id_table[] = {
+	{ .compatible = "dlg,da9062-watchdog", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, da9062_compatible_id_table);
+
 static int da9062_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -244,11 +251,12 @@ static int da9062_wdt_remove(struct platform_device *pdev)
 	.remove = da9062_wdt_remove,
 	.driver = {
 		.name = "da9062-watchdog",
+		.of_match_table = da9062_compatible_id_table,
 	},
 };
 module_platform_driver(da9062_wdt_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
-MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
+MODULE_DESCRIPTION("WDT device driver for Dialog DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:da9062-watchdog");
-- 
end-of-patch for PATCH V5

