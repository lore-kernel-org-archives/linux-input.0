From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH 1/2] xen/input: use string constants from PV protocol
Date: Thu, 13 Apr 2017 14:38:03 +0300
Message-ID: <1492083484-31786-2-git-send-email-andr2000@gmail.com>
References: <1492083484-31786-1-git-send-email-andr2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492083484-31786-1-git-send-email-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: joculator@gmail.com, al1img@gmail.com, vlad.babchuk@gmail.com, andrii.anisov@gmail.com, olekstysh@gmail.com, boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com, jgross@suse.com, andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Xen input para-virtual protocol defines string constants
used by both back and frontend. Use those instead of
explicit strings in the frontend driver.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 2fc7895373ab..01c27b4c3288 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -135,14 +135,17 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		goto error_nomem;
 
 	/* Set input abs params to match backend screen res */
-	abs = xenbus_read_unsigned(dev->otherend, "feature-abs-pointer", 0);
-	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend, "width",
+	abs = xenbus_read_unsigned(dev->otherend,
+				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
+	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
+						  XENKBD_FIELD_WIDTH,
 						  ptr_size[KPARAM_X]);
-	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend, "height",
+	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
+						  XENKBD_FIELD_HEIGHT,
 						  ptr_size[KPARAM_Y]);
 	if (abs) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
-				   "request-abs-pointer", "1");
+				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
 		if (ret) {
 			pr_warning("xenkbd: can't request abs-pointer");
 			abs = 0;
@@ -271,14 +274,15 @@ static int xenkbd_connect_backend(struct xenbus_device *dev,
 		xenbus_dev_fatal(dev, ret, "starting transaction");
 		goto error_irqh;
 	}
-	ret = xenbus_printf(xbt, dev->nodename, "page-ref", "%lu",
+	ret = xenbus_printf(xbt, dev->nodename, XENKBD_FIELD_RING_REF, "%lu",
 			    virt_to_gfn(info->page));
 	if (ret)
 		goto error_xenbus;
-	ret = xenbus_printf(xbt, dev->nodename, "page-gref", "%u", info->gref);
+	ret = xenbus_printf(xbt, dev->nodename, XENKBD_FIELD_RING_GREF,
+			    "%u", info->gref);
 	if (ret)
 		goto error_xenbus;
-	ret = xenbus_printf(xbt, dev->nodename, "event-channel", "%u",
+	ret = xenbus_printf(xbt, dev->nodename, XENKBD_FIELD_EVT_CHANNEL, "%u",
 			    evtchn);
 	if (ret)
 		goto error_xenbus;
@@ -353,7 +357,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
 }
 
 static const struct xenbus_device_id xenkbd_ids[] = {
-	{ "vkbd" },
+	{ XENKBD_DRIVER_NAME },
 	{ "" }
 };
 
@@ -390,4 +394,4 @@ module_exit(xenkbd_cleanup);
 
 MODULE_DESCRIPTION("Xen virtual keyboard/pointer device frontend");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("xen:vkbd");
+MODULE_ALIAS("xen:" XENKBD_DRIVER_NAME);
-- 
2.7.4
