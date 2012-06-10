From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 03/16] HID: uhid: allow poll()'ing on uhid devices
Date: Sun, 10 Jun 2012 15:16:15 +0200
Message-ID: <1339334188-21766-4-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46761 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab2FJNQn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:43 -0400
Received: by wgbds11 with SMTP id ds11so2574811wgb.1
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:42 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

As long as the internal buffer is not empty, we return POLLIN to
user-space.

uhid->head and uhid->tail are no atomics so the comparison may return
inexact results. However, this doesn't matter here as user-space would
need to poll() in two threads simultaneously to trigger this. And in this
case it doesn't matter if a cached result is returned or the exact new
result as user-space does not know which thread returns first from poll()
and the following read(). So it is safe to compare the values without
locking.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 05ef4b0..b1a477f 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -117,6 +117,13 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 
 static unsigned int uhid_char_poll(struct file *file, poll_table *wait)
 {
+	struct uhid_device *uhid = file->private_data;
+
+	poll_wait(file, &uhid->waitq, wait);
+
+	if (uhid->head != uhid->tail)
+		return POLLIN | POLLRDNORM;
+
 	return 0;
 }
 
-- 
1.7.10.4

