From: Rikard Ljungstrand <lrikard@student.chalmers.se>
Subject: [PATCH] Input: Add keyboard quirk for HP Pavilion ZV6100 laptop
Date: Tue, 25 Nov 2008 11:53:48 +0100
Message-ID: <492BD93C.5070108@student.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atum.ita.chalmers.se ([129.16.4.148]:42481 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbYKYLAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2008 06:00:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, apw@canonical.com

Add quirk for misbehaving volume buttons on HP Pavilion ZV6100 laptop which
are not sending keyrelease events, as reported by Aaron Pickett.

Signed-off-by: Rikard Ljungstrand <lrikard@student.chalmers.se>
---
 drivers/input/keyboard/atkbd.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index b1ce10f..1a3798e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -868,6 +868,23 @@ static void atkbd_hp_keymap_fixup(struct atkbd *atkbd)
 }
 
 /*
+ * Perform fixup for HP Pavilion ZV6100 laptop that doesn't generate release
+ * for its volume buttons
+ */
+static void atkbd_hp_zv6100_keymap_fixup(struct atkbd *atkbd)
+{
+	const unsigned int forced_release_keys[] = {
+		0xae, 0xb0,
+	};
+	int i;
+
+	if (atkbd->set == 2)
+		for (i = 0; i < ARRAY_SIZE(forced_release_keys); i++)
+			__set_bit(forced_release_keys[i],
+					atkbd->force_release_mask);
+}
+
+/*
  * atkbd_set_keycode_table() initializes keyboard's keycode table
  * according to the selected scancode set
  */
@@ -1478,6 +1495,15 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 		.callback = atkbd_setup_fixup,
 		.driver_data = atkbd_hp_keymap_fixup,
 	},
+	{
+		.ident = "HP Pavilion ZV6100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion ZV6100"),
+		},
+		.callback = atkbd_setup_fixup,
+		.driver_data = atkbd_hp_zv6100_keymap_fixup,
+	},
 	{ }
 };
 
-- 1.5.6.3 
