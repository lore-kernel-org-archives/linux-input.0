From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 07/10] Input: da9061: onkey driver
Date: Wed, 26 Oct 2016 17:56:39 +0100
Message-ID: <29f73d4d4718cc5848c0414ea60f865ef39bd2cf.1477501000.git.stwiss.opensource@diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1477501000.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Copyright header is updated to add DA9061 in its description and the module
description macro is extended to include DA9061.

Minor change to the code, alters dev_dbg() statements to report a generic
"PMIC" instead of DA9063. This device driver is compatible with DA9061,
DA9062 and DA9063.

Kconfig is updated to reflect support for DA9061/62/63.

Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
This patch applies against linux-next and v4.8

v1 -> v2
 - Patch renamed from [PATCH V1 03/10] to [PATCH V2 07/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order
 - Revert changes for DA9061 specific compatible changes.

Dmitry,

Alterations made in accordance with previous e-mail thread on the use of
compatible strings: https://lkml.org/lkml/2016/10/7/641
Now assuming the use of a fallback compatible string in the DT.
compatible = "dlg,da9061-onkey", "dlg,da9062-onkey";

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/input/misc/Kconfig        | 7 ++++---
 drivers/input/misc/da9063_onkey.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index efb0ca8..57cc9c2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -613,11 +613,12 @@ config INPUT_DA9055_ONKEY
 	  will be called da9055_onkey.
 
 config INPUT_DA9063_ONKEY
-	tristate "Dialog DA9062/63 OnKey"
+	tristate "Dialog DA9063/62/61 OnKey"
 	depends on MFD_DA9063 || MFD_DA9062
 	help
-	  Support the ONKEY of Dialog DA9063 and DA9062 Power Management ICs
-	  as an input device capable of reporting the power button status.
+	  Support the ONKEY of Dialog DA9063, DA9062 and DA9061 Power
+	  Management ICs as an input device capable of reporting the
+	  power button status.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called da9063_onkey.
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index bb863e0..dff6fe5 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -1,5 +1,5 @@
 /*
- * OnKey device driver for DA9063 and DA9062 PMICs
+ * OnKey device driver for DA9063, DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -149,13 +149,13 @@ static void da9063_poll_on(struct work_struct *work)
 			 * and then send shutdown command
 			 */
 			dev_dbg(&onkey->input->dev,
-				"Sending SHUTDOWN to DA9063 ...\n");
+				"Sending SHUTDOWN to PMIC ...\n");
 			error = regmap_write(onkey->regmap,
 					     config->onkey_shutdown,
 					     config->onkey_shutdown_mask);
 			if (error)
 				dev_err(&onkey->input->dev,
-					"Cannot SHUTDOWN DA9063: %d\n",
+					"Cannot SHUTDOWN PMIC: %d\n",
 					error);
 		}
 	}
@@ -300,6 +300,6 @@ static struct platform_driver da9063_onkey_driver = {
 module_platform_driver(da9063_onkey_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
-MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063 and DA9062");
+MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063, DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
-- 
end-of-patch for PATCH V2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
