From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Fixed bug in single-touch emulation on the Stantum panel
Date: Sat, 06 Feb 2010 15:19:12 +0100
Message-ID: <20100206141912.71BA89520A@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:33279 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0BFOTN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Feb 2010 09:19:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: chatty@enac.fr


Fixed bug in touchscreen emulation for the Stantum multitouch panel

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN a/drivers/hid/hid-stantum.c b/drivers/hid/hid-stantum.c
--- a/drivers/hid/hid-stantum.c	2010-02-06 14:59:57.000000000 +0100
+++ b/drivers/hid/hid-stantum.c	2010-02-06 15:00:36.000000000 +0100
@@ -16,7 +16,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 
-MODULE_VERSION("1.00");
+MODULE_VERSION("1.01");
 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
 MODULE_DESCRIPTION("Stantum HID multitouch panels");
 MODULE_LICENSE("GPL");
@@ -147,7 +147,6 @@ static void stantum_filter_event(struct 
 
 	input_mt_sync(input);
 	sd->valid = false;
-	sd->first = false;
 
 	/* touchscreen emulation */
 	if (sd->first) {
@@ -158,6 +157,7 @@ static void stantum_filter_event(struct 
 		input_event(input, EV_ABS, ABS_X, sd->x);
 		input_event(input, EV_ABS, ABS_Y, sd->y);
 	}
+	sd->first = false;
 }
 
 
