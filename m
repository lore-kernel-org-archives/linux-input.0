From: akpm@linux-foundation.org
Subject: [patch 2/8] wistron_btns: add support for fujitsu-siemens amilo pro edition v3505
Date: Wed, 30 Jul 2008 12:31:36 -0700
Message-ID: <200807301931.m6UJVaYF012049@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53457 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754027AbYG3TcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 15:32:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, rherilier@yahoo.fr, jikos@jikos.cz, mitr@volny.cz

From: Remi Herilier <rherilier@yahoo.fr>

Wistron button support for Fujitsu-Siemens Amilo Pro Edition V3505.

Signed-off-by: Remi Herilier <rherilier@yahoo.fr>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Jiri Kosina <jikos@jikos.cz>
Cc: Miloslav Trmac <mitr@volny.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/misc/wistron_btns.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff -puN drivers/input/misc/wistron_btns.c~wistron_btns-add-support-for-fujitsu-siemens-amilo-pro-edition-v3505 drivers/input/misc/wistron_btns.c
--- a/drivers/input/misc/wistron_btns.c~wistron_btns-add-support-for-fujitsu-siemens-amilo-pro-edition-v3505
+++ a/drivers/input/misc/wistron_btns.c
@@ -277,6 +277,16 @@ static struct key_entry keymap_fs_amilo_
 	{ KE_END,  0 }
 };
 
+static struct key_entry keymap_fs_amilo_pro_v3505[] __initdata = {
+	{ KE_KEY,       0x01, {KEY_HELP} },          /* Fn+F1 */
+	{ KE_KEY,       0x06, {KEY_DISPLAYTOGGLE} }, /* Fn+F4 */
+	{ KE_BLUETOOTH, 0x30 },                      /* Fn+F10 */
+	{ KE_KEY,       0x31, {KEY_MAIL} },          /* mail button */
+	{ KE_KEY,       0x36, {KEY_WWW} },           /* www button */
+	{ KE_WIFI,      0x78 },                      /* satelite dish button */
+	{ KE_END,       0 }
+};
+
 static struct key_entry keymap_fujitsu_n3510[] __initdata = {
 	{ KE_KEY, 0x11, {KEY_PROG1} },
 	{ KE_KEY, 0x12, {KEY_PROG2} },
@@ -618,6 +628,15 @@ static struct dmi_system_id dmi_ids[] __
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Fujitsu-Siemens Amilo Pro Edition V3505",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro Edition V3505"),
+		},
+		.driver_data = keymap_fs_amilo_pro_v3505
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Fujitsu-Siemens Amilo M7400",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
_
