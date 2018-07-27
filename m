From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: mouse: appletouch: Replace GFP_ATOMIC with GFP_KERNEL
Date: Fri, 27 Jul 2018 10:26:18 +0800
Message-ID: <20180727022618.1007-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, gustavo@embeddedor.com, arvind.yadav.cs@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-input@vger.kernel.org

atp_open(), atp_recover() and atp_resume() are never 
called in atomic context.
They call usb_submit_urb() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/mouse/appletouch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 032d27983b6c..f593ec96c95f 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -810,7 +810,7 @@ static int atp_open(struct input_dev *input)
 {
 	struct atp *dev = input_get_drvdata(input);
 
-	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	dev->open = true;
@@ -976,7 +976,7 @@ static int atp_recover(struct atp *dev)
 	if (error)
 		return error;
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
@@ -994,7 +994,7 @@ static int atp_resume(struct usb_interface *iface)
 {
 	struct atp *dev = usb_get_intfdata(iface);
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
-- 
2.17.0
