From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Regression in dtor/input.git/next - flush pending events on
 clock type change
Date: Thu, 5 Feb 2015 15:58:16 -0800
Message-ID: <20150205235816.GA21288@dtor-ws>
References: <20150205230629.GC21618@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:40485 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbbBEX6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 18:58:21 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so3153703igb.2
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2015 15:58:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150205230629.GC21618@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Anshul Garg <anshul.g@samsung.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi Benjamin,

On Thu, Feb 05, 2015 at 06:06:29PM -0500, Benjamin Tissoires wrote:
> Hi Anshul,
> 
> The commit 0c3e99437a66e4c869c60c2398449e6d98f3a988 in dtor/input.git/next
> tree introduce an interesting regression in libinput. The tests fail :)
> 
> Actually, evemu-record and libinput switch the clock to monotonic when
> opening an input node, and the first thing that gets queued is a
> SYN_DROPPED event.
> 
> However, in the libinput test suite, events are the bare minimum, and
> most of the tests contain only one event set (one EV_SYN).
> When seeing the SYN_DROPPED, the clients are supposed to drain the events
> until the next EV_SYN, and so they are losing the events that came long
> after the ioctl call.
> And in the end, the test suite does not receive any events.
> 
> Removing the evdev_queue_syn_dropped() call in the ioctl handling fixes
> the test suite, and Peter suggested that maybe we should queue a
> SYN_DROPPED event iff there are events in the queue.

Does the following patch fixe it? But I would like to see libinput
tests more robust.

Thanks.

-- 
Dmitry

Input: evdev - do not queue SYN_DROPPED if queue is empty

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evdev.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e7cee38..f2a494a 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -108,10 +108,8 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
 	client->head = head;
 }
 
-/* queue SYN_DROPPED event and flush queue if flush parameter is true */
-static void evdev_queue_syn_dropped(struct evdev_client *client, bool flush)
+static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
-	unsigned long flags;
 	struct input_event ev;
 	ktime_t time;
 
@@ -126,11 +124,6 @@ static void evdev_queue_syn_dropped(struct evdev_client *client, bool flush)
 	ev.code = SYN_DROPPED;
 	ev.value = 0;
 
-	spin_lock_irqsave(&client->buffer_lock, flags);
-
-	if (flush)
-		client->packet_head = client->head = client->tail;
-
 	client->buffer[client->head++] = ev;
 	client->head &= client->bufsize - 1;
 
@@ -139,12 +132,21 @@ static void evdev_queue_syn_dropped(struct evdev_client *client, bool flush)
 		client->tail = (client->head - 1) & (client->bufsize - 1);
 		client->packet_head = client->tail;
 	}
+}
+
+static void evdev_queue_syn_dropped(struct evdev_client *client)
+{
+	unsigned long flags;
 
+	spin_lock_irqsave(&client->buffer_lock, flags);
+	__evdev_queue_syn_dropped(client);
 	spin_unlock_irqrestore(&client->buffer_lock, flags);
 }
 
 static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 {
+	unsigned long flags;
+
 	if (client->clk_type == clkid)
 		return 0;
 
@@ -163,8 +165,18 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 		return -EINVAL;
 	}
 
-	/* Flush pending events and queue SYN_DROPPED event.*/
-	evdev_queue_syn_dropped(client, true);
+	/*
+	 * Flush pending events and queue SYN_DROPPED event,
+	 * but only if queue is not empty.
+	 */
+	spin_lock_irqsave(&client->buffer_lock, flags);
+
+	if (client->head != client->tail) {
+		client->packet_head = client->head = client->tail;
+		__evdev_queue_syn_dropped(client);
+	}
+
+	spin_unlock_irqrestore(&client->buffer_lock, flags);
 
 	return 0;
 }
@@ -803,7 +815,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
 
 	ret = bits_to_user(mem, maxbit, maxlen, p, compat);
 	if (ret < 0)
-		evdev_queue_syn_dropped(client, false);
+		evdev_queue_syn_dropped(client);
 
 	kfree(mem);
 
