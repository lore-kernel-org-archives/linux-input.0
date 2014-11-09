From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v2  1/3] Input: elantech - report the middle button of the touchpad
Date: Sun,  9 Nov 2014 22:38:35 +0100
Message-ID: <1415569117-29461-2-git-send-email-ulrik.debie-os@e2big.org>
References: <1415569117-29461-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:41426 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaKIVjJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Nov 2014 16:39:09 -0500
In-Reply-To: <1415569117-29461-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

In the past, no elantech was known with 3 touchpad mouse buttons.
Fujitsu H730 is the first known elantech with a middle button. This commit
enables this middle button. For backwards compatibility, the Fujitsu is
detected via DMI, and only for this one 3 buttons will be announced.

Reported-by: Stefan Valouch <stefan@valouch.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ce699eb..8b04b71 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -563,6 +563,7 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
 	} else {
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);
 	}
 
 	input_mt_report_pointer_emulation(dev, true);
@@ -1132,6 +1133,22 @@ static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
 }
 
 /*
+ * Some hw_version 4 models do have a middle button
+ */
+static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Fujitsu H730 has a middle button */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
+		},
+	},
+#endif
+	{ }
+};
+
+/*
  * Set the appropriate event bits for the input subsystem
  */
 static int elantech_set_input_params(struct psmouse *psmouse)
@@ -1150,6 +1167,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	__clear_bit(EV_REL, dev->evbit);
 
 	__set_bit(BTN_LEFT, dev->keybit);
+	if (dmi_check_system(elantech_dmi_has_middle_button))
+		__set_bit(BTN_MIDDLE, dev->keybit);
 	__set_bit(BTN_RIGHT, dev->keybit);
 
 	__set_bit(BTN_TOUCH, dev->keybit);
@@ -1466,6 +1485,7 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
 	{ }
 };
 
+
 /*
  * Some hw_version 3 models go into error state when we try to set
  * bit 3 and/or bit 1 of r10.
-- 
2.1.1

