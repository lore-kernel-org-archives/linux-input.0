From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 6/7] HID: multitouch: remove usbhid dependency
Date: Fri,  8 Feb 2013 15:37:35 +0100
Message-ID: <1360334256-22127-7-git-send-email-benjamin.tissoires@gmail.com>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 32258ba..184ac0a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/input/mt.h>
-#include "usbhid/usbhid.h"
 
 
 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
@@ -907,7 +906,7 @@ static int mt_resume(struct hid_device *hdev)
 
 	intf = to_usb_interface(hdev->dev.parent);
 	interface = intf->cur_altsetting;
-	dev = hid_to_usb_dev(hdev);
+	dev = interface_to_usbdev(intf);
 
 	/* Some Elan legacy devices require SET_IDLE to be set on resume.
 	 * It should be safe to send it to other devices too.
-- 
1.8.1
