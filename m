From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 7/8] Input: acecad: constify usb_device_idi and fix space before '[' error.
Date: Sun,  6 Aug 2017 13:11:26 +0530
Message-ID: <1502005287-17705-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Fix checkpatch.pl error:
ERROR: space prohibited before open square bracket '['.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/tablet/acecad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index e86e377..77f41a5 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -260,7 +260,7 @@ static void usb_acecad_disconnect(struct usb_interface *intf)
 	kfree(acecad);
 }
 
-static struct usb_device_id usb_acecad_id_table [] = {
+static const struct usb_device_id usb_acecad_id_table[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_FLAIR), .driver_info = 0 },
 	{ USB_DEVICE(USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_302),	 .driver_info = 1 },
 	{ }
-- 
2.7.4
