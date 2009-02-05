From: Arjan van de Ven <arjan@infradead.org>
Subject: [patch 2/2] input: add a DMI table for the i8042.reset option; make
 MSI Wind U-100 work
Date: Wed, 4 Feb 2009 19:17:28 -0800
Message-ID: <20090204191728.7ed66e58@infradead.org>
References: <20090204191540.2d6abd87@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57104 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbZBEDRZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2009 22:17:25 -0500
In-Reply-To: <20090204191540.2d6abd87@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: input: add a DMI table for the i8042.reset option; make MSI Wind U-100 work

There are several DMI tables in the i8042 (keyboard) driver already,
but not one for the i8042.reset option. This patch adds such an option
(which also sets the nonfatal flag so that if the reset fails, the keyboard
still works).

Two users for this table are added as well, the MSI Wind U-100 and the
LG X110. The MSI Wind also needs to be in the "don't trust the pnp data"
for the touchpad to work on my machine.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

--- linux-2.6.28/drivers/input/serio/i8042-x86ia64io.h.org	2009-02-01 18:31:29.000000000 -0800
+++ linux-2.6.28/drivers/input/serio/i8042-x86ia64io.h	2009-02-01 18:35:26.000000000 -0800
@@ -378,6 +378,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
 		},
 	},
+	{
+		.ident = "MSI Wind U-100",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+		},
+	},
 	{ }
 };
 #endif
@@ -448,6 +455,25 @@ static struct dmi_system_id __initdata i
 	{ }
 };
 
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
+
+
 #endif /* CONFIG_X86 */
 
 #ifdef CONFIG_PNP
@@ -564,6 +583,11 @@ static int __init i8042_pnp_init(void)
 		i8042_nopnp = 1;
 #endif
 
+	if (dmi_check_system(i8042_dmi_reset_table)) {
+		i8042_reset = 1;
+		i8042_nonfatal = 1;
+	}
+
 	if (i8042_nopnp) {
 		printk(KERN_INFO "i8042: PNP detection disabled\n");
 		return 0;

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
