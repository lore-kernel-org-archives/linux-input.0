From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] HID: make timeout HZ independent
Date: Sat,  2 May 2015 17:55:15 +0200
Message-ID: <1430582115-22842-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:54866 "EHLO www.osadl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbbEBQDW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 2 May 2015 12:03:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

wait_event_interruptible_timeout() expects a timeout in jiffies so the
numeric constant becomes HZ dependent - put it through msecs_to_jiffies()
to make it HZ independent.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

The comment indicates that the expected timeout should be 40 milliseconds

Patch was compile tested with x86_64_defconfig (implies
CONFIG_HID_LOGITECH=y)

Patch is against 4.0-rc1 (localversion-next is -next-20150501)

 drivers/hid/hid-lg.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index b86c18e..2671de9 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -700,7 +700,8 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			/* insert a little delay of 10 jiffies ~ 40ms */
 			wait_queue_head_t wait;
 			init_waitqueue_head (&wait);
-			wait_event_interruptible_timeout(wait, 0, 10);
+			wait_event_interruptible_timeout(wait, 0,
+							 msecs_to_jiffies(40));
 
 			/* Select random Address */
 			buf[1] = 0xB2;
-- 
1.7.10.4

