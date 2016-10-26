From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 08/10] watchdog: da9062/61: watchdog driver
Date: Wed, 26 Oct 2016 17:56:39 +0100
Message-ID: <ecd0c36a9e1766e327b54afa6bf986e64890b881.1477501000.git.stwiss.opensource@diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1477501000.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

The of_device_id match array is added to support "dlg,da9062-watchdog"
as a valid .compatible string.

The watchdog_info structure is linked to this device tree compatible
string in the .data section. Extra code is added into the probe function to
search-for and assign this match data.

This patch now assumes the use of a DA9062 fallback compatible string for
the DTS to pick up the DA9062 device driver for use with the DA9061
watchdog hardware.

Copyright header is updated to add DA9061 in its description and the module
description macro is extended to include DA9061.

Kconfig is updated to reflect support for DA9061/62.

Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
This patch applies against linux-next and v4.8

v1 -> v2
 - Patch renamed from [PATCH V1 04/10] to [PATCH V2 08/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order
 - Removal of the DA9061 compatible entries for this device driver.
 - Additional explanation in the patch description for the use of a
   fall-back compatible DTS string

Guenter,

Alterations have been made in accordance with the previous e-mail thread
on the use of compatible strings: https://lkml.org/lkml/2016/10/7/641
This patch now assumes the use of a fallback compatible string in the DTS.
Of the form: compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/watchdog/Kconfig      |  4 ++--
 drivers/watchdog/da9062_wdt.c | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bffe00..d6b4088 100644
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
index 7386111..4b20b7a 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -1,5 +1,5 @@
 /*
- * da9062_wdt.c - WDT device driver for DA9062
+ * Watchdog device driver for DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -188,23 +188,34 @@ static const struct watchdog_ops da9062_watchdog_ops = {
 	.set_timeout = da9062_wdt_set_timeout,
 };
 
+static const struct of_device_id da9062_compatible_id_table[] = {
+	{ .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
+	{ },
+};
+
 static int da9062_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct da9062 *chip;
 	struct da9062_watchdog *wdt;
+	const struct of_device_id *match;
 
 	chip = dev_get_drvdata(pdev->dev.parent);
 	if (!chip)
 		return -EINVAL;
 
+	match = of_match_node(da9062_compatible_id_table,
+			      pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
+
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
 	wdt->hw = chip;
 
-	wdt->wdtdev.info = &da9062_watchdog_info;
+	wdt->wdtdev.info = (const struct watchdog_info *)match->data;
 	wdt->wdtdev.ops = &da9062_watchdog_ops;
 	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
@@ -244,11 +255,12 @@ static struct platform_driver da9062_wdt_driver = {
 	.remove = da9062_wdt_remove,
 	.driver = {
 		.name = "da9062-watchdog",
+		.of_match_table = da9062_compatible_id_table,
 	},
 };
 module_platform_driver(da9062_wdt_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
-MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
+MODULE_DESCRIPTION("WDT device driver for Dialog DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:da9062-watchdog");
-- 
end-of-patch for PATCH V2

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
