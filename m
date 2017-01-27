From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2] xen,input: try to read screen resolution for xen-kbdfront
Date: Fri, 27 Jan 2017 08:12:39 +0100
Message-ID: <20170127071239.913-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: dmitry.torokhov@gmail.com, Juergen Gross <jgross@suse.com>
List-Id: linux-input@vger.kernel.org

Instead of using the default resolution of 800*600 for the pointing
device of xen-kbdfront try to read the resolution of the (virtual)
framebuffer device. Use the default as fallback only.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: get framebuffer resolution only if CONFIG_FB (Dmitry Torokhov)
---
 drivers/input/misc/xen-kbdfront.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 3900875..3aae9b4 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/fb.h>
 #include <linux/input.h>
 #include <linux/slab.h>
 
@@ -108,7 +109,7 @@ static irqreturn_t input_handler(int rq, void *dev_id)
 static int xenkbd_probe(struct xenbus_device *dev,
 				  const struct xenbus_device_id *id)
 {
-	int ret, i;
+	int ret, i, width, height;
 	unsigned int abs;
 	struct xenkbd_info *info;
 	struct input_dev *kbd, *ptr;
@@ -173,9 +174,17 @@ static int xenkbd_probe(struct xenbus_device *dev,
 	ptr->id.product = 0xfffe;
 
 	if (abs) {
+		width = XENFB_WIDTH;
+		height = XENFB_HEIGHT;
+#ifdef CONFIG_FB
+		if (registered_fb[0]) {
+			width = registered_fb[0]->var.xres_virtual;
+			height = registered_fb[0]->var.yres_virtual;
+		}
+#endif
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
