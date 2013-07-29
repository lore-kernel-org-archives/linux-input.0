From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH 1/5] atkbd: Fix key release for Fn keys on Samsung series 5 ultra 540UC
Date: Mon, 29 Jul 2013 00:59:35 -0300
Message-ID: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56919 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab3G2D7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 23:59:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>

Samsung series 5 ultra notebooks don't produce release events for certain
keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
fixup table.

Note: Fn Lock actually produces two scancodes: 0xa8 and 0xa9.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 drivers/input/keyboard/atkbd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2626773..a18bf03 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -943,6 +943,13 @@ static unsigned int atkbd_samsung_forced_release_keys[] = {
 };
 
 /*
+ * Samsung 530U3C/530U4C/532U3C/540U3C Fn release keys not working
+ */
+static unsigned int atkbd_samsung_530u3c_forced_release_keys[] = {
+	0xa8, 0xa9, 0xb3, 0xce, 0xd5, -1U
+};
+
+/*
  * Amilo Pi 3525 key release for Fn+Volume keys not working
  */
 static unsigned int atkbd_amilo_pi3525_forced_release_keys[] = {
@@ -1732,6 +1739,15 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.driver_data = atkbd_samsung_forced_release_keys,
 	},
 	{
+		/* Samsung series 5 Ultra (530U3C/530U4C/532U3C/540U3C) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "530U3C"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_samsung_530u3c_forced_release_keys,
+	},
+	{
 		/* Fujitsu Amilo PA 1510 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-- 
1.8.3.1

