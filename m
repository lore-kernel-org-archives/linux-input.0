From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3] xen,input: add xen-kbdfront module parameter for setting resolution
Date: Tue, 11 Apr 2017 14:30:37 +0200
Message-ID: <20170411123037.31733-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com, andr2000@gmail.com, Juergen Gross <jgross@suse.com>
List-Id: linux-input@vger.kernel.org

Add a parameter for setting the resolution of xen-kbdfront in order to
be able to cope with a (virtual) frame buffer of arbitrary resolution.

While at it remove the pointless second reading of parameters from
Xenstore in the device connection phase: all parameters are available
during device probing already and that is where they should be read.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3: - merged the two patches
    - read Xenstore parameters during probing of the device only
---
 drivers/input/misc/xen-kbdfront.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 3900875dec10..2fc7895373ab 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -41,6 +41,12 @@ struct xenkbd_info {
 	char phys[32];
 };
 
+enum { KPARAM_X, KPARAM_Y, KPARAM_CNT };
+static int ptr_size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
+module_param_array(ptr_size, int, NULL, 0444);
+MODULE_PARM_DESC(ptr_size,
+	"Pointing device width, height in pixels (default 800,600)");
+
 static int xenkbd_remove(struct xenbus_device *);
 static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
 static void xenkbd_disconnect_backend(struct xenkbd_info *);
@@ -128,7 +134,12 @@ static int xenkbd_probe(struct xenbus_device *dev,
 	if (!info->page)
 		goto error_nomem;
 
+	/* Set input abs params to match backend screen res */
 	abs = xenbus_read_unsigned(dev->otherend, "feature-abs-pointer", 0);
+	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend, "width",
+						  ptr_size[KPARAM_X]);
+	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend, "height",
+						  ptr_size[KPARAM_Y]);
 	if (abs) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
 				   "request-abs-pointer", "1");
@@ -174,8 +185,8 @@ static int xenkbd_probe(struct xenbus_device *dev,
 
 	if (abs) {
 		__set_bit(EV_ABS, ptr->evbit);
-		input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
-		input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
+		input_set_abs_params(ptr, ABS_X, 0, ptr_size[KPARAM_X], 0, 0);
+		input_set_abs_params(ptr, ABS_Y, 0, ptr_size[KPARAM_Y], 0, 0);
 	} else {
 		input_set_capability(ptr, EV_REL, REL_X);
 		input_set_capability(ptr, EV_REL, REL_Y);
@@ -309,9 +320,6 @@ static void xenkbd_disconnect_backend(struct xenkbd_info *info)
 static void xenkbd_backend_changed(struct xenbus_device *dev,
 				   enum xenbus_state backend_state)
 {
-	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
-	int ret, val;
-
 	switch (backend_state) {
 	case XenbusStateInitialising:
 	case XenbusStateInitialised:
@@ -321,15 +329,6 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateInitWait:
-InitWait:
-		if (xenbus_read_unsigned(info->xbdev->otherend,
-					 "feature-abs-pointer", 0)) {
-			ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
-					   "request-abs-pointer", "1");
-			if (ret)
-				pr_warning("xenkbd: can't request abs-pointer");
-		}
-
 		xenbus_switch_state(dev, XenbusStateConnected);
 		break;
 
@@ -340,17 +339,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
 		 * get Connected twice here.
 		 */
 		if (dev->state != XenbusStateConnected)
-			goto InitWait; /* no InitWait seen yet, fudge it */
-
-		/* Set input abs params to match backend screen res */
-		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-				 "width", "%d", &val) > 0)
-			input_set_abs_params(info->ptr, ABS_X, 0, val, 0, 0);
-
-		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-				 "height", "%d", &val) > 0)
-			input_set_abs_params(info->ptr, ABS_Y, 0, val, 0, 0);
-
+			xenbus_switch_state(dev, XenbusStateConnected);
 		break;
 
 	case XenbusStateClosed:
-- 
2.12.0
