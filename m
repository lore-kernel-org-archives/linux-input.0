From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/8] Input: synaptics_usb: constify usb_device_id.
Date: Sun,  6 Aug 2017 13:11:25 +0530
Message-ID: <1502005287-17705-7-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/mouse/synaptics_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 6bcc018..cb7d15d 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -525,7 +525,7 @@ static int synusb_reset_resume(struct usb_interface *intf)
 	return synusb_resume(intf);
 }
 
-static struct usb_device_id synusb_idtable[] = {
+static const struct usb_device_id synusb_idtable[] = {
 	{ USB_DEVICE_SYNAPTICS(TP, SYNUSB_TOUCHPAD) },
 	{ USB_DEVICE_SYNAPTICS(INT_TP, SYNUSB_TOUCHPAD) },
 	{ USB_DEVICE_SYNAPTICS(CPAD,
-- 
2.7.4
