From: Daniel Mierswa <impulze@impulze.org>
Subject: Re: [PATCH] Fujitsu Amilo PA 1510 key-release events quirk (PATCH
 3/3)
Date: Mon, 01 Dec 2008 22:01:26 +0100
Message-ID: <493450A6.7050108@impulze.org>
References: <4931BB48.9010706@impulze.org> <20081129233826.be959cae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060908080701040102060805"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754157AbYLAVBW@vger.kernel.org>
In-Reply-To: <20081129233826.be959cae.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------060908080701040102060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Split patches as requested in "[PATCH] Fujitsu Amilo PA 1510 key-release
events quirk"

-- 

Mierswa, Daniel

If you still don't like it, that's ok: that's why I'm boss. I simply 
know better than you do.
                --- Linus Torvalds, comp.os.linux.advocacy, 1996/07/22



--------------060908080701040102060805
Content-Type: text/plain;
 name="fujitsu-siemens-amilopa1510-quirks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fujitsu-siemens-amilopa1510-quirks.patch"

>From 1a786f4d720ad0dbaf4b8a03a5237b8433753a4d Mon Sep 17 00:00:00 2001
From: Daniel Mierswa <impulze@impulze.org>
Date: Sun, 30 Nov 2008 13:17:01 +0100
Subject: [PATCH] Fujitsu Siemens Amilo PA 1510 quirks

The volume up and down keys on the Fujitsu Siemens Amilo PA 1510 laptop
won't generate release events, so we have to do that. Use the same
way that is already used with other models.
---
 drivers/input/keyboard/atkbd.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 11ded7e..7347cd4 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -875,6 +875,20 @@ static void atkbd_hp_keymap_fixup(struct atkbd *atkbd)
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
@@ -1475,6 +1489,15 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 		.callback = atkbd_setup_fixup,
 		.driver_data = atkbd_hp_keymap_fixup,
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
 
-- 
1.6.0.4




--------------060908080701040102060805--
