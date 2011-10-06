From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/9] Input: serio_raw - perform proper locking when adding clients to list
Date: Wed,  5 Oct 2011 22:08:10 -0700
Message-ID: <1317877696-7719-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41354 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab1JFFIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:24 -0400
Received: by pzk1 with SMTP id 1so5956148pzk.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:24 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

Make sure we hold serio lock when adding clients to client list so that
we do not race with serio_raw_release() removing clients from the same
list.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 6b57ee3..77ce3a6 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -106,7 +106,10 @@ static int serio_raw_open(struct inode *inode, struct file *file)
 	file->private_data = client;
 
 	kref_get(&serio_raw->kref);
+
+	serio_pause_rx(serio_raw->serio);
 	list_add_tail(&client->node, &serio_raw->client_list);
+	serio_continue_rx(serio_raw->serio);
 
 out:
 	mutex_unlock(&serio_raw_mutex);
@@ -138,10 +141,9 @@ static int serio_raw_release(struct inode *inode, struct file *file)
 
 static int serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
 {
-	unsigned long flags;
 	int empty;
 
-	spin_lock_irqsave(&serio_raw->serio->lock, flags);
+	serio_pause_rx(serio_raw->serio);
 
 	empty = serio_raw->head == serio_raw->tail;
 	if (!empty) {
@@ -149,7 +151,7 @@ static int serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
 		serio_raw->tail = (serio_raw->tail + 1) % SERIO_RAW_QUEUE_LEN;
 	}
 
-	spin_unlock_irqrestore(&serio_raw->serio->lock, flags);
+	serio_continue_rx(serio_raw->serio);
 
 	return !empty;
 }
-- 
1.7.6.4

