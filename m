From: Tom Gundersen <teg@jklm.no>
Subject: [RFC][PATCH] Input: i8042 - fix PNP modaliases when both aux and kdb are enabled
Date: Sun, 26 Jan 2014 22:00:52 +0100
Message-ID: <1390770052-26499-1-git-send-email-teg@jklm.no>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:34794 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbaAZVAV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Jan 2014 16:00:21 -0500
Received: by mail-ea0-f182.google.com with SMTP id r15so1958670ead.27
        for <linux-input@vger.kernel.org>; Sun, 26 Jan 2014 13:00:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Commit 78551277e4 exposed the PNP modaliases for the i8042 module. However,
the aux entries overrode the kbd ones.

Refactor the device_id lists to expose both the aux and the kbd modaliases.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Tom Gundersen <teg@jklm.no>
---
Hi Dmitry,

I don't know if there is a better way to do this, so sending as an RFC.

Cheers,

Tom

 drivers/input/serio/i8042-x86ia64io.h | 67 ++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 0ec9abb..dbc6958 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -747,25 +747,27 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	return 0;
 }
 
-static struct pnp_device_id pnp_kbd_devids[] = {
-	{ .id = "PNP0300", .driver_data = 0 },
-	{ .id = "PNP0301", .driver_data = 0 },
-	{ .id = "PNP0302", .driver_data = 0 },
-	{ .id = "PNP0303", .driver_data = 0 },
-	{ .id = "PNP0304", .driver_data = 0 },
-	{ .id = "PNP0305", .driver_data = 0 },
-	{ .id = "PNP0306", .driver_data = 0 },
-	{ .id = "PNP0309", .driver_data = 0 },
-	{ .id = "PNP030a", .driver_data = 0 },
-	{ .id = "PNP030b", .driver_data = 0 },
-	{ .id = "PNP0320", .driver_data = 0 },
-	{ .id = "PNP0343", .driver_data = 0 },
-	{ .id = "PNP0344", .driver_data = 0 },
-	{ .id = "PNP0345", .driver_data = 0 },
+#define KBD_DEVIDS \
+	{ .id = "PNP0300", .driver_data = 0 }, \
+	{ .id = "PNP0301", .driver_data = 0 }, \
+	{ .id = "PNP0302", .driver_data = 0 }, \
+	{ .id = "PNP0303", .driver_data = 0 }, \
+	{ .id = "PNP0304", .driver_data = 0 }, \
+	{ .id = "PNP0305", .driver_data = 0 }, \
+	{ .id = "PNP0306", .driver_data = 0 }, \
+	{ .id = "PNP0309", .driver_data = 0 }, \
+	{ .id = "PNP030a", .driver_data = 0 }, \
+	{ .id = "PNP030b", .driver_data = 0 }, \
+	{ .id = "PNP0320", .driver_data = 0 }, \
+	{ .id = "PNP0343", .driver_data = 0 }, \
+	{ .id = "PNP0344", .driver_data = 0 }, \
+	{ .id = "PNP0345", .driver_data = 0 }, \
 	{ .id = "CPQA0D7", .driver_data = 0 },
+
+static struct pnp_device_id pnp_kbd_devids[] = {
+	KBD_DEVIDS
 	{ .id = "", },
 };
-MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
 
 static struct pnp_driver i8042_pnp_kbd_driver = {
 	.name           = "i8042 kbd",
@@ -773,21 +775,23 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
 	.probe          = i8042_pnp_kbd_probe,
 };
 
-static struct pnp_device_id pnp_aux_devids[] = {
-	{ .id = "AUI0200", .driver_data = 0 },
-	{ .id = "FJC6000", .driver_data = 0 },
-	{ .id = "FJC6001", .driver_data = 0 },
-	{ .id = "PNP0f03", .driver_data = 0 },
-	{ .id = "PNP0f0b", .driver_data = 0 },
-	{ .id = "PNP0f0e", .driver_data = 0 },
-	{ .id = "PNP0f12", .driver_data = 0 },
-	{ .id = "PNP0f13", .driver_data = 0 },
-	{ .id = "PNP0f19", .driver_data = 0 },
-	{ .id = "PNP0f1c", .driver_data = 0 },
+#define AUX_DEVIDS \
+	{ .id = "AUI0200", .driver_data = 0 }, \
+	{ .id = "FJC6000", .driver_data = 0 }, \
+	{ .id = "FJC6001", .driver_data = 0 }, \
+	{ .id = "PNP0f03", .driver_data = 0 }, \
+	{ .id = "PNP0f0b", .driver_data = 0 }, \
+	{ .id = "PNP0f0e", .driver_data = 0 }, \
+	{ .id = "PNP0f12", .driver_data = 0 }, \
+	{ .id = "PNP0f13", .driver_data = 0 }, \
+	{ .id = "PNP0f19", .driver_data = 0 }, \
+	{ .id = "PNP0f1c", .driver_data = 0 }, \
 	{ .id = "SYN0801", .driver_data = 0 },
+
+static struct pnp_device_id pnp_aux_devids[] = {
+	AUX_DEVIDS
 	{ .id = "", },
 };
-MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
 
 static struct pnp_driver i8042_pnp_aux_driver = {
 	.name           = "i8042 aux",
@@ -795,6 +799,13 @@ static struct pnp_driver i8042_pnp_aux_driver = {
 	.probe          = i8042_pnp_aux_probe,
 };
 
+static struct pnp_device_id pnp_kdb_aux_devids[] = {
+	KBD_DEVIDS
+	AUX_DEVIDS
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_kdb_aux_devids);
+
 static void i8042_pnp_exit(void)
 {
 	if (i8042_pnp_kbd_registered) {
-- 
1.8.5.3

