From: Glenn Sommer <gsommer@datanordisk.dk>
Subject: Patch for LG Flatron T1710B touchscreen
Date: Fri, 19 Nov 2010 10:00:55 +0100
Message-ID: <4CE63CC7.9040709@datanordisk.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.pharmanord.com ([194.192.93.42]:33783 "EHLO pharmanord.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751796Ab0KSJBS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 04:01:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

I've recently got my hands on a LG Flatron T1710B touchscreen.
As other LG products, this seems to use the ITM panel.

I've patches my kernel to use the ITM driver with this device, and it seems to work great.

--- PATCH START ---

--- drivers/input/touchscreen/usbtouchscreen.c.orig	2010-11-18 16:33:40.806381557 +0100
+++ drivers/input/touchscreen/usbtouchscreen.c	2010-11-19 09:40:13.909222383 +0100
@@ -173,6 +173,7 @@ static struct usb_device_id usbtouch_dev

  #ifdef CONFIG_TOUCHSCREEN_USB_ITM
  	{USB_DEVICE(0x0403, 0xf9e9), .driver_info = DEVTYPE_ITM},
+	{USB_DEVICE(0x16e3, 0xf9e9), .driver_info = DEVTYPE_ITM},
  #endif

  #ifdef CONFIG_TOUCHSCREEN_USB_ETURB

--- PATCH END ---

-- 
Med venlig hilsen / Best regards
Data Nordisk

Glenn Sommer
