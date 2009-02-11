From: akpm@linux-foundation.org
Subject: [patch 07/19] drivers/input/keyboard/atkbd.c: Fujitsu Siemens Amilo PA 1510 quirks
Date: Wed, 11 Feb 2009 13:23:45 -0800
Message-ID: <200902112123.n1BLNkUd026637@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39166 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757187AbZBKVYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 16:24:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, impulze@impulze.org

From: Daniel Mierswa <impulze@impulze.org>

The volume up and down keys on the Fujitsu Siemens Amilo PA 1510 laptop
won't generate release events, so we have to do that. Use the same
way that is already used with other models.

Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/keyboard/atkbd.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff -puN drivers/input/keyboard/atkbd.c~drivers-input-keyboard-atkbdc-fujitsu-siemens-amilo-pa-1510-quirks drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c~drivers-input-keyboard-atkbdc-fujitsu-siemens-amilo-pa-1510-quirks
+++ a/drivers/input/keyboard/atkbd.c
@@ -924,6 +924,20 @@ static void atkbd_samsung_keymap_fixup(s
 }
 
 /*
+ * The volume up and volume down special keys on a Fujitsu Amilo PA 1510 laptop
+ * do not generate release events so we have to do it ourselves.
+ */
+static void atkbd_amilopa1510_keymap_fixup(struct atkbd *atkbd)
+{
+	static const unsigned int forced_release_keys[] = {
+		0xb0, 0xae,
+	};
+
+	atkbd_gen_release_event(atkbd, forced_release_keys,
+		ARRAY_SIZE(forced_release_keys));
+}
+
+/*
  * atkbd_set_keycode_table() initializes keyboard's keycode table
  * according to the selected scancode set
  */
@@ -1560,6 +1574,15 @@ static struct dmi_system_id atkbd_dmi_qu
 		.callback = atkbd_setup_fixup,
 		.driver_data = atkbd_samsung_keymap_fixup,
 	},
+	{
+		.ident = "Fujitsu Amilo PA 1510",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 1510"),
+		},
+		.callback = atkbd_setup_fixup,
+		.driver_data = atkbd_amilopa1510_keymap_fixup,
+	},
 	{ }
 };
 
_
