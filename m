From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH v5 2/3] Input: xen-kbdfront - fix multi-touch XenStore node's locations
Date: Tue, 12 Jun 2018 10:48:55 +0300
Message-ID: <20180612074856.28451-3-andr2000@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612074856.28451-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andr2000@gmail.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

kbdif protocol describes multi-touch device parameters as a
part of frontend's XenBus configuration nodes while they
belong to backend's configuration. Fix this by reading the
parameters as defined by the protocol.

Fixes: 49aac8204da5 ("Input: xen-kbdfront - add multi-touch support")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index d91f3b1c5375..92d739649022 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -229,7 +229,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		}
 	}
 
-	touch = xenbus_read_unsigned(dev->nodename,
+	touch = xenbus_read_unsigned(dev->otherend,
 				     XENKBD_FIELD_FEAT_MTOUCH, 0);
 	if (touch) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
@@ -304,13 +304,13 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		if (!mtouch)
 			goto error_nomem;
 
-		num_cont = xenbus_read_unsigned(info->xbdev->nodename,
+		num_cont = xenbus_read_unsigned(info->xbdev->otherend,
 						XENKBD_FIELD_MT_NUM_CONTACTS,
 						1);
-		width = xenbus_read_unsigned(info->xbdev->nodename,
+		width = xenbus_read_unsigned(info->xbdev->otherend,
 					     XENKBD_FIELD_MT_WIDTH,
 					     XENFB_WIDTH);
-		height = xenbus_read_unsigned(info->xbdev->nodename,
+		height = xenbus_read_unsigned(info->xbdev->otherend,
 					      XENKBD_FIELD_MT_HEIGHT,
 					      XENFB_HEIGHT);
 
-- 
2.17.1
