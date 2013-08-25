From: Stefan Kriwanek <dev@stefankriwanek.de>
Subject: Re: [PATCH] hid: Fix Speedlink VAD Cezanne support for some devices
Date: Sun, 25 Aug 2013 10:46:13 +0200
Message-ID: <5219C455.7040309@stefankriwanek.de>
References: <51F7979C.4030306@stefankriwanek.de> <alpine.LNX.2.00.1307302258080.18809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wp123.webpack.hosteurope.de ([80.237.132.130]:60664 "EHLO
	wp123.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756127Ab3HYIqS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Aug 2013 04:46:18 -0400
In-Reply-To: <alpine.LNX.2.00.1307302258080.18809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Some devices of the "Speedlink VAD Cezanne" model need more aggressive fixing than already done.

I made sure through testing that this patch would not interfere with the proper working of a device that is bug-free. (The driver drops EV_REL events with abs(val) >= 256, which are not achievable even on the highest laser resolution hardware setting.) Hence, I believe it is safe to also apply to older kernels (that is, if your policy allows).

The patch applies to any kernel from 3.1 to current 3.11-rc6.


Signed-off-by: Stefan Kriwanek <mail@stefankriwanek.de>

---

--- linux-source-3.5.0/drivers/hid/hid-speedlink.c
+++ linux-source-3.5.0-speedlink/drivers/hid/hid-speedlink.c
@@ -3,7 +3,7 @@
  *  Fixes "jumpy" cursor and removes nonexistent keyboard LEDS from
  *  the HID descriptor.
  *
- *  Copyright (c) 2011 Stefan Kriwanek <mail@stefankriwanek.de>
+ *  Copyright (c) 2011, 2013 Stefan Kriwanek <dev@stefankriwanek.de>
  */
 
 /*
@@ -48,8 +48,13 @@ static int speedlink_event(struct hid_de
 		struct hid_usage *usage, __s32 value)
 {
 	/* No other conditions due to usage_table. */
-	/* Fix "jumpy" cursor (invalid events sent by device). */
-	if (value == 256)
+
+	/* This fixes the "jumpy" cursor occuring due to invalid events sent
+	 * by the device. Some devices only send them with value==+256, others
+	 * don't. However, catching abs(value)>=256 is restrictive enough not
+	 * to interfere with devices that were bug-free (has been tested).
+	 */
+	if (abs(value) >= 256)
 		return 1;
 	/* Drop useless distance 0 events (on button clicks etc.) as well */
 	if (value == 0)

