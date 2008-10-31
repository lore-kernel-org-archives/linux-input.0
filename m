From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]fix memleak in error case of hiddev
Date: Fri, 31 Oct 2008 10:31:38 +0100
Message-ID: <200810311031.39083.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:57494 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbYJaJbg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 05:31:36 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

this bug is old, the patch should go into 2.6.28 and stable.

This fixes a memleak in hiddev's open in an error case.

Signed-off-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver

---

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index b218cbc..6834d1f 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -291,8 +291,13 @@ static int hiddev_open(struct inode *inode, struct file *file)
 		if (list->hiddev->exist) {
 			struct hid_device *hid = hiddev_table[i]->hid;
 			res = usbhid_get_power(hid);
-			if (res < 0)
+			if (res < 0) {
+				spin_lock_irqsave(&list->hiddev->list_lock, flags);
+				list_del(&list->node);
+				spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
+				kfree(list->hiddev);
 				return -EIO;
+			}
 			usbhid_open(hid);
 		}
 
