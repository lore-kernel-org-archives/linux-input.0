From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] Fix key release for Fn keys with Samsung series 5 ultra
Date: Sun, 28 Jul 2013 07:08:27 -0300
Message-ID: <20130728070827.32e7cd31@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54330 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab3G1KIc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 06:08:32 -0400
Received: from [177.143.133.66] (helo=localhost.localdomain)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1V3Ntv-000703-U7
	for linux-input@vger.kernel.org; Sun, 28 Jul 2013 10:08:32 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Samsung series 5 ultra notebooks don't produce release events for certain
keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
fixup table.

Note: Fn Lock actually produces two scancodes: 0xa8 and 0xa9.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2626773..90c3113 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -943,6 +943,13 @@ static unsigned int atkbd_samsung_forced_release_keys[] = {
 };
 
 /*
+ * Samsung 530U3C/530U4C/532U3C/540U3C Fn release keys not working
+ */
+static unsigned int atkbd_samsung_ultra_forced_release_keys[] = {
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
+		.driver_data = atkbd_samsung_ultra_forced_release_keys,
+	},
+	{
 		/* Fujitsu Amilo PA 1510 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),




Cheers,
Mauro
