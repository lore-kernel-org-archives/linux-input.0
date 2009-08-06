From: akpm@linux-foundation.org
Subject: [patch 3/4] input: more i8042-reset quirks for MSI Wind-clone netbooks
Date: Thu, 06 Aug 2009 16:04:13 -0700
Message-ID: <200908062304.n76N4Dqw002622@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38408 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756428AbZHFXEe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2009 19:04:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, yan.i.li@intel.com, alan@lxorguk.ukuu.org.uk, mjg59@srcf.ucam.org

From: Yan Li <yan.i.li@intel.com>

When testing Moblin on various netbooks, we've got reports that many MSI
Wind clones need the i8042 reset quirks for the keyboard and/or touchpad's
proper function.

Signed-off-by: Yan Li <yan.i.li@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dmitry Torokhov <dtor@mail.ru>

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/i8042-x86ia64io.h |   28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff -puN drivers/input/serio/i8042-x86ia64io.h~input-more-i8042-reset-quirks-for-msi-wind-clone-netbooks drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h~input-more-i8042-reset-quirks-for-msi-wind-clone-netbooks
+++ a/drivers/input/serio/i8042-x86ia64io.h
@@ -420,6 +420,34 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
 		},
 	},
+	{
+		.ident = "Acer Aspire One 150",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
+		},
+	},
+	{
+		.ident = "Advent 4211",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
+		},
+	},
+	{
+		.ident = "Medion Akoya Mini E1210",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
+		},
+	},
+	{
+		.ident = "Mivvy M310",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
+		},
+	},
 	{ }
 };
 
_
