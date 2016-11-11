From: Chris Diamand <chris@diamand.org>
Subject: [PATCH] Input: byd - use DMI detection
Date: Fri, 11 Nov 2016 23:57:59 +0000
Message-ID: <20161111235759.11988-1-chris@diamand.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36117 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964958AbcKKX6N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Nov 2016 18:58:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so655123wma.3
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2016 15:58:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Pospesel <pospeselr@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: phonesyfreakies@gmail.com, Michael Shell <list1@michaelshell.org>, Ondrej Zary <linux@rainbow-software.org>, Chris Diamand <chris@diamand.org>

Because the BYD touchpad uses standard PS/2 commands for its
detection sequence, some other models are incorrectly detected as BYD
touchpads. This causes chaos when byd_init() later fails.

To fix this, init() and detect() should be merged. However, this
would slow down detection for other mouse models. Instead, add a DMI
check before attempting touchpad detection.

Signed-off-by: Chris Diamand <chris@diamand.org>
---
Hi all,

This patch should fix the mis-detection of some mouse models as BYD touchpads,
as mentioned in a few bug reports and other threads.

However, I no longer have a machine with a BYD touchpad (although I did record
its DMI data), so this is mostly untested - could anyone *with* a BYD touchpad
please try this patch to check their touchpad still works, and could anyone
with a misdetected non-BYD touchpad please check that this fixes the
misdetection?

Also, the DMI fields really are pretty much all like that ("To Be Filled By
O.E.M.", etc). I've tried to choose the most specific ones, but it's still
fairly arbitrary...

Cheers!
Chris

 drivers/input/mouse/byd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index b27aa63..b4c5fd0 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/libps2.h>
 #include <linux/serio.h>
@@ -235,6 +236,17 @@ struct byd_data {
 	bool touch;
 };
 
+static const struct dmi_system_id byd_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "SharkBay Platform"),
+			DMI_MATCH(DMI_PRODUCT_SERIAL, "System Serial Number"),
+			DMI_MATCH(DMI_BOARD_NAME, "WhiteTip Mountain1 Fab2"),
+			DMI_MATCH(DMI_CHASSIS_VENDOR, "To Be Filled By O.E.M."),
+		},
+	},
+};
+
 static void byd_report_input(struct psmouse *psmouse)
 {
 	struct byd_data *priv = psmouse->private;
@@ -439,6 +451,9 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
 
+	if (!dmi_check_system(byd_dmi_table))
+		return -1;
+
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
 		return -1;
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-- 
2.10.1

