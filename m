From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Thu, 19 Apr 2012 21:51:04 +0800
Message-ID: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:47027 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab2DSNxD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Apr 2012 09:53:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ming Lei <ming.lei@canonical.com>, stable@vger.kernel.org

The URB complete handler may be called by usb_unlink_urb directly,
so deadlock will be triggered in __usbhid_submit_report since
usbhid->lock is to be acquired in ctrl/out URB complete handler
but it is hold before calling usb_unlink_urb.

This patch avoids the deadlock by releasing the lock before
calling usb_unlink_urb.

CC: <stable@vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/hid/usbhid/hid-core.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index aa1c503..b5d07da 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -543,11 +543,13 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 			 * the queue is known to run
 			 * but an earlier request may be stuck
 			 * we may need to time out
-			 * no race because this is called under
-			 * spinlock
+			 * release spinlock to avoid deadlock.
 			 */
-			if (time_after(jiffies, usbhid->last_out + HZ * 5))
+			if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
+				spin_unlock(&usbhid->lock);
 				usb_unlink_urb(usbhid->urbout);
+				spin_lock(&usbhid->lock);
+			}
 		}
 		return;
 	}
@@ -591,11 +593,13 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 		 * the queue is known to run
 		 * but an earlier request may be stuck
 		 * we may need to time out
-		 * no race because this is called under
-		 * spinlock
+		 * release spinlock to avoid deadlock.
 		 */
-		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5))
+		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5)) {
+			spin_unlock(&usbhid->lock);
 			usb_unlink_urb(usbhid->urbctrl);
+			spin_lock(&usbhid->lock);
+		}
 	}
 }
 
-- 
1.7.9.5

