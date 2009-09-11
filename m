From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] Input: implement input filters
Date: Thu, 10 Sep 2009 22:28:24 -0700
Message-ID: <20090911052823.26911.27618.stgit@localhost.localdomain>
References: <20090911052720.26911.67943.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:43936 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZIKF2X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:28:23 -0400
Received: by pxi27 with SMTP id 27so611234pxi.15
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:28:26 -0700 (PDT)
In-Reply-To: <20090911052720.26911.67943.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mjg@redhat.com

Sometimes it is desirable to suppress certain events from reaching
input handlers and thus user space. One such example is Mac mouse
button emulation code which catches certain key presses and converts
them into button clicks as if they were emitted by a virtual mouse.
The original key press events should be completely suppressed,
otherwise user space will be confused, and while keyboard driver
does it on its own evdev is blissfully unaware of this arrangement.

This patch adds notion of 'filter' to the standard input handlers,
which may flag event as filtered thus preventing it from reaching
other input handlers. Filters don't (nor will they ever) have a
notion of priority relative to each other, input core will run all
of them first and any one of them may mark event as filtered.

This patch is inspired by similar patch by Matthew Garret but the
implementation and intended usage are quite different.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   39 ++++++++++++++++++++++++++++++++-------
 include/linux/input.h |    8 ++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 7c237e6..d7e1c48 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -83,12 +83,14 @@ static int input_defuzz_abs_event(int value, int old_val, int fuzz)
 }
 
 /*
- * Pass event through all open handles. This function is called with
+ * Pass event first through all filters and then, if event has not been
+ * filtered out, through all open handles. This function is called with
  * dev->event_lock held and interrupts disabled.
  */
 static void input_pass_event(struct input_dev *dev,
 			     unsigned int type, unsigned int code, int value)
 {
+	struct input_handler *handler;
 	struct input_handle *handle;
 
 	rcu_read_lock();
@@ -96,11 +98,25 @@ static void input_pass_event(struct input_dev *dev,
 	handle = rcu_dereference(dev->grab);
 	if (handle)
 		handle->handler->event(handle, type, code, value);
-	else
-		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
-			if (handle->open)
-				handle->handler->event(handle,
-							type, code, value);
+	else {
+		bool filtered = false;
+
+		list_for_each_entry_rcu(handle, &dev->h_list, d_node) {
+			if (!handle->open)
+				continue;
+
+			handler = handle->handler;
+			if (!handler->filter) {
+				if (filtered)
+					break;
+
+				handler->event(handle, type, code, value);
+
+			} else if (handler->filter(handle, type, code, value))
+				filtered = true;
+		}
+	}
+
 	rcu_read_unlock();
 }
 
@@ -903,12 +919,15 @@ static int input_handlers_seq_show(struct seq_file *seq, void *v)
 
 	seq_printf(seq, "N: Number=%ld Name=%s",
 		   (unsigned long)seq->private, handler->name);
+	if (handler->filter)
+		seq_puts(seq, "(filter)");
 	if (handler->fops)
 		seq_printf(seq, " Minor=%d", handler->minor);
 	seq_putc(seq, '\n');
 
 	return 0;
 }
+
 static const struct seq_operations input_handlers_seq_ops = {
 	.start	= input_handlers_seq_start,
 	.next	= input_handlers_seq_next,
@@ -1588,8 +1607,14 @@ int input_register_handle(struct input_handle *handle)
 	 * which is mutually exclusive with ->disconnect()
 	 * we can't be racing with input_unregister_handle()
 	 * and so separate lock is not needed here.
+	 *
+	 * Filters go to the head of the list, normal handlers
+	 * to the tail.
 	 */
-	list_add_tail(&handle->h_node, &handler->h_list);
+	if (handler->filter)
+		list_add(&handle->h_node, &handler->h_list);
+	else
+		list_add_tail(&handle->h_node, &handler->h_list);
 
 	if (handler->start)
 		handler->start(handle);
diff --git a/include/linux/input.h b/include/linux/input.h
index 8b3bc3e..c8e11f1 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1189,6 +1189,8 @@ struct input_handle;
  * @event: event handler. This method is being called by input core with
  *	interrupts disabled and dev->event_lock spinlock held and so
  *	it may not sleep
+ * @filter: similar to @event; separates normal event handlers from
+ *	"filters".
  * @connect: called when attaching a handler to an input device
  * @disconnect: disconnects a handler from input device
  * @start: starts handler for given handle. This function is called by
@@ -1210,6 +1212,11 @@ struct input_handle;
  * same time. All of them will get their copy of input event generated by
  * the device.
  *
+ * The very same structure is used to implement input filters. Input core
+ * allows filters to run first and will not pass event to regular handlers
+ * if any of the filters indicate that the event should be filtered (by
+ * returning %true from their filter() method).
+ *
  * Note that input core serializes calls to connect() and disconnect()
  * methods.
  */
@@ -1218,6 +1225,7 @@ struct input_handler {
 	void *private;
 
 	void (*event)(struct input_handle *handle, unsigned int type, unsigned int code, int value);
+	bool (*filter)(struct input_handle *handle, unsigned int type, unsigned int code, int value);
 	int (*connect)(struct input_handler *handler, struct input_dev *dev, const struct input_device_id *id);
 	void (*disconnect)(struct input_handle *handle);
 	void (*start)(struct input_handle *handle);

