From: Glenn Sommer <gsommer@datanordisk.dk>
Subject: LG Flatron T1710B kernel driver
Date: Thu, 18 Nov 2010 16:50:00 +0100
Message-ID: <4CE54B28.8080205@datanordisk.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.pharmanord.com ([194.192.93.42]:48375 "EHLO pharmanord.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754945Ab0KRQuC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 11:50:02 -0500
Received: from [10.45.2.23] (HELO appserver26.pharmanord.com)
  by pharmanord.com (CommuniGate Pro SMTP 5.3.1)
  with ESMTP id 13192787 for linux-input@vger.kernel.org; Thu, 18 Nov 2010 16:50:00 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The LG Flatron T1710B touchscreen seems to be a ITM display

I've patched my kernel, and testet the screen using the ITM drivers, and 
it seems to work fine.

Just update the list of devices, like this:

--- usbtouchscreen.c.orig	2010-11-18 16:33:40.806381557 +0100
+++ usbtouchscreen.c	2010-11-17 16:25:23.794528671 +0100
@@ -173,6 +173,7 @@

  #ifdef CONFIG_TOUCHSCREEN_USB_ITM
  	{USB_DEVICE(0x0403, 0xf9e9), .driver_info = DEVTYPE_ITM},
+	{USB_DEVICE(0x16e3, 0xf9e9), .driver_info = DEVTYPE_ITM},
  #endif

  #ifdef CONFIG_TOUCHSCREEN_USB_ETURBO



-- 
Med venlig hilsen / Best regards
Data Nordisk

Glenn Sommer
