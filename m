From: "yhch" <yhch@generaltouch.com>
Subject: patch for usbtouchscreen.c
Date: Thu, 11 Feb 2010 11:32:06 +0800
Message-ID: <201002111132063289729@generaltouch.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.263xmail.com ([211.150.67.12]:16404 "EHLO
	smtp.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0BKDcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 22:32:12 -0500
Received: from smtp10.263xmail.com (smtp10 [127.0.0.1])
	by smtp10.263xmail.com (Postfix) with ESMTP id 5BEDF950C
	for <linux-input@vger.kernel.org>; Thu, 11 Feb 2010 11:32:06 +0800 (CST)
Received: from PC-200903280540 (smtp10 [127.0.0.1])
	by smtp10.263xmail.com (Postfix) with ESMTP id D70D545D
	for <linux-input@vger.kernel.org>; Thu, 11 Feb 2010 11:32:05 +0800 (CST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi all

--This is time,I paste the patch into my email directly.
There is a problem,that is,the coordinate of Generaltouch touchscreen is limited to 0xFFF by usbtouchscreen.c while many models of our touchscreen give bigger coordinate than that.Could you please apply this patch to linux kernel?

Thanks!

2010-02-03 
Best Regards
Roy.Yin 
Generaltouch.com

--- usbtouchscreen.c	2008-11-21 07:02:37.000000000 +0800
+++ usbtouchscreengt.c	2010-02-03 15:30:57.000000000 +0800
@@ -526,8 +526,8 @@
 #ifdef CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH
 static int general_touch_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 {
-	dev->x = ((pkt[2] & 0x0F) << 8) | pkt[1] ;
-	dev->y = ((pkt[4] & 0x0F) << 8) | pkt[3] ;
+	dev->x = ((pkt[2]) << 8) | pkt[1] ;
+	dev->y = ((pkt[4]) << 8) | pkt[3] ;
 	dev->press = pkt[5] & 0xff;
 	dev->touch = pkt[0] & 0x01;
 
@@ -669,9 +669,9 @@
 #ifdef CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH
 	[DEVTYPE_GENERAL_TOUCH] = {
 		.min_xc		= 0x0,
-		.max_xc		= 0x0500,
+		.max_xc		= 0x0fff,
 		.min_yc		= 0x0,
-		.max_yc		= 0x0500,
+		.max_yc		= 0x0fff,
 		.rept_size	= 7,
 		.read_data	= general_touch_read_data,
 	},

