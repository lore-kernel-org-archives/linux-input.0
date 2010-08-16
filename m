From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 1/2] serio: support multiple child devices per single parent
Date: Mon, 16 Aug 2010 15:26:36 +0400
Message-ID: <1281957997-12959-2-git-send-email-dbaryshkov@gmail.com>
References: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48050 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab0HPL0x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 07:26:53 -0400
Received: by wwj40 with SMTP id 40so6383487wwj.1
        for <linux-input@vger.kernel.org>; Mon, 16 Aug 2010 04:26:51 -0700 (PDT)
In-Reply-To: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some (rare) serio devices need to have multiple serio children. One of
the examples is PS/2 multiplexer present on several TQC STKxxx boards,
which connect PS/2 keyboard and mouse to single tty port.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c |    2 +-
 drivers/input/mouse/synaptics.c    |   11 +++-
 drivers/input/serio/serio.c        |  114 +++++++++++++++++++-----------------
 include/linux/serio.h              |    5 +-
 4 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 979c502..0eeed6c 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1582,7 +1582,7 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 	if (!new_dev)
 		return -ENOMEM;
 
-	while (serio->child) {
+	while (!list_empty(&serio->children)) {
 		if (++retry > 3) {
 			printk(KERN_WARNING
 				"psmouse: failed to destroy child port, "
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 705589d..9295ad0 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -315,7 +315,9 @@ static void synaptics_pass_pt_packet(struct serio *ptport, unsigned char *packet
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct serio *ptport = psmouse->ps2dev.serio->child;
+	struct serio *ptport =
+		list_first_entry(&psmouse->ps2dev.serio->children,
+				struct serio, child_list);
 	struct psmouse *child = serio_get_drvdata(ptport);
 	struct synaptics_data *priv = psmouse->private;
 
@@ -577,8 +579,11 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
 		if (SYN_CAP_PASS_THROUGH(priv->capabilities) && synaptics_is_pt_packet(psmouse->packet)) {
-			if (psmouse->ps2dev.serio->child)
-				synaptics_pass_pt_packet(psmouse->ps2dev.serio->child, psmouse->packet);
+			if (!list_empty(&psmouse->ps2dev.serio->children))
+				synaptics_pass_pt_packet(
+						list_first_entry(&psmouse->ps2dev.serio->children,
+							struct serio, child_list),
+						psmouse->packet);
 		} else
 			synaptics_process_packet(psmouse);
 
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index c3b626e..55c46e8 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -312,12 +312,9 @@ static void serio_handle_event(void)
  * Remove all events that have been submitted for a given
  * object, be it serio port or driver.
  */
-static void serio_remove_pending_events(void *object)
+static void __serio_remove_pending_events(void *object)
 {
 	struct serio_event *event, *next;
-	unsigned long flags;
-
-	spin_lock_irqsave(&serio_event_lock, flags);
 
 	list_for_each_entry_safe(event, next, &serio_event_list, node) {
 		if (event->object == object) {
@@ -325,38 +322,41 @@ static void serio_remove_pending_events(void *object)
 			serio_free_event(event);
 		}
 	}
+}
+
+static void serio_remove_pending_events(void *object)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_event_lock, flags);
+
+	__serio_remove_pending_events(object);
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
 /*
  * Destroy child serio port (if any) that has not been fully registered yet.
- *
- * Note that we rely on the fact that port can have only one child and therefore
- * only one child registration request can be pending. Additionally, children
- * are registered by driver's connect() handler so there can't be a grandchild
- * pending registration together with a child.
  */
-static struct serio *serio_get_pending_child(struct serio *parent)
+static void serio_drop_pending_children(struct serio *parent)
 {
-	struct serio_event *event;
-	struct serio *serio, *child = NULL;
+	struct serio_event *event, *temp;
+	struct serio *serio;
 	unsigned long flags;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
-	list_for_each_entry(event, &serio_event_list, node) {
+	list_for_each_entry_safe(event, temp, &serio_event_list, node) {
 		if (event->type == SERIO_REGISTER_PORT) {
 			serio = event->object;
 			if (serio->parent == parent) {
-				child = serio;
-				break;
+				__serio_remove_pending_events(serio);
+				put_device(&serio->dev);
 			}
 		}
 	}
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
-	return child;
 }
 
 static int serio_thread(void *nothing)
@@ -516,6 +516,9 @@ static void serio_init_port(struct serio *serio)
 	__module_get(THIS_MODULE);
 
 	INIT_LIST_HEAD(&serio->node);
+	INIT_LIST_HEAD(&serio->children);
+	INIT_LIST_HEAD(&serio->child_list);
+	INIT_LIST_HEAD(&serio->internal);
 	spin_lock_init(&serio->lock);
 	mutex_init(&serio->drv_mutex);
 	device_initialize(&serio->dev);
@@ -542,7 +545,7 @@ static void serio_add_port(struct serio *serio)
 
 	if (serio->parent) {
 		serio_pause_rx(serio->parent);
-		serio->parent->child = serio;
+		list_add_tail(&serio->child_list, &serio->parent->children);
 		serio_continue_rx(serio->parent);
 	}
 
@@ -564,20 +567,14 @@ static void serio_add_port(struct serio *serio)
  */
 static void serio_destroy_port(struct serio *serio)
 {
-	struct serio *child;
-
-	child = serio_get_pending_child(serio);
-	if (child) {
-		serio_remove_pending_events(child);
-		put_device(&child->dev);
-	}
+	serio_drop_pending_children(serio);
 
 	if (serio->stop)
 		serio->stop(serio);
 
 	if (serio->parent) {
 		serio_pause_rx(serio->parent);
-		serio->parent->child = NULL;
+		list_del(&serio->child_list);
 		serio_continue_rx(serio->parent);
 		serio->parent = NULL;
 	}
@@ -613,13 +610,19 @@ static int serio_reconnect_port(struct serio *serio)
  */
 static void serio_reconnect_chain(struct serio *serio)
 {
-	do {
-		if (serio_reconnect_port(serio)) {
-			/* Ok, old children are now gone, we are done */
-			break;
-		}
-		serio = serio->child;
-	} while (serio);
+	struct serio *child;
+	LIST_HEAD(todo);
+
+	list_add_tail(&serio->internal, &todo);
+
+	while (!list_empty(&todo)) {
+		serio = list_first_entry(&todo, struct serio, internal);
+		list_del_init(&serio->internal);
+
+		if (!serio_reconnect_port(serio))
+			list_for_each_entry(child, &serio->children, child_list)
+				list_add_tail(&child->internal, &todo);
+	}
 }
 
 /*
@@ -628,29 +631,31 @@ static void serio_reconnect_chain(struct serio *serio)
  */
 static void serio_disconnect_port(struct serio *serio)
 {
-	struct serio *s, *parent;
+	struct serio *s, *child;
+	LIST_HEAD(todo);
 
-	if (serio->child) {
-		/*
-		 * Children ports should be disconnected and destroyed
-		 * first, staring with the leaf one, since we don't want
-		 * to do recursion
-		 */
-		for (s = serio; s->child; s = s->child)
-			/* empty */;
+	list_add_tail(&serio->internal, &todo);
 
-		do {
-			parent = s->parent;
+	while (!list_empty(&todo)) {
+		s = list_first_entry(&todo, struct serio, internal);
+
+		if (!list_empty(&s->children)) {
+			list_for_each_entry(child, &s->children, child_list)
+				list_add(&child->internal, &todo);
+
+			/*
+			 * We will return to this item later, when it will have
+			 * no children.
+			 */
+		} else {
+			list_del_init(&s->internal);
 
 			device_release_driver(&s->dev);
-			serio_destroy_port(s);
-		} while ((s = parent) != serio);
-	}
 
-	/*
-	 * Ok, no children left, now disconnect this port
-	 */
-	device_release_driver(&serio->dev);
+			if (s != serio)
+				serio_destroy_port(s);
+		}
+	}
 }
 
 void serio_rescan(struct serio *serio)
@@ -689,14 +694,15 @@ void serio_unregister_port(struct serio *serio)
 EXPORT_SYMBOL(serio_unregister_port);
 
 /*
- * Safely unregisters child port if one is present.
+ * Safely unregisters child ports if any is present.
  */
 void serio_unregister_child_port(struct serio *serio)
 {
+	struct serio *s, *temp;
 	mutex_lock(&serio_mutex);
-	if (serio->child) {
-		serio_disconnect_port(serio->child);
-		serio_destroy_port(serio->child);
+	list_for_each_entry_safe(s, temp, &serio->children, child_list) {
+		serio_disconnect_port(s);
+		serio_destroy_port(s);
 	}
 	mutex_unlock(&serio_mutex);
 }
diff --git a/include/linux/serio.h b/include/linux/serio.h
index b555256..861a72a 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -41,7 +41,9 @@ struct serio {
 	int (*start)(struct serio *);
 	void (*stop)(struct serio *);
 
-	struct serio *parent, *child;
+	struct serio *parent;
+	struct list_head child_list;
+	struct list_head children;
 	unsigned int depth;		/* level of nesting in serio hierarchy */
 
 	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */
@@ -50,6 +52,7 @@ struct serio {
 	struct device dev;
 
 	struct list_head node;
+	struct list_head internal;	/* Used internally to avoid recursion */
 };
 #define to_serio_port(d)	container_of(d, struct serio, dev)
 
-- 
1.7.1

