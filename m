From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 2/3] input: evdev: convert to dynamic event buffer (rev2)
Date: Sat, 29 May 2010 17:57:43 +0200
Message-ID: <1275148664-6238-3-git-send-email-rydberg@euromail.se>
References: <1275148664-6238-1-git-send-email-rydberg@euromail.se>
 <1275148664-6238-2-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:45312 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757547Ab0E2QA3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 12:00:29 -0400
In-Reply-To: <1275148664-6238-2-git-send-email-rydberg@euromail.se>
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
index 9cbed21..327f821 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -10,7 +10,7 @@
 
 #define EVDEV_MINOR_BASE	64
 #define EVDEV_MINORS		32
-#define EVDEV_BUFFER_SIZE	64
+#define EVDEV_MIN_BUFFER_SIZE	64
 
 #include <linux/poll.h>
 #include <linux/sched.h>
@@ -35,7 +35,8 @@ struct evdev {
 	struct device dev;
 	int head;
 	int next_head;
-	struct input_event buffer[EVDEV_BUFFER_SIZE];
+	int bufsize;
+	struct input_event *buffer;
 };
 
 struct evdev_client {
@@ -73,7 +74,7 @@ static void evdev_event(struct input_handle *handle,
 	event.value = value;
 
 	/* lock-less write, interrupts disabled locally */
-	evdev->next_head = (evdev->head + 1) & (EVDEV_BUFFER_SIZE - 1);
+	evdev->next_head = (evdev->head + 1) & (evdev->bufsize - 1);
 	smp_wmb();
 	evdev->buffer[evdev->head] = event;
 	smp_wmb();
@@ -125,6 +126,7 @@ static void evdev_free(struct device *dev)
 	struct evdev *evdev = container_of(dev, struct evdev, dev);
 
 	input_put_device(evdev->handle.dev);
+	kfree(evdev->buffer);
 	kfree(evdev);
 }
 
@@ -354,7 +356,7 @@ static int evdev_fetch_next_event(struct evdev *evdev,
 		goto repeat;
 	}
 
-	client->tail = (client->tail + 1) & (EVDEV_BUFFER_SIZE - 1);
+	client->tail = (client->tail + 1) & (evdev->bufsize - 1);
 	return 1;
 }
 
@@ -803,6 +805,11 @@ static void evdev_cleanup(struct evdev *evdev)
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
@@ -847,6 +854,14 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
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

