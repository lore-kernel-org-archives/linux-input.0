From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Subject: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad button mapping for the Caroline Chromebook.
Date: Wed, 25 Apr 2018 14:32:58 +0200
Message-ID: <201804251232.w3PCWweA028076@mail.vittgam.net>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org, nick@shmanahar.org, dmitry.torokhov@gmail.com, bleung@chromium.org
Cc: Salvatore Bellizzi <lkml@seppia.net>
List-Id: linux-input@vger.kernel.org

This patch adds the correct platform data information for the Caroline
Chromebook, so that the mouse button does not get stuck in pressed state
after the first click.

The Samus button keymap and platform data definition are the correct
ones for Caroline, so they have been reused here.

v2: updated patch offset after 20180409 changes.

Cc: stable@vger.kernel.org
Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>

---

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3035,6 +3035,15 @@
 		.driver_data = samus_platform_data,
 	},
 	{
+		/* Samsung Chromebook Pro */
+		.ident = "Samsung Chromebook Pro",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
+		},
+		.driver_data = samus_platform_data,
+	},
+	{
 		/* Other Google Chromebooks */
 		.ident = "Chromebook",
 		.matches = {
