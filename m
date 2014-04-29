From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] elantech: Fix elantech on Gigabyte U2442
Date: Tue, 29 Apr 2014 13:36:36 +0200
Message-ID: <1398771396-4868-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933750AbaD2Lgk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Apr 2014 07:36:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, Philipp Wolfer <ph.wolfer@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The hw_version 3 elantech touchpad on the Gigabyte U2442 does not accept
0x0b as initialization value for r10, this stand-alone version of the driver:
http://planet76.com/drivers/elantech/psmouse-elantech-v6.tar.bz2

Uses 0x03 which does work, so this means not setting bit 3 of r10 which sets:
"Enable Real H/W Resolution In Absolute mode"

Which will result in half the x and y resolution we get with that bit set,
so simply not setting it everywhere is not a solution. We've been unable
to find a way to identifty touchpads where setting the bit will fail, so this
patch uses a dmi based blacklist for this.

https://bugzilla.kernel.org/show_bug.cgi?id=61151

Reported-by: Philipp Wolfer <ph.wolfer@gmail.com>
Tested-by: Philipp Wolfer <ph.wolfer@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/input/elantech.txt |  5 ++++-
 drivers/input/mouse/elantech.c   | 26 +++++++++++++++++++++++++-
 drivers/input/mouse/elantech.h   |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/elantech.txt
index 5602eb7..e1ae127 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -504,9 +504,12 @@ byte 5:
 * reg_10
 
    bit   7   6   5   4   3   2   1   0
-         0   0   0   0   0   0   0   A
+         0   0   0   0   R   F   T   A
 
          A: 1 = enable absolute tracking
+         T: 1 = enable two finger mode auto correct
+         F: 1 = disable ABS Position Filter
+         R: 1 = enable real hardware resolution
 
 6.2 Native absolute mode 6 byte packet format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 088d354..b96e978 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/input.h>
@@ -831,7 +832,11 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		break;
 
 	case 3:
-		etd->reg_10 = 0x0b;
+		if (etd->set_hw_resolution)
+			etd->reg_10 = 0x0b;
+		else
+			etd->reg_10 = 0x03;
+
 		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
 			rc = -1;
 
@@ -1331,6 +1336,22 @@ static int elantech_reconnect(struct psmouse *psmouse)
 }
 
 /*
+ * Some hw_version 3 models go into error state when we try to set bit 3 of r10
+ */
+static const struct dmi_system_id no_hw_res_dmi_table[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Gigabyte U2442 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "U2442"),
+		},
+	},
+#endif
+	{ }
+};
+
+/*
  * determine hardware version and set some properties according to it.
  */
 static int elantech_set_properties(struct elantech_data *etd)
@@ -1390,6 +1411,9 @@ static int elantech_set_properties(struct elantech_data *etd)
 	 */
 	etd->crc_enabled = ((etd->fw_version & 0x4000) == 0x4000);
 
+	/* Enable real hardware resolution on hw_version 3 ? */
+	etd->set_hw_resolution = !dmi_check_system(no_hw_res_dmi_table);
+
 	return 0;
 }
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 036a04a..9e0e2a1 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -130,6 +130,7 @@ struct elantech_data {
 	bool jumpy_cursor;
 	bool reports_pressure;
 	bool crc_enabled;
+	bool set_hw_resolution;
 	unsigned char hw_version;
 	unsigned int fw_version;
 	unsigned int single_finger_reports;
-- 
1.9.0

