From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v5 2/3] input: evdev: Replace timeval with timespec64
Date: Sun, 17 Dec 2017 21:18:43 -0800
Message-ID: <20171218051844.10193-3-deepa.kernel@gmail.com>
References: <20171218051844.10193-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171218051844.10193-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

struct timeval is not y2038 safe.

All references to timeval in the kernel will be replaced
by y2038 safe structures.
Replace all references to timeval with y2038 safe
struct timespec64 here.

struct input_event will be changed in a different patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/evdev.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 0193dd4f0452..3171c4882d80 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -156,15 +156,22 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
-	ktime_t time;
+	struct timespec64 ts;
 
-	time = client->clk_type == EV_CLK_REAL ?
-			ktime_get_real() :
-			client->clk_type == EV_CLK_MONO ?
-				ktime_get() :
-				ktime_get_boottime();
+	switch (client->clk_type) {
+	case EV_CLK_REAL:
+		ktime_get_real_ts64(&ts);
+		break;
+	case EV_CLK_MONO:
+		ktime_get_ts64(&ts);
+		break;
+	case EV_CLK_BOOT:
+		get_monotonic_boottime64(&ts);
+		break;
+	}
 
-	ev.time = ktime_to_timeval(time);
+	ev.time.tv_sec = ts.tv_sec;
+	ev.time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
 	ev.value = 0;
@@ -257,17 +264,20 @@ static void __pass_event(struct evdev_client *client,
 
 static void evdev_pass_values(struct evdev_client *client,
 			const struct input_value *vals, unsigned int count,
-			ktime_t *ev_time)
+			struct timespec64 *ev_time)
 {
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
 	struct input_event event;
+	struct timespec64 ts;
 	bool wakeup = false;
 
 	if (client->revoked)
 		return;
 
-	event.time = ktime_to_timeval(ev_time[client->clk_type]);
+	ts = ev_time[client->clk_type];
+	event.time.tv_sec = ts.tv_sec;
+	event.time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
@@ -304,12 +314,11 @@ static void evdev_events(struct input_handle *handle,
 {
 	struct evdev *evdev = handle->private;
 	struct evdev_client *client;
-	ktime_t ev_time[EV_CLK_MAX];
+	struct timespec64 ev_time[EV_CLK_MAX];
 
-	ev_time[EV_CLK_MONO] = ktime_get();
-	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
-	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
-						 TK_OFFS_BOOT);
+	ktime_get_ts64(&ev_time[EV_CLK_MONO]);
+	ktime_get_real_ts64(&ev_time[EV_CLK_REAL]);
+	get_monotonic_boottime64(&ev_time[EV_CLK_BOOT]);
 
 	rcu_read_lock();
 
-- 
2.14.1
