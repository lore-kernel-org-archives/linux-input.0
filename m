From: akpm@linux-foundation.org
Subject: [patch for 2.6.29? 2/3] input: add a DMI table for the i8042.reset option; make MSI Wind U-100 work
Date: Wed, 04 Mar 2009 12:10:54 -0800
Message-ID: <200903042010.n24KAt06029852@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32852 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757520AbZCDUL2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 15:11:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, arjan@linux.intel.com

From: Arjan van de Ven <arjan@linux.intel.com>

There are several DMI tables in the i8042 (keyboard) driver already, but
not one for the i8042.reset option.  This patch adds such an option (which
also sets the nonfatal flag so that if the reset fails, the keyboard still
works).

Two users for this table are added as well, the MSI Wind U-100 and the LG
X110.  The MSI Wind also needs to be in the "don't trust the pnp data" for
the touchpad to work on my machine.

[akpm@linux-foundation.org: fix build warning]
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/i8042-x86ia64io.h |   56 ++++++++++++++++++------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff -puN drivers/input/serio/i8042-x86ia64io.h~input-add-a-dmi-table-for-the-i8042reset-option-make-msi-wind-u-100-work drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h~input-add-a-dmi-table-for-the-i8042reset-option-make-msi-wind-u-100-work
+++ a/drivers/input/serio/i8042-x86ia64io.h
@@ -369,19 +369,6 @@ static struct dmi_system_id __initdata i
 	{ }
 };
 
-#ifdef CONFIG_PNP
-static struct dmi_system_id __initdata i8042_dmi_nopnp_table[] = {
-	{
-		.ident = "Intel MBO Desktop D845PESV",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-		},
-	},
-	{ }
-};
-#endif
-
 /*
  * Some Wistron based laptops need us to explicitly enable the 'Dritek
  * keyboard extension' to make their extra keys start generating scancodes.
@@ -466,6 +453,44 @@ static int i8042_pnp_aux_irq;
 static char i8042_pnp_kbd_name[32];
 static char i8042_pnp_aux_name[32];
 
+#ifdef CONFIG_X86
+static struct dmi_system_id __initdata i8042_dmi_nopnp_table[] = {
+	{
+		.ident = "Intel MBO Desktop D845PESV",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+		},
+	},
+	{
+		.ident = "MSI Wind U-100",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+		},
+	},
+	{ }
+};
+
+static struct dmi_system_id __initdata i8042_dmi_reset_table[] = {
+	{
+		.ident = "MSI Wind U-100",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+		},
+	},
+	{
+		.ident = "LG Electronics X110",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X110"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
+		},
+	},
+	{ }
+};
+#endif
+
 static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
@@ -562,6 +587,11 @@ static int __init i8042_pnp_init(void)
 #ifdef CONFIG_X86
 	if (dmi_check_system(i8042_dmi_nopnp_table))
 		i8042_nopnp = 1;
+
+	if (dmi_check_system(i8042_dmi_reset_table)) {
+		i8042_reset = 1;
+		i8042_nonfatal = 1;
+	}
 #endif
 
 	if (i8042_nopnp) {
_
