From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/8] Input: powermate: constify usb_device_id and fix space before '[' error.
Date: Sun,  6 Aug 2017 13:11:23 +0530
Message-ID: <1502005287-17705-5-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/misc/powermate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 84909a1..056091b 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -432,7 +432,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 	}
 }
 
-static struct usb_device_id powermate_devices [] = {
+static const struct usb_device_id powermate_devices[] = {
 	{ USB_DEVICE(POWERMATE_VENDOR, POWERMATE_PRODUCT_NEW) },
 	{ USB_DEVICE(POWERMATE_VENDOR, POWERMATE_PRODUCT_OLD) },
 	{ USB_DEVICE(CONTOUR_VENDOR, CONTOUR_JOG) },
-- 
2.7.4
