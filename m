From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/8] Input: keyspan_remote: constify usb_device_id.
Date: Sun,  6 Aug 2017 13:11:22 +0530
Message-ID: <1502005287-17705-4-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/misc/keyspan_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index a3fe4a9..77c47d6 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -85,7 +85,7 @@ static const unsigned short keyspan_key_table[] = {
 };
 
 /* table of devices that work with this driver */
-static struct usb_device_id keyspan_table[] = {
+static const struct usb_device_id keyspan_table[] = {
 	{ USB_DEVICE(USB_KEYSPAN_VENDOR_ID, USB_KEYSPAN_PRODUCT_UIA11) },
 	{ }					/* Terminating entry */
 };
-- 
2.7.4
