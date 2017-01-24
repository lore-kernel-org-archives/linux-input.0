From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen,input: try to read screen resolution for xen-kbdfront
Date: Tue, 24 Jan 2017 13:09:55 +0100
Message-ID: <20170124120955.24898-1-jgross@suse.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: dmitry.torokhov@gmail.com, Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of using the default resolution of 800*600 for the pointing
device of xen-kbdfront try to read the resolution of the (virtual)
framebuffer device. Use the default as fallback only.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/input/misc/xen-kbdfront.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 3900875..0032c81 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/fb.h>
 #include <linux/input.h>
 #include <linux/slab.h>
 
@@ -108,10 +109,11 @@ static irqreturn_t input_handler(int rq, void *dev_id)
 static int xenkbd_probe(struct xenbus_device *dev,
 				  const struct xenbus_device_id *id)
 {
-	int ret, i;
+	int ret, i, width, height;
 	unsigned int abs;
 	struct xenkbd_info *info;
 	struct input_dev *kbd, *ptr;
+	struct fb_info *fb0;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
@@ -173,9 +175,16 @@ static int xenkbd_probe(struct xenbus_device *dev,
 	ptr->id.product = 0xfffe;
 
 	if (abs) {
+		width = XENFB_WIDTH;
+		height = XENFB_HEIGHT;
+		fb0 = registered_fb[0];
+		if (fb0) {
+			width = fb0->var.xres_virtual;
+			height = fb0->var.yres_virtual;
+		}
 		__set_bit(EV_ABS, ptr->evbit);
-		input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
-		input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
+		input_set_abs_params(ptr, ABS_X, 0, width, 0, 0);
+		input_set_abs_params(ptr, ABS_Y, 0, height, 0, 0);
 	} else {
 		input_set_capability(ptr, EV_REL, REL_X);
 		input_set_capability(ptr, EV_REL, REL_Y);
-- 
2.10.2
