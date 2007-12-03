From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH 4/4] apanel: use generic keycode routines
Date: Mon, 03 Dec 2007 14:18:11 -0800
Message-ID: <20071203221901.004608464@linux-foundation.org>
References: <20071203221807.077325020@linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41825 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752628AbXLCWVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Dec 2007 17:21:13 -0500
Content-Disposition: inline; filename=fujitsu-apanel-generic-keymap.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

Don't need driver specific keymap routines, generic keycode routines
will work fine.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>


--- a/drivers/input/misc/apanel.c	2007-11-21 17:32:36.000000000 -0800
+++ b/drivers/input/misc/apanel.c	2007-11-21 17:39:24.000000000 -0800
@@ -120,33 +120,6 @@ static void apanel_poll(struct input_pol
 			report_key(idev, ap->keymap[i]);
 }
 
-static int apanel_getkeycode(struct input_dev *idev, int scancode, int *keycode)
-{
-	struct apanel *ap = idev->private;
-
-	if (scancode < 0 || scancode >= MAX_PANEL_KEYS)
-		return -EINVAL;
-
-	*keycode = ap->keymap[scancode];
-	return 0;
-}
-
-static int apanel_setkeycode(struct input_dev *idev, int scancode, int keycode)
-{
-	struct apanel *ap = idev->private;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	if (scancode < 0 || scancode >= MAX_PANEL_KEYS)
-		return -EINVAL;
-
-	clear_bit(ap->keymap[scancode], idev->keybit);
-	ap->keymap[scancode] = keycode;
-	set_bit(keycode, idev->keybit);
-	return 0;
-}
-
 /* Track state changes of LED */
 static void led_update(struct work_struct *work)
 {
@@ -274,11 +247,11 @@ static int apanel_probe(struct i2c_adapt
 	idev->phys = "apanel/input0";
 	idev->id.bustype = BUS_HOST;
 	idev->dev.parent = &ap->client.dev;
-	idev->getkeycode = apanel_getkeycode;
-	idev->setkeycode = apanel_setkeycode;
 
 	set_bit(EV_KEY, idev->evbit);
 
+	idev->keycode = ap->keymap;
+	idev->keycodesize = sizeof(ap->keymap[0]);
 	idev->keycodemax = (device_chip[APANEL_DEV_CDBTN] != CHIP_NONE) ? 12 : 4;
 
 	for (i = 0; i < idev->keycodemax; i++)

-- 

