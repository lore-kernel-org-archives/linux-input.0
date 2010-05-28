From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 2/3] input: evdev: convert to dynamic event buffer
Date: Fri, 28 May 2010 17:10:33 +0200
Message-ID: <1275059434-2110-3-git-send-email-rydberg@euromail.se>
References: <1275059434-2110-1-git-send-email-rydberg@euromail.se>
 <1275059434-2110-2-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44387 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751691Ab0E1PLW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 11:11:22 -0400
In-Reply-To: <1275059434-2110-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>

Allocate the event buffer dynamically, and prepare to compute the buffer
size in a separate function. This patch defines the size computation to
be identical to the current code, and does not contain any logical changes.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/evdev.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 8edea95..ea652cc 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -10,7 +10,7 @@
 
 #define EVDEV_MINOR_BASE	64
 #define EVDEV_MINORS		32
-#define EVDEV_BUFFER_SIZE	64
+#define EVDEV_MIN_BUFFER_SIZE	64
 
 #include <linux/poll.h>
 #include <linux/sched.h>
@@ -34,7 +34,8 @@ struct evdev {
 	struct mutex mutex;
 	struct device dev;
 	int head;
-	struct input_event buffer[EVDEV_BUFFER_SIZE];
+	int bufsize;
+	struct input_event *buffer;
 	rwlock_t buffer_lock; /* protects access to buffer only */
 };
 
@@ -78,7 +79,7 @@ static void evdev_event(struct input_handle *handle,
 	write_unlock(&evdev->buffer_lock);
 
 	evdev->head++;
-	evdev->head &= EVDEV_BUFFER_SIZE - 1;
+	evdev->head &= evdev->bufsize - 1;
 
 	rcu_read_lock();
 
@@ -125,6 +126,7 @@ static void evdev_free(struct device *dev)
 	struct evdev *evdev = container_of(dev, struct evdev, dev);
 
 	input_put_device(evdev->handle.dev);
+	kfree(evdev->buffer);
 	kfree(evdev);
 }
 
@@ -336,7 +338,7 @@ static int evdev_fetch_next_event(struct evdev *evdev,
 		*event = evdev->buffer[client->tail];
 		read_unlock_irq(&evdev->buffer_lock);
 		client->tail++;
-		client->tail &= EVDEV_BUFFER_SIZE - 1;
+		client->tail &= evdev->bufsize - 1;
 	}
 
 	return have_event;
@@ -788,6 +790,11 @@ static void evdev_cleanup(struct evdev *evdev)
 	}
 }
 
+static int evdev_compute_buffer_size(struct input_dev *dev)
+{
+	return EVDEV_MIN_BUFFER_SIZE;
+}
+
 /*
  * Create new evdev device. Note that input core serializes calls
  * to connect and disconnect so we don't need to lock evdev_table here.
@@ -833,6 +840,14 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 	evdev->dev.release = evdev_free;
 	device_initialize(&evdev->dev);
 
+	evdev->bufsize = evdev_compute_buffer_size(dev);
+	evdev->buffer = kzalloc(evdev->bufsize * sizeof(struct input_event),
+				GFP_KERNEL);
+	if (!evdev->buffer) {
+		error = -ENOMEM;
+		goto err_free_evdev;
+	}
+
 	error = input_register_handle(&evdev->handle);
 	if (error)
 		goto err_free_evdev;
-- 
1.6.3.3

