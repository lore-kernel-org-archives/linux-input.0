From: "Adel Gadllah" <adel.gadllah@gmail.com>
Subject: [PATCH v2] atkbd: Keymap quirk for Inventec Symphony systems
Date: Sun, 2 Nov 2008 15:42:43 +0100
Message-ID: <6cf6b73e0811020642s3c263c43uedac10334f7e9f6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:50489 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYKBOmo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2008 09:42:44 -0500
Received: by qw-out-2122.google.com with SMTP id 3so925907qwe.37
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2008 06:42:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mjg@redhat.com

Fix spelling errors.

----

From: Matthew Garrett <mjg@redhat.com>

The Zepto 6615WD laptop (rebranded Inventec Symphony system) needs a
key release quirk
for its volume keys to work. The attached patch adds the quirk to the
atkbd driver.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=460237

Cc: stable@vger.kernel.org
Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Adel Gadllah <adel.gadllah@gmail.com>

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -868,6 +868,22 @@ static void atkbd_hp_keymap_fixup(struct atkbd *atkbd)
 }

 /*
+ * Inventec system with broken key release on volume keys
+ */
+static void atkbd_inventec_keymap_fixup(struct atkbd *atkbd)
+{
+	const unsigned int forced_release_keys[] = {
+		0xae, 0xb0,
+	};
+	int i;
+
+	if (atkbd->set == 2)
+		for (i = 0; i < ARRAY_SIZE(forced_release_keys); i++)
+			__set_bit(forced_release_keys[i],
+				  atkbd->force_release_mask);
+}
+
+/*
  * atkbd_set_keycode_table() initializes keyboard's keycode table
  * according to the selected scancode set
  */
@@ -1468,6 +1484,15 @@ static struct dmi_system_id
atkbd_dmi_quirk_table[] __initdata = {
 		.callback = atkbd_setup_fixup,
 		.driver_data = atkbd_hp_keymap_fixup,
 	},
+	{
+		.ident = "Inventec Symphony",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "INVENTEC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SYMPHONY 6.0/7.0"),
+		},
+		.callback = atkbd_setup_fixup,
+		.driver_data = atkbd_inventec_keymap_fixup,
+	},
 	{ }
 };
