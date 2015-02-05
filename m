From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Input: soc_button_array - Use "Windows" key for "Home"
Date: Thu, 05 Feb 2015 14:31:23 +0100
Message-ID: <1423143083.14425.34.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60321 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbbBENcm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 08:32:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, lejun.zhu@linux.intel.com
Cc: linux-input@vger.kernel.org

KEY_HOME is the key to go back to the beginning of the line, not
the key to get into an overview mode, as Windows does. GNOME can already
make use of the Windows key on multiple form factors, and other
desktop environments can use it depending on the form factor.

Using "Windows" as the emitted key also means that the keycode sent out
matches the symbol on the key itself.

So switch KEY_HOME to KEY_LEFTMETA ("Windows" key).
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 79cc0f7..e8e010a 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -195,7 +195,7 @@ static int soc_button_probe(struct platform_device *pdev)
 
 static struct soc_button_info soc_button_PNP0C40[] = {
 	{ "power", 0, EV_KEY, KEY_POWER, false, true },
-	{ "home", 1, EV_KEY, KEY_HOME, false, true },
+	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true },
 	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false },
 	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false },
 	{ "rotation_lock", 4, EV_SW, SW_ROTATE_LOCK, false, false },
-- 
2.1.0


