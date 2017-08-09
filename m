From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/2] HID: usbkbd: constify usb_device_id and fix space before '[' error.
Date: Wed,  9 Aug 2017 23:51:34 +0530
Message-ID: <1502302895-30181-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502302895-30181-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502302895-30181-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Fix checkpatch.pl error:
ERROR: space prohibited before open square bracket '['.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/usbhid/usbkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 7fb2d1e..ed01dc4 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -392,7 +392,7 @@ static void usb_kbd_disconnect(struct usb_interface *intf)
 	}
 }
 
-static struct usb_device_id usb_kbd_id_table [] = {
+static const struct usb_device_id usb_kbd_id_table[] = {
 	{ USB_INTERFACE_INFO(USB_INTERFACE_CLASS_HID, USB_INTERFACE_SUBCLASS_BOOT,
 		USB_INTERFACE_PROTOCOL_KEYBOARD) },
 	{ }						/* Terminating entry */
-- 
2.7.4
