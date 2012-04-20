From: Alexey Kaminsky <me@akaminsky.net>
Subject: Apple Wireless Keyboard 2011 (ANSI) Fn key Bug
Date: Sat, 21 Apr 2012 02:19:18 +0300
Message-ID: <4F91EEF6.6010902@akaminsky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33966 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184Ab2DTXTY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 19:19:24 -0400
Received: by wibhj6 with SMTP id hj6so1116808wib.1
        for <linux-input@vger.kernel.org>; Fri, 20 Apr 2012 16:19:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Hello.

I paired my Apple Wireless Keyboard 2011(ANSI, device id 05AC:0255) with 
my pc.
Almost everything works well, except for the Fn key.I found that  my 
kernel  was  compiled  without support for  hid-apple.
I included this module in my kernel, but Fn-button still not working.

I looked at the source code and saw the missing definition of
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI in apple_devices structure
(hid-apple.c file).

Now everything works fine.

Patch to solve the problem is attached below
Thanks, Alexey Kaminsky.
PS. Link to the bugzilla thread: 
https://bugzilla.kernel.org/show_bug.cgi?id=43135


apple-wireless-ansi-2011.patch

Signed-off-by: Alexey Kaminsky<me@akaminsky.net>
diff -ur linux-3.3-orig/drivers/hid/hid-apple.c 
linux-3.3/drivers/hid/hid-apple.c
--- linux-3.3-orig/drivers/hid/hid-apple.c	2012-04-20 14:17:34.256877478 
+0300
+++ linux-3.3/drivers/hid/hid-apple.c	2012-04-20 17:34:00.915875131 +0300
@@ -458,6 +458,9 @@
   	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
   		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
   			APPLE_ISO_KEYBOARD },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
   	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS),
   		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
   	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),


