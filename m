From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 1/2] xen,input: add xen-kbdfront module parameter for setting resolution
Date: Tue, 11 Apr 2017 10:50:27 +0200
Message-ID: <20170411085028.6750-2-jgross@suse.com>
References: <20170411085028.6750-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411085028.6750-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com, andr2000@gmail.com, Juergen Gross <jgross@suse.com>
List-Id: linux-input@vger.kernel.org

Add a parameter for setting the resolution of xen-kbdfront in order to
be able to cope with a (virtual) frame buffer of arbitrary resolution.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/input/misc/xen-kbdfront.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 3900875dec10..90e7981a7768 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -41,6 +41,12 @@ struct xenkbd_info {
 	char phys[32];
 };
 
+enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
+static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
+module_param_array(size, int, NULL, 0444);
+MODULE_PARM_DESC(size,
+	"Pointing device width, height in pixels (default 800,600)");
+
 static int xenkbd_remove(struct xenbus_device *);
 static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
 static void xenkbd_disconnect_backend(struct xenkbd_info *);
@@ -174,8 +180,8 @@ static int xenkbd_probe(struct xenbus_device *dev,
 
 	if (abs) {
 		__set_bit(EV_ABS, ptr->evbit);
-		input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
-		input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
+		input_set_abs_params(ptr, ABS_X, 0, size[KPARAM_WIDTH], 0, 0);
+		input_set_abs_params(ptr, ABS_Y, 0, size[KPARAM_HEIGHT], 0, 0);
 	} else {
 		input_set_capability(ptr, EV_REL, REL_X);
 		input_set_capability(ptr, EV_REL, REL_Y);
@@ -344,12 +350,16 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
 
 		/* Set input abs params to match backend screen res */
 		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-				 "width", "%d", &val) > 0)
+				 "width", "%d", &val) > 0) {
 			input_set_abs_params(info->ptr, ABS_X, 0, val, 0, 0);
+			size[KPARAM_WIDTH] = val;
+		}
 
 		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-				 "height", "%d", &val) > 0)
+				 "height", "%d", &val) > 0) {
 			input_set_abs_params(info->ptr, ABS_Y, 0, val, 0, 0);
+			size[KPARAM_HEIGHT] = val;
+		}
 
 		break;
 
-- 
2.12.0
