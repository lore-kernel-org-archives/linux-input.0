From: Stefan Kriwanek <dev@stefankriwanek.de>
Subject: [PATCH] hid: Fix Speedlink VAD Cezanne support for some devices
Date: Tue, 30 Jul 2013 12:38:20 +0200
Message-ID: <51F7979C.4030306@stefankriwanek.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wp123.webpack.hosteurope.de ([80.237.132.130]:54433 "EHLO
	wp123.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208Ab3G3K4Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 06:56:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello,

I obtained a mouse device "Speedlink VAD Cezanne" that needs more aggressive fixing than already done in the driver. It, however, reports itself the same as the model hid-speedlink.c was written for.

The patch applies to any kernel from 3.1 to current 3.11-rc3, since the file hasn't ever been touched since then.

Please also note that I made sure through testing that this patch would not interfere with the proper working of a device that is bug-free: The driver drops EV_REL events with abs(val) >= 256, which are not achievable even on the highest laser resolution hardware setting. Hence I believe it is safe to also apply to the older kernels (that is, if your policy does allow that).


Signed-off-by: Stefan Kriwanek <mail@stefankriwanek.de>

---


--- linux-source-3.5.0/drivers/hid/hid-speedlink.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-source-3.5.0-speedlink/drivers/hid/hid-speedlink.c	2013-07-30 12:24:22.113302655 +0200
@@ -3,7 +3,7 @@
  *  Fixes "jumpy" cursor and removes nonexistent keyboard LEDS from
  *  the HID descriptor.
  *
- *  Copyright (c) 2011 Stefan Kriwanek <mail@stefankriwanek.de>
+ *  Copyright (c) 2011, 2013 Stefan Kriwanek <dev@stefankriwanek.de>
  */
 
 /*
@@ -49,7 +49,7 @@ static int speedlink_event(struct hid_de
 {
 	/* No other conditions due to usage_table. */
 	/* Fix "jumpy" cursor (invalid events sent by device). */
-	if (value == 256)
+	if (abs(value) >= 256)
 		return 1;
 	/* Drop useless distance 0 events (on button clicks etc.) as well */
 	if (value == 0)

