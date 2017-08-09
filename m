From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/2] HID: usbmouse: constify usb_device_id and fix space before '[' error
Date: Wed,  9 Aug 2017 23:51:35 +0530
Message-ID: <1502302895-30181-3-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/hid/usbhid/usbmouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index dd911c5..589ad7c 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -226,7 +226,7 @@ static void usb_mouse_disconnect(struct usb_interface *intf)
 	}
 }
 
-static struct usb_device_id usb_mouse_id_table [] = {
+static const struct usb_device_id usb_mouse_id_table[] = {
 	{ USB_INTERFACE_INFO(USB_INTERFACE_CLASS_HID, USB_INTERFACE_SUBCLASS_BOOT,
 		USB_INTERFACE_PROTOCOL_MOUSE) },
 	{ }	/* Terminating entry */
-- 
2.7.4
