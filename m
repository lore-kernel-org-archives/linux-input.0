From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: evdev: avoid storing newest SYN_REPORT when dropping all events
Date: Fri, 25 Dec 2015 00:55:48 +0530
Message-ID: <1450985148-804-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33899 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbbLXTYR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 14:24:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, a.mathur@samsung.com, aniroop.mathur@gmail.com

The newest event can be SYN_REPORT in case of dropping all old events when
buffer is full, but as now there is no device data available to read so
lets drop SYN_REPORT as well and store only SYN_DROPPED.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..e270219 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -228,7 +228,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	return 0;
 }
 
-static void __pass_event(struct evdev_client *client,
+static int __pass_event(struct evdev_client *client,
 			 const struct input_event *event)
 {
 	client->buffer[client->head++] = *event;
@@ -247,12 +247,24 @@ static void __pass_event(struct evdev_client *client,
 		client->buffer[client->tail].value = 0;
 
 		client->packet_head = client->tail;
+
+		/*
+		 * Do not store SYN_REPORT as there is no device data in buffer
+		 * and return to avoid wakeup and changing packet_head.
+		 */
+		if (event->type == EV_SYN && event->code == SYN_REPORT) {
+			client->head--;
+			client->head &= client->bufsize - 1;
+			return 1;
+		}
 	}
 
 	if (event->type == EV_SYN && event->code == SYN_REPORT) {
 		client->packet_head = client->head;
 		kill_fasync(&client->fasync, SIGIO, POLL_IN);
 	}
+
+	return 0;
 }
 
 static void evdev_pass_values(struct evdev_client *client,
@@ -287,7 +299,8 @@ static void evdev_pass_values(struct evdev_client *client,
 		event.type = v->type;
 		event.code = v->code;
 		event.value = v->value;
-		__pass_event(client, &event);
+		if (__pass_event(client, &event))
+			wakeup = false;
 	}
 
 	spin_unlock(&client->buffer_lock);
-- 
2.6.2

