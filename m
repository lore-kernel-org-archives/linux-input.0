From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH mmotm] hid-picolcd: depends on LCD_CLASS_DEVICE
Date: Mon, 5 Apr 2010 22:04:14 -0700
Message-ID: <20100405220414.9d90da83.randy.dunlap@oracle.com>
References: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:40615 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0DFFFl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 01:05:41 -0400
In-Reply-To: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: akpm@linux-foundation.org, rvinyard@cs.nmsu.edu, Jiri Kosina <jkosina@suse.cz>

From: Randy Dunlap <randy.dunlap@oracle.com>

HID_PICOLCD should depend on LCD_CLASS_DEVICE, otherwise the
build fails when HID_PICOLCD=y and LCD_CLASS_DEVICE=m:

hid-picolcd.c:(.text+0x84523f): undefined reference to `lcd_device_unregister'
hid-picolcd.c:(.text+0x8478ab): undefined reference to `lcd_device_register'
hid-picolcd.c:(.text+0x84c15f): undefined reference to `lcd_device_unregister'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/hid/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2010-0405-1609.orig/drivers/hid/Kconfig
+++ mmotm-2010-0405-1609/drivers/hid/Kconfig
@@ -265,6 +265,7 @@ config HID_PETALYNX
 config HID_PICOLCD
 	tristate "PicoLCD (graphic version)"
 	depends on USB_HID
+	depends on LCD_CLASS_DEVICE
 	select FB_DEFERRED_IO if FB
 	select FB_SYS_FILLRECT if FB
 	select FB_SYS_COPYAREA if FB
