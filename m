From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH 2/5] atkbd: Fix key release for Fn keys on Samsung series 5 550P5C
Date: Mon, 29 Jul 2013 00:59:36 -0300
Message-ID: <1375070379-329-2-git-send-email-m.chehab@samsung.com>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56914 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab3G2D7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 23:59:46 -0400
In-Reply-To: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>

Fix key release for Fn keys with Samsung series 5

Samsung series 5 notebooks don't produce release events for certain
keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
fixup table.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 drivers/input/keyboard/atkbd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index a18bf03..298ac1d 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -950,6 +950,13 @@ static unsigned int atkbd_samsung_530u3c_forced_release_keys[] = {
 };
 
 /*
+ * Samsung 550P5C/550P7C Fn release keys not working
+ */
+static unsigned int atkbd_samsung_550p5c_forced_release_keys[] = {
+	0xa8, 0xa9, 0xc5, 0xce, 0xd5, -1U
+};
+
+/*
  * Amilo Pi 3525 key release for Fn+Volume keys not working
  */
 static unsigned int atkbd_amilo_pi3525_forced_release_keys[] = {
@@ -1748,6 +1755,15 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.driver_data = atkbd_samsung_530u3c_forced_release_keys,
 	},
 	{
+		/* Samsung series 5 (550P5C/550P7C) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "550P5C"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_samsung_550p5c_forced_release_keys,
+	},
+	{
 		/* Fujitsu Amilo PA 1510 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-- 
1.8.3.1

