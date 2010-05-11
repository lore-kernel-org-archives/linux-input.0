From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: elantech - enforce common prefix on messages
Date: Tue, 11 May 2010 01:18:54 -0700
Message-ID: <20100511081854.10546.64168.stgit@localhost.localdomain>
References: <20100511081848.10546.95545.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42276 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0EKIS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 04:18:57 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so410917pvb.19
        for <linux-input@vger.kernel.org>; Tue, 11 May 2010 01:18:57 -0700 (PDT)
In-Reply-To: <20100511081848.10546.95545.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>, =?utf-8?b?w4lyaWM=?= Piel <E.A.B.Piel@tudelft.nl>, Arjan Opmeer <arjan@opmeer.net>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/elantech.c |   67 +++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 112b4ee..232556a 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -10,6 +10,8 @@
  * Trademarks are the property of their respective owners.
  */
 
+#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
+
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -19,10 +21,10 @@
 #include "psmouse.h"
 #include "elantech.h"
 
-#define elantech_debug(format, arg...)				\
-	do {							\
-		if (etd->debug)					\
-			printk(KERN_DEBUG format, ##arg);	\
+#define elantech_debug(fmt, ...)					\
+	do {								\
+		if (etd->debug)						\
+			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 	} while (0)
 
 static bool force_elantech;
@@ -37,7 +39,7 @@ static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c,
 {
 	if (psmouse_sliced_command(psmouse, c) ||
 	    ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO)) {
-		pr_err("elantech.c: synaptics_send_cmd query 0x%02x failed.\n", c);
+		pr_err("synaptics_send_cmd query 0x%02x failed.\n", c);
 		return -1;
 	}
 
@@ -60,13 +62,13 @@ static int elantech_ps2_command(struct psmouse *psmouse,
 		if (rc == 0)
 			break;
 		tries--;
-		elantech_debug("elantech.c: retrying ps2 command 0x%02x (%d).\n",
-			command, tries);
+		elantech_debug("retrying ps2 command 0x%02x (%d).\n",
+				command, tries);
 		msleep(ETP_PS2_COMMAND_DELAY);
 	} while (tries > 0);
 
 	if (rc)
-		pr_err("elantech.c: ps2 command 0x%02x failed.\n", command);
+		pr_err("ps2 command 0x%02x failed.\n", command);
 
 	return rc;
 }
@@ -108,7 +110,7 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
 	}
 
 	if (rc)
-		pr_err("elantech.c: failed to read register 0x%02x.\n", reg);
+		pr_err("failed to read register 0x%02x.\n", reg);
 	else
 		*val = param[0];
 
@@ -154,7 +156,7 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
 	}
 
 	if (rc)
-		pr_err("elantech.c: failed to write register 0x%02x with value 0x%02x.\n",
+		pr_err("failed to write register 0x%02x with value 0x%02x.\n",
 			reg, val);
 
 	return rc;
@@ -167,7 +169,7 @@ static void elantech_packet_dump(unsigned char *packet, int size)
 {
 	int	i;
 
-	printk(KERN_DEBUG "elantech.c: PS/2 packet [");
+	printk(KERN_DEBUG pr_fmt("PS/2 packet ["));
 	for (i = 0; i < size; i++)
 		printk("%s0x%02x ", (i) ? ", " : " ", packet[i]);
 	printk("]\n");
@@ -203,7 +205,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 	if (etd->jumpy_cursor) {
 		/* Discard packets that are likely to have bogus coordinates */
 		if (fingers > old_fingers) {
-			elantech_debug("elantech.c: discarding packet\n");
+			elantech_debug("discarding packet\n");
 			goto discard_packet_v1;
 		}
 	}
@@ -413,23 +415,21 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 			if (rc == 0)
 				break;
 			tries--;
-			elantech_debug("elantech.c: retrying read (%d).\n",
-					tries);
+			elantech_debug("retrying read (%d).\n", tries);
 			msleep(ETP_READ_BACK_DELAY);
 		} while (tries > 0);
 
 		if (rc) {
-			pr_err("elantech.c: failed to read back register 0x10.\n");
+			pr_err("failed to read back register 0x10.\n");
 		} else if (etd->hw_version == 1 &&
 			   !(val & ETP_R10_ABSOLUTE_MODE)) {
-			pr_err("elantech.c: touchpad refuses "
-				"to switch to absolute mode.\n");
+			pr_err("touchpad refuses to switch to absolute mode.\n");
 			rc = -1;
 		}
 	}
 
 	if (rc)
-		pr_err("elantech.c: failed to initialise registers.\n");
+		pr_err("failed to initialise registers.\n");
 
 	return rc;
 }
@@ -590,7 +590,7 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
 	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
 	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
-		pr_debug("elantech.c: sending Elantech magic knock failed.\n");
+		pr_debug("sending Elantech magic knock failed.\n");
 		return -1;
 	}
 
@@ -599,8 +599,7 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	 * set of magic numbers
 	 */
 	if (param[0] != 0x3c || param[1] != 0x03 || param[2] != 0xc8) {
-		pr_debug("elantech.c: "
-			 "unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
+		pr_debug("unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
 			 param[0], param[1], param[2]);
 		return -1;
 	}
@@ -611,20 +610,20 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	 * to Elantech magic knock and there might be more.
 	 */
 	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
-		pr_debug("elantech.c: failed to query firmware version.\n");
+		pr_debug("failed to query firmware version.\n");
 		return -1;
 	}
 
-	pr_debug("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
+	pr_debug("Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
 		 param[0], param[1], param[2]);
 
 	if (param[0] == 0 || param[1] != 0) {
 		if (!force_elantech) {
-			pr_debug("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
+			pr_debug("Probably not a real Elantech touchpad. Aborting.\n");
 			return -1;
 		}
 
-		pr_debug("elantech.c: Probably not a real Elantech touchpad. Enabling anyway due to force_elantech.\n");
+		pr_debug("Probably not a real Elantech touchpad. Enabling anyway due to force_elantech.\n");
 	}
 
 	if (set_properties) {
@@ -655,7 +654,7 @@ static int elantech_reconnect(struct psmouse *psmouse)
 		return -1;
 
 	if (elantech_set_absolute_mode(psmouse)) {
-		pr_err("elantech.c: failed to put touchpad back into absolute mode.\n");
+		pr_err("failed to put touchpad back into absolute mode.\n");
 		return -1;
 	}
 
@@ -683,7 +682,7 @@ int elantech_init(struct psmouse *psmouse)
 	 * Do the version query again so we can store the result
 	 */
 	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
-		pr_err("elantech.c: failed to query firmware version.\n");
+		pr_err("failed to query firmware version.\n");
 		goto init_fail;
 	}
 
@@ -704,14 +703,14 @@ int elantech_init(struct psmouse *psmouse)
 		etd->paritycheck = 1;
 	}
 
-	pr_info("elantech.c: assuming hardware version %d, firmware version %d.%d.%d\n",
+	pr_info("assuming hardware version %d, firmware version %d.%d.%d\n",
 		etd->hw_version, param[0], param[1], param[2]);
 
 	if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY, param)) {
-		pr_err("elantech.c: failed to query capabilities.\n");
+		pr_err("failed to query capabilities.\n");
 		goto init_fail;
 	}
-	pr_info("elantech.c: Synaptics capabilities query result 0x%02x, 0x%02x, 0x%02x.\n",
+	pr_info("Synaptics capabilities query result 0x%02x, 0x%02x, 0x%02x.\n",
 		param[0], param[1], param[2]);
 	etd->capabilities = param[0];
 
@@ -721,13 +720,12 @@ int elantech_init(struct psmouse *psmouse)
 	 * to jump. Enable a workaround.
 	 */
 	if (etd->fw_version == 0x020022) {
-		pr_info("elantech.c: firmware version 2.0.34 detected, "
-			"enabling jumpy cursor workaround\n");
+		pr_info("firmware version 2.0.34 detected, enabling jumpy cursor workaround\n");
 		etd->jumpy_cursor = 1;
 	}
 
 	if (elantech_set_absolute_mode(psmouse)) {
-		pr_err("elantech.c: failed to put touchpad into absolute mode.\n");
+		pr_err("failed to put touchpad into absolute mode.\n");
 		goto init_fail;
 	}
 
@@ -736,8 +734,7 @@ int elantech_init(struct psmouse *psmouse)
 	error = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
 				   &elantech_attr_group);
 	if (error) {
-		pr_err("elantech.c: failed to create sysfs attributes, error: %d.\n",
-			error);
+		pr_err("failed to create sysfs attributes, error: %d.\n", error);
 		goto init_fail;
 	}
 

