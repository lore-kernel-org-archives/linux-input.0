From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/8] Input: iforce: constify usb_device_id and fix space before '[' error:
Date: Sun,  6 Aug 2017 13:11:20 +0530
Message-ID: <1502005287-17705-2-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/joystick/iforce/iforce-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index db64adf..db5cc35 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -209,7 +209,7 @@ static void iforce_usb_disconnect(struct usb_interface *intf)
 	kfree(iforce);
 }
 
-static struct usb_device_id iforce_usb_ids [] = {
+static const struct usb_device_id iforce_usb_ids[] = {
 	{ USB_DEVICE(0x044f, 0xa01c) },		/* Thrustmaster Motor Sport GT */
 	{ USB_DEVICE(0x046d, 0xc281) },		/* Logitech WingMan Force */
 	{ USB_DEVICE(0x046d, 0xc291) },		/* Logitech WingMan Formula Force */
-- 
2.7.4
