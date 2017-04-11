From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 2/2] xen,input: repair xen-kbdfront resolution setting via xenstore
Date: Tue, 11 Apr 2017 10:50:28 +0200
Message-ID: <20170411085028.6750-3-jgross@suse.com>
References: <20170411085028.6750-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411085028.6750-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com, andr2000@gmail.com, Juergen Gross <jgross@suse.com>
List-Id: linux-input@vger.kernel.org

Setting the pointing device resolution via Xenstore isn't working
reliably: in case XenbusStateInitWait has been missed the resolution
settings won't be read. Correct this.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 90e7981a7768..fc28f59dfa93 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -312,11 +312,27 @@ static void xenkbd_disconnect_backend(struct xenkbd_info *info)
 	info->gref = -1;
 }
 
+static void xenkbd_set_connected(struct xenbus_device *dev)
+{
+	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
+	int ret;
+
+	if (xenbus_read_unsigned(info->xbdev->otherend,
+				 "feature-abs-pointer", 0)) {
+		ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
+				   "request-abs-pointer", "1");
+		if (ret)
+			pr_warn("xenkbd: can't request abs-pointer");
+	}
+
+	xenbus_switch_state(dev, XenbusStateConnected);
+}
+
 static void xenkbd_backend_changed(struct xenbus_device *dev,
 				   enum xenbus_state backend_state)
 {
 	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
-	int ret, val;
+	int val;
 
 	switch (backend_state) {
 	case XenbusStateInitialising:
@@ -327,16 +343,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
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
-		xenbus_switch_state(dev, XenbusStateConnected);
+		xenkbd_set_connected(dev);
 		break;
 
 	case XenbusStateConnected:
@@ -346,7 +353,8 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
 		 * get Connected twice here.
 		 */
 		if (dev->state != XenbusStateConnected)
-			goto InitWait; /* no InitWait seen yet, fudge it */
+			/* No InitWait seen yet, fudge it. */
+			xenkbd_set_connected(dev);
 
 		/* Set input abs params to match backend screen res */
 		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-- 
2.12.0
