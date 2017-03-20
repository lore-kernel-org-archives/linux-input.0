From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 2/9] Input: serio - add fast reconnect option
Date: Sun, 19 Mar 2017 17:22:24 -0700
Message-ID: <20170320002231.31152-3-dmitry.torokhov@gmail.com>
References: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Devices connected to serio bus are quite slow, and to improve apparent
speed of resume process, serio core resumes (reconnects) its devices
asynchronously, by posting port reconnect requests to a workqueue.
Unfortunately this means that if there is a dependent device of a given
serio port (for example SMBus part of touchpad connected via both PS/2 and
SMBus), we do not have a good way of ensuring resume order.

This change allows drivers to define "fast reconnect" handlers that would
be called in-line during system resume. Drivers need to ensure that these
handlers are truly "fast".

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/serio.c | 22 +++++++++++++++++-----
 include/linux/serio.h       |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 048ae748c4d1..30d6230d48f7 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -953,12 +953,24 @@ static int serio_suspend(struct device *dev)
 static int serio_resume(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
+	int error = -ENOENT;
 
-	/*
-	 * Driver reconnect can take a while, so better let kseriod
-	 * deal with it.
-	 */
-	serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
+	mutex_lock(&serio->drv_mutex);
+	if (serio->drv && serio->drv->fast_reconnect) {
+		error = serio->drv->fast_reconnect(serio);
+		if (error && error != -ENOENT)
+			dev_warn(dev, "fast reconnect failed with error %d\n",
+				 error);
+	}
+	mutex_unlock(&serio->drv_mutex);
+
+	if (error) {
+		/*
+		 * Driver reconnect can take a while, so better let
+		 * kseriod deal with it.
+		 */
+		serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
+	}
 
 	return 0;
 }
diff --git a/include/linux/serio.h b/include/linux/serio.h
index c733cff44e18..138a5efe863a 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -77,6 +77,7 @@ struct serio_driver {
 	irqreturn_t (*interrupt)(struct serio *, unsigned char, unsigned int);
 	int  (*connect)(struct serio *, struct serio_driver *drv);
 	int  (*reconnect)(struct serio *);
+	int  (*fast_reconnect)(struct serio *);
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
 
-- 
2.12.0.367.g23dc2f6d3c-goog
