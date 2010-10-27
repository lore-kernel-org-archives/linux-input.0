From: Bill Gatliff <bgat@billgatliff.com>
Subject: [PATCH] evdev: discard oldest event on buffer overflow
Date: Wed, 27 Oct 2010 12:09:58 -0500
Message-ID: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57124 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab0J0RKL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 13:10:11 -0400
Received: by ewy7 with SMTP id 7so830929ewy.19
        for <linux-input@vger.kernel.org>; Wed, 27 Oct 2010 10:10:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.orglinux-input@vger.kernel.org
Cc: Bill Gatliff <bgat@billgatliff.com>

On a buffer overflow, the head and tail pointers collide.
This makes the buffer suddenly look empty, rather than
full, which may confuse applications.

This patch moves the tail pointer up one event on a buffer
overflow, which "consumes" the oldest event in the buffer
to make room for the incoming event.  Thus, although data
is lost due to the overflow (which is unavoidable), the
data that remains is both recent and still time-ordered.

Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 drivers/input/evdev.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e3f7fc6..04a18ff 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -55,15 +55,19 @@ static void evdev_pass_event(struct evdev_client *client,
 {
 	/*
 	 * Interrupts are disabled, just acquire the lock.
-	 * Make sure we don't leave with the client buffer
-	 * "empty" by having client->head == client->tail.
 	 */
 	spin_lock(&client->buffer_lock);
-	do {
-		client->buffer[client->head++] = *event;
-		client->head &= client->bufsize - 1;
-	} while (client->head == client->tail);
-	spin_unlock(&client->buffer_lock);
+	client->buffer[client->head++] = *event;
+	client->head &= client->bufsize - 1;
+
+	/*
+	 * If we overflow the buffer, consume the oldest
+	 * event to make room for the one that just arrived
+	 */
+	if (unlikely(client->head == client->tail)) {
+		client->tail++;
+		client->tail &= client->bufsize - 1;
+	}
 
 	if (event->type == EV_SYN)
 		kill_fasync(&client->fasync, SIGIO, POLL_IN);
-- 
1.7.1

