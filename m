From: Patrick Scheuring <patrick.scheuring.dev@gmail.com>
Subject: [PATCH] Input: i8042 - add XMG C504 to keyboard reset table
Date: Thu,  8 Sep 2016 23:44:35 +0200
Message-ID: <20160908214435.15972-1-patrick.scheuring.dev@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33056 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbcIHVox (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2016 17:44:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: aurelien@francillon.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Patrick Scheuring <patrick.scheuring.dev@gmail.com>

From: Patrick Scheuring <patrick.scheuring.dev@gmail.com>

The Schenker XMG C504 is a rebranded Gigabyte P35 v2 laptop.
Therefore it also needs a keyboard reset to detect the Elantech touchpad.
Otherwise the touchpad appears to be dead.

With this patch the touchpad is detected:

$ dmesg | grep -E "(i8042|Elantech|elantech)"

[    2.675399] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    2.680372] i8042: Attempting to reset device connected to KBD port
[    2.789037] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.791586] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.813840] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    3.811431] psmouse serio1: elantech: assuming hardware version 4 (with firmware version 0x361f0e)
[    3.825424] psmouse serio1: elantech: Synaptics capabilities query result 0x00, 0x15, 0x0f.
[    3.839424] psmouse serio1: elantech: Elan sample query result 03, 58, 74
[    3.911349] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input6

Signed-off-by: Patrick Scheuring <patrick.scheuring.dev@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 68f5f4a..4187019 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -793,6 +793,13 @@ static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
 		},
 	},
+	{
+		/* Schenker XMG C504 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
+		},
+	},
 	{ }
 };
 
-- 
2.9.3

