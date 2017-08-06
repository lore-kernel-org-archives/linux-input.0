From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 8/8] Input: kbtab: constify usb_device_id.
Date: Sun,  6 Aug 2017 13:11:27 +0530
Message-ID: <1502005287-17705-9-git-send-email-arvind.yadav.cs@gmail.com>
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

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/tablet/kbtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index 4d9d649..a41c3ff 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -88,7 +88,7 @@ static void kbtab_irq(struct urb *urb)
 			__func__, retval);
 }
 
-static struct usb_device_id kbtab_ids[] = {
+static const struct usb_device_id kbtab_ids[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_KBGEAR, 0x1001), .driver_info = 0 },
 	{ }
 };
-- 
2.7.4
