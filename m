From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] wistron-btns: Drop Acer Aspire 3020 & 5020 support
Date: Fri, 08 Feb 2008 01:59:41 +0000
Message-ID: <20080208015941.14737.95961.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:35401 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1752033AbYBHB7t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2008 20:59:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>

With acer-wmi now merged, the last reason to keep support for the Acer
Aspire 3020 & 5020 in wistron-btns is gone.

The keys do not need polling, and are already mapped in userspace by HAL.

The other functionality (mail LED, bluetooth and wireless) is already
available in acer-wmi, and surpassed (we can read the status of all these
devices, we can export the backlight, and acer-wmi can also work on
x86-64 with the Aspire 5020, which wistron-btns cannot do).

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Eric Piel <eric.piel@tremplin-utc.net>
---

 drivers/input/misc/wistron_btns.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)


diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 72176f3..eaf0024 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -348,21 +348,6 @@ static struct key_entry keymap_acer_aspire_1600[] __initdata = {
 	{ KE_END, FE_MAIL_LED | FE_UNTESTED }
 };
 
-/* 3020 has been tested */
-static struct key_entry keymap_acer_aspire_5020[] __initdata = {
-	{ KE_KEY, 0x01, {KEY_HELP} },
-	{ KE_KEY, 0x03, {KEY_POWER} },
-	{ KE_KEY, 0x05, {KEY_SWITCHVIDEOMODE} }, /* Display selection */
-	{ KE_KEY, 0x11, {KEY_PROG1} },
-	{ KE_KEY, 0x12, {KEY_PROG2} },
-	{ KE_KEY, 0x31, {KEY_MAIL} },
-	{ KE_KEY, 0x36, {KEY_WWW} },
-	{ KE_KEY, 0x6a, {KEY_CONFIG} },
-	{ KE_WIFI, 0x30 },
-	{ KE_BLUETOOTH, 0x44 },
-	{ KE_END, FE_MAIL_LED | FE_UNTESTED }
-};
-
 static struct key_entry keymap_acer_travelmate_2410[] __initdata = {
 	{ KE_KEY, 0x01, {KEY_HELP} },
 	{ KE_KEY, 0x6d, {KEY_POWER} },
@@ -654,24 +639,6 @@ static struct dmi_system_id dmi_ids[] __initdata = {
 	},
 	{
 		.callback = dmi_matched,
-		.ident = "Acer Aspire 3020",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3020"),
-		},
-		.driver_data = keymap_acer_aspire_5020
-	},
-	{
-		.callback = dmi_matched,
-		.ident = "Acer Aspire 5020",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5020"),
-		},
-		.driver_data = keymap_acer_aspire_5020
-	},
-	{
-		.callback = dmi_matched,
 		.ident = "Acer TravelMate 2100",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

