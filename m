From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/5] xen pvfb: Pointer z-axis (mouse wheel)
	support
Date: Wed, 21 May 2008 10:39:51 +0200
Message-ID: <877idom4o8.fsf@pike.pond.sub.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, Pat Campbell <plc@novell.com>, linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Add z-axis motion to pointer events.  Backward compatible, because
there's space for the z-axis in union xenkbd_in_event, and old
backends zero it.

Derived from
http://xenbits.xensource.com/linux-2.6.18-xen.hg?rev/57dfe0098000
http://xenbits.xensource.com/linux-2.6.18-xen.hg?rev/1edfea26a2a9
http://xenbits.xensource.com/linux-2.6.18-xen.hg?rev/c3ff0b26f664

Signed-off-by: Pat Campbell <plc@novell.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 drivers/input/xen-kbdfront.c     |    8 +++++++-
 include/xen/interface/io/kbdif.h |    2 ++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/input/xen-kbdfront.c b/drivers/input/xen-kbdfront.c
index 0f47f46..9da4452 100644
--- a/drivers/input/xen-kbdfront.c
+++ b/drivers/input/xen-kbdfront.c
@@ -66,6 +66,9 @@ static irqreturn_t input_handler(int rq, void *dev_id)
 		case XENKBD_TYPE_MOTION:
 			input_report_rel(dev, REL_X, event->motion.rel_x);
 			input_report_rel(dev, REL_Y, event->motion.rel_y);
+			if (event->motion.rel_z)
+				input_report_rel(dev, REL_WHEEL,
+						 -event->motion.rel_z);
 			break;
 		case XENKBD_TYPE_KEY:
 			dev = NULL;
@@ -84,6 +87,9 @@ static irqreturn_t input_handler(int rq, void *dev_id)
 		case XENKBD_TYPE_POS:
 			input_report_abs(dev, ABS_X, event->pos.abs_x);
 			input_report_abs(dev, ABS_Y, event->pos.abs_y);
+			if (event->pos.rel_z)
+				input_report_rel(dev, REL_WHEEL,
+						 -event->pos.rel_z);
 			break;
 		}
 		if (dev)
@@ -152,7 +158,7 @@ static int __devinit xenkbd_probe(struct xenbus_device *dev,
 	ptr->evbit[0] = BIT(EV_KEY) | BIT(EV_REL) | BIT(EV_ABS);
 	for (i = BTN_LEFT; i <= BTN_TASK; i++)
 		set_bit(i, ptr->keybit);
-	ptr->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	ptr->relbit[0] = BIT(REL_X) | BIT(REL_Y) | BIT(REL_WHEEL);
 	input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
 	input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
 
diff --git a/include/xen/interface/io/kbdif.h b/include/xen/interface/io/kbdif.h
index fb97f42..8066c78 100644
--- a/include/xen/interface/io/kbdif.h
+++ b/include/xen/interface/io/kbdif.h
@@ -49,6 +49,7 @@ struct xenkbd_motion {
 	uint8_t type;		/* XENKBD_TYPE_MOTION */
 	int32_t rel_x;		/* relative X motion */
 	int32_t rel_y;		/* relative Y motion */
+	int32_t rel_z;		/* relative Z motion (wheel) */
 };
 
 struct xenkbd_key {
@@ -61,6 +62,7 @@ struct xenkbd_position {
 	uint8_t type;		/* XENKBD_TYPE_POS */
 	int32_t abs_x;		/* absolute X position (in FB pixels) */
 	int32_t abs_y;		/* absolute Y position (in FB pixels) */
+	int32_t rel_z;		/* relative Z motion (wheel) */
 };
 
 #define XENKBD_IN_EVENT_SIZE 40
-- 
1.5.3.3
