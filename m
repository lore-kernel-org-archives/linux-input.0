From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC] Input: serio - convert to use workqueue instead of a thread
Date: Tue, 14 Sep 2010 22:16:52 -0700
Message-ID: <20100915051652.GA22219@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42787 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab0IOFQ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 01:16:58 -0400
Received: by pvg2 with SMTP id 2so2618261pvg.19
        for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 22:16:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>

Instead of creating an exclusive thread to handle serio events (which
happen rarely), let's switch to using a workqueue. With the arrival of
concurrency-managed workqueue infrastructure it should reduce total
number of threads in the system.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

If this makes sense I have a similar patch for gameport... Hopefully
this will allow to get rid of kseriod, kgameportd, kpsmoused and
ipolldevd...

 drivers/input/serio/serio.c |  158 ++++++++++++++++++++-----------------------
 1 files changed, 72 insertions(+), 86 deletions(-)


diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 8a42637..b2730b4 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -32,10 +32,9 @@
 #include <linux/module.h>
 #include <linux/serio.h>
 #include <linux/errno.h>
-#include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/kthread.h>
+#include <linux/workqueue.h>
 #include <linux/mutex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
@@ -44,7 +43,7 @@ MODULE_LICENSE("GPL");
 
 /*
  * serio_mutex protects entire serio subsystem and is taken every time
- * serio port or driver registrered or unregistered.
+ * serio port or driver registered or unregistered.
  */
 static DEFINE_MUTEX(serio_mutex);
 
@@ -165,58 +164,23 @@ struct serio_event {
 
 static DEFINE_SPINLOCK(serio_event_lock);	/* protects serio_event_list */
 static LIST_HEAD(serio_event_list);
-static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
-static struct task_struct *serio_task;
+static struct workqueue_struct *serio_wq;
 
-static int serio_queue_event(void *object, struct module *owner,
-			     enum serio_event_type event_type)
+static struct serio_event *serio_get_event(void)
 {
+	struct serio_event *event = NULL;
 	unsigned long flags;
-	struct serio_event *event;
-	int retval = 0;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
-	/*
-	 * Scan event list for the other events for the same serio port,
-	 * starting with the most recent one. If event is the same we
-	 * do not need add new one. If event is of different type we
-	 * need to add this event and should not look further because
-	 * we need to preseve sequence of distinct events.
-	 */
-	list_for_each_entry_reverse(event, &serio_event_list, node) {
-		if (event->object == object) {
-			if (event->type == event_type)
-				goto out;
-			break;
-		}
-	}
-
-	event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC);
-	if (!event) {
-		pr_err("Not enough memory to queue event %d\n", event_type);
-		retval = -ENOMEM;
-		goto out;
-	}
-
-	if (!try_module_get(owner)) {
-		pr_warning("Can't get module reference, dropping event %d\n",
-			   event_type);
-		kfree(event);
-		retval = -EINVAL;
-		goto out;
+	if (!list_empty(&serio_event_list)) {
+		event = list_first_entry(&serio_event_list,
+					 struct serio_event, node);
+		list_del_init(&event->node);
 	}
 
-	event->type = event_type;
-	event->object = object;
-	event->owner = owner;
-
-	list_add_tail(&event->node, &serio_event_list);
-	wake_up(&serio_wait);
-
-out:
 	spin_unlock_irqrestore(&serio_event_lock, flags);
-	return retval;
+	return event;
 }
 
 static void serio_free_event(struct serio_event *event)
@@ -250,25 +214,7 @@ static void serio_remove_duplicate_events(struct serio_event *event)
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
-
-static struct serio_event *serio_get_event(void)
-{
-	struct serio_event *event = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&serio_event_lock, flags);
-
-	if (!list_empty(&serio_event_list)) {
-		event = list_first_entry(&serio_event_list,
-					 struct serio_event, node);
-		list_del_init(&event->node);
-	}
-
-	spin_unlock_irqrestore(&serio_event_lock, flags);
-	return event;
-}
-
-static void serio_handle_event(void)
+static void serio_handle_event(struct work_struct *work)
 {
 	struct serio_event *event;
 
@@ -307,6 +253,59 @@ static void serio_handle_event(void)
 	mutex_unlock(&serio_mutex);
 }
 
+static DECLARE_WORK(serio_event_work, serio_handle_event);
+
+static int serio_queue_event(void *object, struct module *owner,
+			     enum serio_event_type event_type)
+{
+	unsigned long flags;
+	struct serio_event *event;
+	int retval = 0;
+
+	spin_lock_irqsave(&serio_event_lock, flags);
+
+	/*
+	 * Scan event list for the other events for the same serio port,
+	 * starting with the most recent one. If event is the same we
+	 * do not need add new one. If event is of different type we
+	 * need to add this event and should not look further because
+	 * we need to preseve sequence of distinct events.
+	 */
+	list_for_each_entry_reverse(event, &serio_event_list, node) {
+		if (event->object == object) {
+			if (event->type == event_type)
+				goto out;
+			break;
+		}
+	}
+
+	event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC);
+	if (!event) {
+		pr_err("Not enough memory to queue event %d\n", event_type);
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	if (!try_module_get(owner)) {
+		pr_warning("Can't get module reference, dropping event %d\n",
+			   event_type);
+		kfree(event);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	event->type = event_type;
+	event->object = object;
+	event->owner = owner;
+
+	list_add_tail(&event->node, &serio_event_list);
+	queue_work(serio_wq, &serio_event_work);
+
+out:
+	spin_unlock_irqrestore(&serio_event_lock, flags);
+	return retval;
+}
+
 /*
  * Remove all events that have been submitted for a given
  * object, be it serio port or driver.
@@ -358,18 +357,6 @@ static struct serio *serio_get_pending_child(struct serio *parent)
 	return child;
 }
 
-static int serio_thread(void *nothing)
-{
-	do {
-		serio_handle_event();
-		wait_event_interruptible(serio_wait,
-			kthread_should_stop() || !list_empty(&serio_event_list));
-	} while (!kthread_should_stop());
-
-	return 0;
-}
-
-
 /*
  * Serio port operations
  */
@@ -996,17 +983,16 @@ static int __init serio_init(void)
 {
 	int error;
 
+	serio_wq = alloc_workqueue("kseriod", WQ_UNBOUND, 1);
+	if (!serio_wq) {
+		pr_err("Failed to create kseriod workqueue\n");
+		return -ENOMEM;
+	}
+
 	error = bus_register(&serio_bus);
 	if (error) {
 		pr_err("Failed to register serio bus, error: %d\n", error);
-		return error;
-	}
-
-	serio_task = kthread_run(serio_thread, NULL, "kseriod");
-	if (IS_ERR(serio_task)) {
-		bus_unregister(&serio_bus);
-		error = PTR_ERR(serio_task);
-		pr_err("Failed to start kseriod, error: %d\n", error);
+		destroy_workqueue(serio_wq);
 		return error;
 	}
 
@@ -1016,7 +1002,7 @@ static int __init serio_init(void)
 static void __exit serio_exit(void)
 {
 	bus_unregister(&serio_bus);
-	kthread_stop(serio_task);
+	destroy_workqueue(serio_wq);
 }
 
 subsys_initcall(serio_init);
-- 
Dmitry
