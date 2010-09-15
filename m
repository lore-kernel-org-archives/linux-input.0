From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] serio: support multiple child devices per single
 parent
Date: Tue, 14 Sep 2010 22:03:16 -0700
Message-ID: <20100915050316.GB21672@core.coreip.homeip.net>
References: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
 <1281957997-12959-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58416 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0IOFDY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 01:03:24 -0400
Received: by pwi3 with SMTP id 3so39935pwi.19
        for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 22:03:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281957997-12959-2-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

On Mon, Aug 16, 2010 at 03:26:36PM +0400, Dmitry Eremin-Solenikov wrote:
> @@ -50,6 +52,7 @@ struct serio {
>  	struct device dev;
>  
>  	struct list_head node;
> +	struct list_head internal;	/* Used internally to avoid recursion */

I think we can do without this one, how about the patch below? (Depends
on synaptics changes in attached patch).

Thanks.

-- 
Dmitry

Input: serio - support multiple child devices per single parent

From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Some (rare) serio devices need to have multiple serio children. One of
the examples is PS/2 multiplexer present on several TQC STKxxx boards,
which connect PS/2 keyboard and mouse to single tty port.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |    4 +
 drivers/input/serio/serio.c        |  124 ++++++++++++++++++++++++------------
 include/linux/serio.h              |    4 +
 3 files changed, 86 insertions(+), 46 deletions(-)


diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 2f7408a..35356ba 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1584,10 +1584,10 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 	if (!new_dev)
 		return -ENOMEM;
 
-	while (serio->child) {
+	while (!list_empty(&serio->children)) {
 		if (++retry > 3) {
 			printk(KERN_WARNING
-				"psmouse: failed to destroy child port, "
+				"psmouse: failed to destroy children ports, "
 				"protocol change aborted.\n");
 			input_free_device(new_dev);
 			return -EIO;
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index b2730b4..be0e93a 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -54,7 +54,7 @@ static struct bus_type serio_bus;
 static void serio_add_port(struct serio *serio);
 static int serio_reconnect_port(struct serio *serio);
 static void serio_disconnect_port(struct serio *serio);
-static void serio_reconnect_chain(struct serio *serio);
+static void serio_reconnect_subtree(struct serio *serio);
 static void serio_attach_driver(struct serio_driver *drv);
 
 static int serio_connect_driver(struct serio *serio, struct serio_driver *drv)
@@ -150,7 +150,7 @@ static void serio_find_driver(struct serio *serio)
 enum serio_event_type {
 	SERIO_RESCAN_PORT,
 	SERIO_RECONNECT_PORT,
-	SERIO_RECONNECT_CHAIN,
+	SERIO_RECONNECT_SUBTREE,
 	SERIO_REGISTER_PORT,
 	SERIO_ATTACH_DRIVER,
 };
@@ -237,8 +237,8 @@ static void serio_handle_event(struct work_struct *work)
 			serio_find_driver(event->object);
 			break;
 
-		case SERIO_RECONNECT_CHAIN:
-			serio_reconnect_chain(event->object);
+		case SERIO_RECONNECT_SUBTREE:
+			serio_reconnect_subtree(event->object);
 			break;
 
 		case SERIO_ATTACH_DRIVER:
@@ -328,12 +328,10 @@ static void serio_remove_pending_events(void *object)
 }
 
 /*
- * Destroy child serio port (if any) that has not been fully registered yet.
+ * Locate child serio port (if any) that has not been fully registered yet.
  *
- * Note that we rely on the fact that port can have only one child and therefore
- * only one child registration request can be pending. Additionally, children
- * are registered by driver's connect() handler so there can't be a grandchild
- * pending registration together with a child.
+ * Children are registered by driver's connect() handler so there can't be a
+ * grandchild pending registration together with a child.
  */
 static struct serio *serio_get_pending_child(struct serio *parent)
 {
@@ -435,7 +433,7 @@ static ssize_t serio_rebind_driver(struct device *dev, struct device_attribute *
 	if (!strncmp(buf, "none", count)) {
 		serio_disconnect_port(serio);
 	} else if (!strncmp(buf, "reconnect", count)) {
-		serio_reconnect_chain(serio);
+		serio_reconnect_subtree(serio);
 	} else if (!strncmp(buf, "rescan", count)) {
 		serio_disconnect_port(serio);
 		serio_find_driver(serio);
@@ -502,6 +500,8 @@ static void serio_init_port(struct serio *serio)
 	__module_get(THIS_MODULE);
 
 	INIT_LIST_HEAD(&serio->node);
+	INIT_LIST_HEAD(&serio->child_node);
+	INIT_LIST_HEAD(&serio->children);
 	spin_lock_init(&serio->lock);
 	mutex_init(&serio->drv_mutex);
 	device_initialize(&serio->dev);
@@ -524,12 +524,13 @@ static void serio_init_port(struct serio *serio)
  */
 static void serio_add_port(struct serio *serio)
 {
+	struct serio *parent = serio->parent;
 	int error;
 
-	if (serio->parent) {
-		serio_pause_rx(serio->parent);
-		serio->parent->child = serio;
-		serio_continue_rx(serio->parent);
+	if (parent) {
+		serio_pause_rx(parent);
+		list_add_tail(&serio->child_node, &parent->children);
+		serio_continue_rx(parent);
 	}
 
 	list_add_tail(&serio->node, &serio_list);
@@ -545,15 +546,14 @@ static void serio_add_port(struct serio *serio)
 }
 
 /*
- * serio_destroy_port() completes deregistration process and removes
+ * serio_destroy_port() completes unregistration process and removes
  * port from the system
  */
 static void serio_destroy_port(struct serio *serio)
 {
 	struct serio *child;
 
-	child = serio_get_pending_child(serio);
-	if (child) {
+	while ((child = serio_get_pending_child(serio)) != NULL) {
 		serio_remove_pending_events(child);
 		put_device(&child->dev);
 	}
@@ -563,7 +563,7 @@ static void serio_destroy_port(struct serio *serio)
 
 	if (serio->parent) {
 		serio_pause_rx(serio->parent);
-		serio->parent->child = NULL;
+		list_del_init(&serio->child_node);
 		serio_continue_rx(serio->parent);
 		serio->parent = NULL;
 	}
@@ -595,46 +595,82 @@ static int serio_reconnect_port(struct serio *serio)
 }
 
 /*
- * Reconnect serio port and all its children (re-initialize attached devices)
+ * Reconnect serio port and all its children (re-initialize attached
+ * devices).
  */
-static void serio_reconnect_chain(struct serio *serio)
+static void serio_reconnect_subtree(struct serio *root)
 {
+	struct serio *s = root;
+	int error;
+
 	do {
-		if (serio_reconnect_port(serio)) {
-			/* Ok, old children are now gone, we are done */
-			break;
+		error = serio_reconnect_port(s);
+		if (!error) {
+			/*
+			 * Reconnect was successful, move on to do the
+			 * first child.
+			 */
+			if (!list_empty(&s->children)) {
+				s = list_first_entry(&s->children,
+						     struct serio, child_node);
+				continue;
+			}
 		}
-		serio = serio->child;
-	} while (serio);
+
+		/*
+		 * Either it was a leaf node or reconnect failed and it
+		 * became a leaf node. Continue reconnecting starting with
+		 * the next sibling of the parent node.
+		 */
+		while (s != root) {
+			struct serio *parent = s->parent;
+
+			if (!list_is_last(&s->child_node, &parent->children)) {
+				s = list_entry(s->child_node.next,
+					       struct serio, child_node);
+				break;
+			}
+
+			s = parent;
+		}
+	} while (s != root);
 }
 
 /*
  * serio_disconnect_port() unbinds a port from its driver. As a side effect
- * all child ports are unbound and destroyed.
+ * all children ports are unbound and destroyed.
  */
 static void serio_disconnect_port(struct serio *serio)
 {
-	struct serio *s, *parent;
+	struct serio *s = serio;
+
+	/*
+	 * Children ports should be disconnected and destroyed
+	 * first; we travel the tree in depth-first order.
+	 */
+	while (!list_empty(&serio->children)) {
+
+		/* Locate a leaf */
+		while (!list_empty(&s->children))
+			s = list_first_entry(&s->children,
+					     struct serio, child_node);
 
-	if (serio->child) {
 		/*
-		 * Children ports should be disconnected and destroyed
-		 * first, staring with the leaf one, since we don't want
-		 * to do recursion
+		 * Prune this leaf node unless it is the one we
+		 * started with.
 		 */
-		for (s = serio; s->child; s = s->child)
-			/* empty */;
-
-		do {
-			parent = s->parent;
+		if (s != serio) {
+			struct serio *parent = s->parent;
 
 			device_release_driver(&s->dev);
 			serio_destroy_port(s);
-		} while ((s = parent) != serio);
+
+			s = parent;
+		}
 	}
 
 	/*
-	 * Ok, no children left, now disconnect this port
+	 * OK, no children left, now disconnect this port.
 	 */
 	device_release_driver(&serio->dev);
 }
@@ -647,7 +683,7 @@ EXPORT_SYMBOL(serio_rescan);
 
 void serio_reconnect(struct serio *serio)
 {
-	serio_queue_event(serio, NULL, SERIO_RECONNECT_CHAIN);
+	serio_queue_event(serio, NULL, SERIO_RECONNECT_SUBTREE);
 }
 EXPORT_SYMBOL(serio_reconnect);
 
@@ -675,14 +711,16 @@ void serio_unregister_port(struct serio *serio)
 EXPORT_SYMBOL(serio_unregister_port);
 
 /*
- * Safely unregisters child port if one is present.
+ * Safely unregisters children ports if they are present.
  */
 void serio_unregister_child_port(struct serio *serio)
 {
+	struct serio *s, *next;
+
 	mutex_lock(&serio_mutex);
-	if (serio->child) {
-		serio_disconnect_port(serio->child);
-		serio_destroy_port(serio->child);
+	list_for_each_entry_safe(s, next, &serio->children, child_node) {
+		serio_disconnect_port(s);
+		serio_destroy_port(s);
 	}
 	mutex_unlock(&serio_mutex);
 }
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 111ad50..109b237 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -41,7 +41,9 @@ struct serio {
 	int (*start)(struct serio *);
 	void (*stop)(struct serio *);
 
-	struct serio *parent, *child;
+	struct serio *parent;
+	struct list_head child_node;	/* Entry in parent->children list */
+	struct list_head children;
 	unsigned int depth;		/* level of nesting in serio hierarchy */
 
 	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="synaptics-ptport-handling.patch"

Input: synaptics - simplify pass-through port handling

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

There was too much knowledge about internals if serio in the pass-through
handling, clean it up.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |   36 ++++++++++++++++++++++++++++++------
 drivers/input/mouse/synaptics.h |    2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)


diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 96b70a4..60b7817 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -294,7 +294,29 @@ static int synaptics_pt_write(struct serio *serio, unsigned char c)
 	return 0;
 }
 
-static inline int synaptics_is_pt_packet(unsigned char *buf)
+static int synaptics_pt_start(struct serio *serio)
+{
+	struct psmouse *parent = serio_get_drvdata(serio->parent);
+	struct synaptics_data *priv = parent->private;
+
+	serio_pause_rx(parent->ps2dev.serio);
+	priv->pt_port = serio;
+	serio_continue_rx(parent->ps2dev.serio);
+
+	return 0;
+}
+
+static void synaptics_pt_stop(struct serio *serio)
+{
+	struct psmouse *parent = serio_get_drvdata(serio->parent);
+	struct synaptics_data *priv = parent->private;
+
+	serio_pause_rx(parent->ps2dev.serio);
+	priv->pt_port = NULL;
+	serio_continue_rx(parent->ps2dev.serio);
+}
+
+static int synaptics_is_pt_packet(unsigned char *buf)
 {
 	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
 }
@@ -315,9 +337,8 @@ static void synaptics_pass_pt_packet(struct serio *ptport, unsigned char *packet
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct serio *ptport = psmouse->ps2dev.serio->child;
-	struct psmouse *child = serio_get_drvdata(ptport);
 	struct synaptics_data *priv = psmouse->private;
+	struct psmouse *child = serio_get_drvdata(priv->pt_port);
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child) {
@@ -345,6 +366,8 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
 	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
 	serio->write = synaptics_pt_write;
+	serio->start = synaptics_pt_start;
+	serio->stop = synaptics_pt_stop;
 	serio->parent = psmouse->ps2dev.serio;
 
 	psmouse->pt_activate = synaptics_pt_activate;
@@ -578,9 +601,10 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (SYN_CAP_PASS_THROUGH(priv->capabilities) && synaptics_is_pt_packet(psmouse->packet)) {
-			if (psmouse->ps2dev.serio->child)
-				synaptics_pass_pt_packet(psmouse->ps2dev.serio->child, psmouse->packet);
+		if (SYN_CAP_PASS_THROUGH(priv->capabilities) &&
+		    synaptics_is_pt_packet(psmouse->packet)) {
+			if (priv->pt_port)
+				synaptics_pass_pt_packet(priv->pt_port, psmouse->packet);
 		} else
 			synaptics_process_packet(psmouse);
 
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index b6aa7d2..613a365 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -110,6 +110,8 @@ struct synaptics_data {
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
 	int scroll;
+
+	struct serio *pt_port;			/* Pass-through serio port */
 };
 
 void synaptics_module_init(void);

--7JfCtLOvnd9MIVvH--
