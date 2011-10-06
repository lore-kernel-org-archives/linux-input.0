From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 8/9] Input: serio_raw - kick clients when disconnecting port
Date: Wed,  5 Oct 2011 22:08:15 -0700
Message-ID: <1317877696-7719-8-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41354 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab1JFFIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:30 -0400
Received: by mail-pz0-f42.google.com with SMTP id 1so5956148pzk.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:30 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

Send SIGIO/POLL_HUP and otherwise wake up waiters when corresponding serio
port is being disconnected. Also check if port is dead in serio_raw_poll
and signal POLLHUP|POLLERR.

This should speed up process of releasing dead devices by userspace
applications.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 30ff963..830e2fe 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -232,9 +232,11 @@ static unsigned int serio_raw_poll(struct file *file, poll_table *wait)
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
+	unsigned int mask;
 
 	poll_wait(file, &serio_raw->wait, wait);
 
+	mask = serio_raw->dead ? POLLHUP | POLLERR : POLLOUT | POLLWRNORM;
 	if (serio_raw->head != serio_raw->tail)
 		return POLLIN | POLLRDNORM;
 
@@ -359,22 +361,37 @@ static int serio_raw_reconnect(struct serio *serio)
 	return 0;
 }
 
+/*
+ * Wake up users waiting for IO so they can disconnect from
+ * dead device.
+ */
+static void serio_raw_hangup(struct serio_raw *serio_raw)
+{
+	struct serio_raw_client *client;
+
+	serio_pause_rx(serio_raw->serio);
+	list_for_each_entry(client, &serio_raw->client_list, node)
+		kill_fasync(&client->fasync, SIGIO, POLL_HUP);
+	serio_continue_rx(serio_raw->serio);
+
+	wake_up_interruptible(&serio_raw->wait);
+}
+
+
 static void serio_raw_disconnect(struct serio *serio)
 {
-	struct serio_raw *serio_raw;
+	struct serio_raw *serio_raw = serio_get_drvdata(serio);
 
 	mutex_lock(&serio_raw_mutex);
 
-	serio_raw = serio_get_drvdata(serio);
-
 	serio_close(serio);
-	serio_set_drvdata(serio, NULL);
-
 	serio_raw->dead = true;
-	wake_up_interruptible(&serio_raw->wait);
+	serio_raw_hangup(serio_raw);
 	kref_put(&serio_raw->kref, serio_raw_cleanup);
 
 	mutex_unlock(&serio_raw_mutex);
+
+	serio_set_drvdata(serio, NULL);
 }
 
 static struct serio_device_id serio_raw_serio_ids[] = {
-- 
1.7.6.4

