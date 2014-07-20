From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC PATCH] Input: evdev - drop redundant list-locking
Date: Sun, 20 Jul 2014 20:48:12 +0200
Message-ID: <1405882092-7005-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:41052 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaGTSsb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 14:48:31 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so5439060wgh.11
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 11:48:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, David Herrmann <dh.herrmann@gmail.com>

evdev->client_list is rcu-protected. There is no need to have a
separate spinlock just for the list. Either one is good enough, so lets
drop the spinlock.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi

I stumbled across this one when doing some evdev reviews. Maybe I'm missing
something obvious and I should stop coding on Sundays. But the RCU-protection
should be enough here, right?

We _could_ do a synchronize_rcu() during evdev_attach_client() to guarantee that
new events are really delivered once it returns. But that seems rather pedantic
to me.

I'm also not sure why we use RCU here, anyway. I mean, there's no high
contention so a spinlock should be fine and would get rid of the very expensive
synchronize_rcu during close(). But then again, I don't really care enough to
write benchmarks for that..

Thanks
David

 drivers/input/evdev.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 7a25a7a..1f38bd1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -34,7 +34,6 @@ struct evdev {
 	wait_queue_head_t wait;
 	struct evdev_client __rcu *grab;
 	struct list_head client_list;
-	spinlock_t client_lock; /* protects client_list */
 	struct mutex mutex;
 	struct device dev;
 	struct cdev cdev;
@@ -433,17 +432,13 @@ static int evdev_ungrab(struct evdev *evdev, struct evdev_client *client)
 static void evdev_attach_client(struct evdev *evdev,
 				struct evdev_client *client)
 {
-	spin_lock(&evdev->client_lock);
 	list_add_tail_rcu(&client->node, &evdev->client_list);
-	spin_unlock(&evdev->client_lock);
 }
 
 static void evdev_detach_client(struct evdev *evdev,
 				struct evdev_client *client)
 {
-	spin_lock(&evdev->client_lock);
 	list_del_rcu(&client->node);
-	spin_unlock(&evdev->client_lock);
 	synchronize_rcu();
 }
 
@@ -485,10 +480,10 @@ static void evdev_hangup(struct evdev *evdev)
 {
 	struct evdev_client *client;
 
-	spin_lock(&evdev->client_lock);
-	list_for_each_entry(client, &evdev->client_list, node)
+	rcu_read_lock();
+	list_for_each_entry_rcu(client, &evdev->client_list, node)
 		kill_fasync(&client->fasync, SIGIO, POLL_HUP);
-	spin_unlock(&evdev->client_lock);
+	rcu_read_unlock();
 
 	wake_up_interruptible(&evdev->wait);
 }
@@ -1438,7 +1433,6 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 	}
 
 	INIT_LIST_HEAD(&evdev->client_list);
-	spin_lock_init(&evdev->client_lock);
 	mutex_init(&evdev->mutex);
 	init_waitqueue_head(&evdev->wait);
 	evdev->exist = true;
-- 
2.0.2

