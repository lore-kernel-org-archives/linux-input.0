From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 09/15] HID: wiimote: Helper functions for synchronous requests
Date: Tue,  6 Sep 2011 13:50:34 +0200
Message-ID: <1315309840-4664-10-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab1IFLvV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:21 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:21 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

To initialize wiimote peripherals, the stream to the wiimote must be held
exclusively by the initializer, otherwise the initialization will fail. Many
initializations require multiple memory requests to be sent synchronously so we
need a way to lock the stream and release it when we are done.

This adds several helper functions which allow to lock the stream, then send
requests, wait for the answers and release the stream again.

When holding the lock, the function may sleep and interrupted by signals.
Also it returns after a short timeout so userspace shouldn't notice long
delays.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   56 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index c811a7d..0a5e458 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -10,11 +10,13 @@
  * any later version.
  */
 
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include "hid-ids.h"
 
@@ -31,6 +33,12 @@ struct wiimote_state {
 	spinlock_t lock;
 	__u8 flags;
 	__u8 accel_split[2];
+
+	/* synchronous cmd requests */
+	struct mutex sync;
+	struct completion ready;
+	int cmd;
+	__u32 opt;
 };
 
 struct wiimote_data {
@@ -118,6 +126,52 @@ static __u16 wiiproto_keymap[] = {
 	BTN_MODE,	/* WIIPROTO_KEY_HOME */
 };
 
+/* requires the state.lock spinlock to be held */
+static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
+								__u32 opt)
+{
+	return wdata->state.cmd == cmd && wdata->state.opt == opt;
+}
+
+/* requires the state.lock spinlock to be held */
+static inline void wiimote_cmd_complete(struct wiimote_data *wdata)
+{
+	wdata->state.cmd = WIIPROTO_REQ_NULL;
+	complete(&wdata->state.ready);
+}
+
+static inline int wiimote_cmd_acquire(struct wiimote_data *wdata)
+{
+	return mutex_lock_interruptible(&wdata->state.sync) ? -ERESTARTSYS : 0;
+}
+
+/* requires the state.lock spinlock to be held */
+static inline void wiimote_cmd_set(struct wiimote_data *wdata, int cmd,
+								__u32 opt)
+{
+	INIT_COMPLETION(wdata->state.ready);
+	wdata->state.cmd = cmd;
+	wdata->state.opt = opt;
+}
+
+static inline void wiimote_cmd_release(struct wiimote_data *wdata)
+{
+	mutex_unlock(&wdata->state.sync);
+}
+
+static inline int wiimote_cmd_wait(struct wiimote_data *wdata)
+{
+	int ret;
+
+	ret = wait_for_completion_interruptible_timeout(&wdata->state.ready, HZ);
+	if (ret < 0)
+		return -ERESTARTSYS;
+	else if (ret == 0)
+		return -EIO;
+	else
+		return 0;
+}
+
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 								size_t count)
 {
@@ -875,6 +929,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
 	spin_lock_init(&wdata->state.lock);
+	init_completion(&wdata->state.ready);
+	mutex_init(&wdata->state.sync);
 
 	return wdata;
 
-- 
1.7.6.1

