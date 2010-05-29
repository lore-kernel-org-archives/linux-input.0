From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/3] input: evdev: use multi-reader buffer to save space (rev2)
Date: Sat, 29 May 2010 17:57:42 +0200
Message-ID: <1275148664-6238-2-git-send-email-rydberg@euromail.se>
References: <1275148664-6238-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:37663 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328Ab0E2P6T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 11:58:19 -0400
In-Reply-To: <1275148664-6238-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>

Preparing for larger buffer needs, convert the current per-client
circular buffer to a single buffer with multiple clients. Use a
lock-less mechanism where clients wait during buffer collision only.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/evdev.c |   74 +++++++++++++++++++++++++++++-------------------
 1 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 2ee6c7a..9cbed21 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -33,13 +33,14 @@ struct evdev {
 	spinlock_t client_lock; /* protects client_list */
 	struct mutex mutex;
 	struct device dev;
+	int head;
+	int next_head;
+	struct input_event buffer[EVDEV_BUFFER_SIZE];
 };
 
 struct evdev_client {
-	struct input_event buffer[EVDEV_BUFFER_SIZE];
 	int head;
 	int tail;
-	spinlock_t buffer_lock; /* protects access to buffer, head and tail */
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
@@ -48,18 +49,11 @@ struct evdev_client {
 static struct evdev *evdev_table[EVDEV_MINORS];
 static DEFINE_MUTEX(evdev_table_mutex);
 
-static void evdev_pass_event(struct evdev_client *client,
-			     struct input_event *event)
+static inline void evdev_sync_event(struct evdev_client *client,
+				    int head, int type)
 {
-	/*
-	 * Interrupts are disabled, just acquire the lock
-	 */
-	spin_lock(&client->buffer_lock);
-	client->buffer[client->head++] = *event;
-	client->head &= EVDEV_BUFFER_SIZE - 1;
-	spin_unlock(&client->buffer_lock);
-
-	if (event->type == EV_SYN)
+	client->head = head;
+	if (type == EV_SYN)
 		kill_fasync(&client->fasync, SIGIO, POLL_IN);
 }
 
@@ -78,14 +72,22 @@ static void evdev_event(struct input_handle *handle,
 	event.code = code;
 	event.value = value;
 
+	/* lock-less write, interrupts disabled locally */
+	evdev->next_head = (evdev->head + 1) & (EVDEV_BUFFER_SIZE - 1);
+	smp_wmb();
+	evdev->buffer[evdev->head] = event;
+	smp_wmb();
+	evdev->head = evdev->next_head;
+	smp_wmb();
+
 	rcu_read_lock();
 
 	client = rcu_dereference(evdev->grab);
 	if (client)
-		evdev_pass_event(client, &event);
+		evdev_sync_event(client, evdev->head, type);
 	else
 		list_for_each_entry_rcu(client, &evdev->client_list, node)
-			evdev_pass_event(client, &event);
+			evdev_sync_event(client, evdev->head, type);
 
 	rcu_read_unlock();
 
@@ -269,7 +271,6 @@ static int evdev_open(struct inode *inode, struct file *file)
 		goto err_put_evdev;
 	}
 
-	spin_lock_init(&client->buffer_lock);
 	client->evdev = evdev;
 	evdev_attach_client(evdev, client);
 
@@ -324,22 +325,37 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	return retval;
 }
 
-static int evdev_fetch_next_event(struct evdev_client *client,
+static inline bool write_overlaps_read(int head, int next_head, int tail)
+{
+	if (next_head < head)
+		return tail >= head || tail < next_head;
+	else
+		return tail >= head && tail < next_head;
+}
+
+static int evdev_fetch_next_event(struct evdev *evdev,
+				  struct evdev_client *client,
 				  struct input_event *event)
 {
-	int have_event;
+	int head, next_head;
 
-	spin_lock_irq(&client->buffer_lock);
+	if (client->head == client->tail)
+		return 0;
 
-	have_event = client->head != client->tail;
-	if (have_event) {
-		*event = client->buffer[client->tail++];
-		client->tail &= EVDEV_BUFFER_SIZE - 1;
+ repeat:
+	head = evdev->head;
+	smp_rmb();
+	*event = evdev->buffer[client->tail];
+	smp_rmb();
+	next_head = evdev->next_head;
+	smp_rmb();
+	if (unlikely(write_overlaps_read(head, next_head, client->tail))) {
+		cpu_relax();
+		goto repeat;
 	}
 
-	spin_unlock_irq(&client->buffer_lock);
-
-	return have_event;
+	client->tail = (client->tail + 1) & (EVDEV_BUFFER_SIZE - 1);
+	return 1;
 }
 
 static ssize_t evdev_read(struct file *file, char __user *buffer,
@@ -366,7 +382,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		return -ENODEV;
 
 	while (retval + input_event_size() <= count &&
-	       evdev_fetch_next_event(client, &event)) {
+	       evdev_fetch_next_event(evdev, client, &event)) {
 
 		if (input_event_to_user(buffer + retval, &event))
 			return -EFAULT;
-- 
1.6.3.3

