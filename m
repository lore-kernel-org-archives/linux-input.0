From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/7] X86 drivers: Introduce msi-wmi driver
Date: Mon, 14 Dec 2009 10:55:33 +0100
Message-ID: <20091214105533.6634312b@destiny.ordissimo>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
	<1260451099-25620-2-git-send-email-anisse@astier.eu>
	<9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35242 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbZLNJ6s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2009 04:58:48 -0500
In-Reply-To: <9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>

Hi,

This should fix the last issues. It applies at the end of the patch serie, (not
on top of the patch you reviewed), but it should be pretty similar.

Should I resend all the patches? Set up a git tree somewhere to pull from?

Regards.

From: Anisse Astier <anisse@astier.eu>
Date: Mon, 14 Dec 2009 10:21:39 +0100
Subject: [PATCH] msi-wmi: depend on backlight and fix corner-cases problems

Now depends on BACKLIGHT_CLASS_DEVICE.
Driver will return an error if it can't get actual backlight value
Fix remapping of brightness keys when backlight is not controlled by ACPI.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/Kconfig   |    1 +
 drivers/platform/x86/msi-wmi.c |   23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1f82d6d..a006dec 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -369,6 +369,7 @@ config MSI_WMI
 	tristate "MSI WMI extras"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on BACKLIGHT_CLASS_DEVICE
 	select INPUT_SPARSEKMAP
 	help
 	 Say Y here if you want to support WMI-based hotkeys on MSI laptops.
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index e25b80c..0c8fe14 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -53,11 +53,15 @@ MODULE_ALIAS("dmi:*:svnMICRO-STARINTERNATIONAL*:pnMS-6638:*");
 #define dprintk(msg...) pr_debug(DRV_PFX msg)
 
 #define KEYCODE_BASE 0xD0
+#define MSI_WMI_BRIGHTNESSUP   KEYCODE_BASE
+#define MSI_WMI_BRIGHTNESSDOWN (KEYCODE_BASE + 1)
+#define MSI_WMI_VOLUMEUP       (KEYCODE_BASE + 2)
+#define MSI_WMI_VOLUMEDOWN     (KEYCODE_BASE + 3)
 static struct key_entry msi_wmi_keymap[] = {
-	{ KE_KEY, KEYCODE_BASE,     {KEY_BRIGHTNESSUP} },
-	{ KE_KEY, KEYCODE_BASE + 1, {KEY_BRIGHTNESSDOWN} },
-	{ KE_KEY, KEYCODE_BASE + 2, {KEY_VOLUMEUP} },
-	{ KE_KEY, KEYCODE_BASE + 3, {KEY_VOLUMEDOWN} },
+	{ KE_KEY, MSI_WMI_BRIGHTNESSUP,   {KEY_BRIGHTNESSUP} },
+	{ KE_KEY, MSI_WMI_BRIGHTNESSDOWN, {KEY_BRIGHTNESSDOWN} },
+	{ KE_KEY, MSI_WMI_VOLUMEUP,       {KEY_VOLUMEUP} },
+	{ KE_KEY, MSI_WMI_VOLUMEDOWN,     {KEY_VOLUMEDOWN} },
 	{ KE_END, 0}
 };
 static ktime_t last_pressed[ARRAY_SIZE(msi_wmi_keymap) - 1];
@@ -110,12 +114,14 @@ static int msi_wmi_set_block(int instance, int value)
 
 static int bl_get(struct backlight_device *bd)
 {
-	int level, err, ret = 0;
+	int level, err, ret;
 
 	/* Instance 1 is "get backlight", cmp with DSDT */
 	err = msi_wmi_query_block(1, &ret);
-	if (err)
+	if (err) {
 		printk(KERN_ERR DRV_PFX "Could not query backlight: %d\n", err);
+		return -EINVAL;
+	}
 	dprintk("Get: Query block returned: %d\n", ret);
 	for (level = 0; level < ARRAY_SIZE(backlight_map); level++) {
 		if (backlight_map[level] == ret) {
@@ -180,8 +186,9 @@ static void msi_wmi_notify(u32 value, void *context)
 
 			if (key->type == KE_KEY &&
 			/* Brightness is served via acpi video driver */
-			(backlight || (key->keycode != KEY_BRIGHTNESSUP &&
-			key->keycode != KEY_BRIGHTNESSDOWN))) {
+			(!acpi_video_backlight_support() ||
+			(key->code != MSI_WMI_BRIGHTNESSUP &&
+			key->code != MSI_WMI_BRIGHTNESSDOWN))) {
 				dprintk("Send key: 0x%X - "
 					"Input layer keycode: %d\n", key->code,
 					 key->keycode);
-- 
1.6.5.3


