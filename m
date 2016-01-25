From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: evdev: correct handling of memory allocation failure of evdev_client
Date: Mon, 25 Jan 2016 23:20:05 +0530
Message-ID: <1453744205-868-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33678 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbcAYRrp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2016 12:47:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

Lets fix twice checking of memory allocation failure of evdev_client
structure when allocated successfully.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..102b5d9 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -503,10 +503,11 @@ static int evdev_open(struct inode *inode, struct file *file)
 	int error;
 
 	client = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
-	if (!client)
+	if (!client) {
 		client = vzalloc(size);
-	if (!client)
-		return -ENOMEM;
+		if (!client)
+			return -ENOMEM;
+	}
 
 	client->bufsize = bufsize;
 	spin_lock_init(&client->buffer_lock);
-- 
2.6.2

