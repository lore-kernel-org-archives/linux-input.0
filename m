From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH, RFC] i8042: add Dritek keyboard extension quirk
Date: Sat, 12 Jan 2008 01:22:38 +0000
Message-ID: <200801120122.38648.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53764 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878AbYALBWp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 20:22:45 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Some Wistron based laptops need us to explicitly enable the 'Dritek
keyboard extension' to make their extra keys start generating scancodes.
Originally, this was just confined to older laptops, but a few Acer
laptops have turned up in 2007 that also need this again.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry,

Can you please check the i8042_command() call is correct, I'm having
trouble getting my head around the call semantics. What I'm trying to do
is send the command 0x59 with one argument, 0x90.

 drivers/input/serio/i8042-x86ia64io.h |   49 +++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.c           |   12 ++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)


diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index f8fe421..085c06b 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -269,6 +269,50 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 
 #endif
 
+#ifdef CONFIG_X86
+
+#include <linux/dmi.h>
+
+/*
+ * Some Wistron based laptops need us to explicitly enable the 'Dritek
+ * keyboard extension' to make their extra keys start generating scancodes.
+ * Originally, this was just confined to older laptops, but a few Acer laptops
+ * have turned up in 2007 that also need this again.
+ */
+static struct dmi_system_id __initdata i8042_dmi_dritek_table[] = {
+	{
+		.ident = "Acer Aspire 5630",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
+		},
+	},
+	{
+		.ident = "Acer Aspire 5650",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
+		},
+	},
+	{
+		.ident = "Acer Aspire 5680",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
+		},
+	},
+	{
+		.ident = "Acer TravelMate 2490",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
+		},
+	},
+	{ }
+};
+
+#endif /* CONFIG_X86 */
+
 
 #ifdef CONFIG_PNP
 #include <linux/pnp.h>
@@ -512,6 +556,11 @@ static int __init i8042_platform_init(void)
 		i8042_nomux = 1;
 #endif
 
+#ifdef CONFIG_X86
+	if (dmi_check_system(i8042_dmi_dritek_table))
+		i8042_dritek = 1;
+#endif /* CONFIG_X86 */
+
 	return retval;
 }
 
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index cbe83bf..eea4efd 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -63,6 +63,10 @@ static unsigned int i8042_blink_frequency = 500;
 module_param_named(panicblink, i8042_blink_frequency, uint, 0600);
 MODULE_PARM_DESC(panicblink, "Frequency with which keyboard LEDs should blink when kernel panics");
 
+static unsigned int i8042_dritek = 0;
+module_param_named(dritek, i8042_dritek, bool, 0);
+MODULE_PARM_DESC(dritek, "Force enable the Dritek keyboard extension");
+
 #ifdef CONFIG_PNP
 static int i8042_nopnp;
 module_param_named(nopnp, i8042_nopnp, bool, 0);
@@ -1145,6 +1149,7 @@ static int __devinit i8042_setup_kbd(void)
 static int __devinit i8042_probe(struct platform_device *dev)
 {
 	int error;
+	char param;
 
 	error = i8042_controller_selftest();
 	if (error)
@@ -1171,6 +1176,13 @@ static int __devinit i8042_probe(struct platform_device *dev)
  */
 	i8042_register_ports();
 
+	if (i8042_dritek) {
+		param = 0x90;
+		error = i8042_command(&param, 0x1059);
+		if (error)
+			goto out_fail;
+	}
+
 	return 0;
 
  out_fail:
