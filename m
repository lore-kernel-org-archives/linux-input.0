From: Tracey Dent <tdent48227@gmail.com>
Subject: [PATCH 2/2] Drivers: hid: usbhid: Makefile: Cleaned up Makefile
Date: Sat,  6 Nov 2010 15:07:44 -0400
Message-ID: <1289070464-3392-2-git-send-email-tdent48227@gmail.com>
References: <1289070464-3392-1-git-send-email-tdent48227@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36075 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0KFTHc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 15:07:32 -0400
In-Reply-To: <1289070464-3392-1-git-send-email-tdent48227@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, spbnick@gmail.com, dtor@mail.ru, chatty@enac.fr, Tracey Dent <tdent48227@gmail.com>

Changed Makefile to use <modules>-y instead of <modules>-objs.

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
---
 drivers/hid/usbhid/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/Makefile b/drivers/hid/usbhid/Makefile
index 1329ecb..db3cf31 100644
--- a/drivers/hid/usbhid/Makefile
+++ b/drivers/hid/usbhid/Makefile
@@ -3,15 +3,15 @@
 #
 
 # Multipart objects.
-usbhid-objs	:= hid-core.o hid-quirks.o
+usbhid-y	:= hid-core.o hid-quirks.o
 
 # Optional parts of multipart objects.
 
 ifeq ($(CONFIG_USB_HIDDEV),y)
-	usbhid-objs	+= hiddev.o
+	usbhid-y	+= hiddev.o
 endif
 ifeq ($(CONFIG_HID_PID),y)
-	usbhid-objs	+= hid-pidff.o
+	usbhid-y	+= hid-pidff.o
 endif
 
 obj-$(CONFIG_USB_HID)		+= usbhid.o
-- 
1.7.3.1.104.gc752e

