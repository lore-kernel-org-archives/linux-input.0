From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 2/4] input: evdev: Replace timeval with timespec64
Date: Tue, 13 Sep 2016 07:10:03 -0700
Message-ID: <1473775805-2242-3-git-send-email-deepa.kernel@gmail.com>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

struct timeval is not y2038 safe.

All references to timeval in the kernel will be replaced
by y2038 safe structures.
Replace all references to timeval with y2038 safe
struct timespec64 here.

struct input_event will be changed in a different patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 drivers/input/evdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..bda2b61 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -157,6 +157,7 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
 	struct input_event ev;
 	ktime_t time;
+	struct timespec64 ts;
 
 	time = client->clk_type == EV_CLK_REAL ?
 			ktime_get_real() :
@@ -164,7 +165,9 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 				ktime_get() :
 				ktime_get_boottime();
 
-	ev.time = ktime_to_timeval(time);
+	ts = ktime_to_timespec64(time);
+	ev.time.tv_sec = ts.tv_sec;
+	ev.time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
 	ev.value = 0;
@@ -262,12 +265,15 @@ static void evdev_pass_values(struct evdev_client *client,
 	struct evdev *evdev = client->evdev;
 	const struct input_value *v;
 	struct input_event event;
+	struct timespec64 ts;
 	bool wakeup = false;
 
 	if (client->revoked)
 		return;
 
-	event.time = ktime_to_timeval(ev_time[client->clk_type]);
+	ts = ktime_to_timespec64(ev_time[client->clk_type]);
+	event.time.tv_sec = ts.tv_sec;
+	event.time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 
 	/* Interrupts are disabled, just acquire the lock. */
 	spin_lock(&client->buffer_lock);
-- 
2.7.4
