From: Adam Jackson <ajax@redhat.com>
Subject: [PATCH] input/evdev: Be less aggressive about sending SIGIO notifies
Date: Mon,  4 Jan 2010 16:08:17 -0500
Message-ID: <1262639297-21857-1-git-send-email-ajax@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58453 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab0ADVIT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2010 16:08:19 -0500
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o04L8IYg019142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-input@vger.kernel.org>; Mon, 4 Jan 2010 16:08:18 -0500
Received: from localhost.localdomain (ihatethathostname.lab.bos.redhat.com [10.16.43.238])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o04L8I6m014505
	for <linux-input@vger.kernel.org>; Mon, 4 Jan 2010 16:08:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

When using realtime signals, we'll enqueue one signal for every event.
This is unfortunate, because (for example) keyboard presses are three
events: key, msc scancode, and syn.  They'll be enqueued fast enough in
kernel space that all three events will be ready to read by the time
userspace runs, so the first invocation of the signal handler will read
all three events, but then the second two invocations still have to run
to do no work.

Instead, only send the SIGIO notification on syn events.  This is a
slight abuse of SIGIO semantics, in principle it ought to fire as soon
as any events are readable.  But it matches evdev semantics, which is
more important since SIGIO is rather vaguely defined to begin with.

Signed-off-by: Adam Jackson <ajax@redhat.com>
---
 drivers/input/evdev.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index dee6706..258c639 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -59,7 +59,8 @@ static void evdev_pass_event(struct evdev_client *client,
 	client->head &= EVDEV_BUFFER_SIZE - 1;
 	spin_unlock(&client->buffer_lock);
 
-	kill_fasync(&client->fasync, SIGIO, POLL_IN);
+	if (event->type == EV_SYN)
+		kill_fasync(&client->fasync, SIGIO, POLL_IN);
 }
 
 /*
-- 
1.6.5.2

