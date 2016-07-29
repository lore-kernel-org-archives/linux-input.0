From: Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH] Input: atkbd - filter buggy codes on ASUS Q500A
Date: Fri, 29 Jul 2016 21:41:44 +0200
Message-ID: <1469821304-30255-1-git-send-email-linux@rempel-privat.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:61904 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbcG2Tl6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jul 2016 15:41:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some revision of ASUS Q500A series have keyboard related
issue which is reproducible only if Windows with installed ASUS
tools was ever started.
In this case the Linux side will have blocked keyboard or
report wrong or incomplete hotkey events.
To make Linux work properly again complete power down
(unplug power supply and remove battery) should be made.

Linux/atkbd after clean start will get fallowing code on VOLUME_UP
key: {0xe0, 0x30, 0xe0, 0xb0}. After Windows, same key will generate this
codes: {0xe1, 0x23, 0xe0, 0x30, 0xe0, 0xb0}. As result atkdb will
be confused by buggy codes.

This patch is filtering this buggy code out.

https://bugzilla.kernel.org/show_bug.cgi?id=119391

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Sponsored-by: Alex Henrie <alexhenrie24@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index ec876b5..949c199 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -996,6 +996,17 @@ static unsigned int atkbd_oqo_01plus_scancode_fixup(struct atkbd *atkbd,
 	return code;
 }
 
+static unsigned int atkbd_asus_q500a_scancode_fixup(struct atkbd *atkbd,
+						    unsigned int code)
+{
+	if (atkbd->translated && atkbd->emul == 2 && code == 0x23) {
+		atkbd->emul = 0;
+		return ATKBD_RET_ERR;
+	}
+
+	return code;
+}
+
 /*
  * atkbd_set_keycode_table() initializes keyboard's keycode table
  * according to the selected scancode set
@@ -1802,6 +1813,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Q500A"),
+		},
+		.callback = atkbd_setup_scancode_fixup,
+		.driver_data = atkbd_asus_q500a_scancode_fixup,
+	},
 	{ }
 };
 
-- 
2.7.4

