From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: serio - do not mark kseriod freezable anymore
Date: Sun, 20 Dec 2009 23:33:38 -0800
Message-ID: <20091221073338.GA3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43053 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbZLUHdn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 02:33:43 -0500
Received: by pwj9 with SMTP id 9so3023124pwj.21
        for <linux-input@vger.kernel.org>; Sun, 20 Dec 2009 23:33:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

We used to make kseriod freezable to prevent unnecessary attempts at
resuming keyboard and mouse before taking hibernation image when suspend
and hibernation were sharing PM operations. Now that they are separated
and we don't risk resuming during 'thaw' we don't need to freeze kseriod
anymore. This will allow us to start resetting mouse and keyboard a bit
earlier, before rest of the userspace comes back up.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/serio.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)


diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 0236f0d..e0f3018 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -284,13 +284,7 @@ static void serio_handle_event(void)
 
 	mutex_lock(&serio_mutex);
 
-	/*
-	 * Note that we handle only one event here to give swsusp
-	 * a chance to freeze kseriod thread. Serio events should
-	 * be pretty rare so we are not concerned about taking
-	 * performance hit.
-	 */
-	if ((event = serio_get_event())) {
+	while ((event = serio_get_event())) {
 
 		switch (event->type) {
 			case SERIO_REGISTER_PORT:
@@ -380,10 +374,9 @@ static struct serio *serio_get_pending_child(struct serio *parent)
 
 static int serio_thread(void *nothing)
 {
-	set_freezable();
 	do {
 		serio_handle_event();
-		wait_event_freezable(serio_wait,
+		wait_event_interruptible(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
 	} while (!kthread_should_stop());
 
