From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]fix possible deadlock in usbhid_close()
Date: Wed, 29 Apr 2009 17:12:12 +0200
Message-ID: <200904291712.13729.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:59251 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbZD2PNJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2009 11:13:09 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

This patch switches usbhid_close() from flush_scheduled_work() to canceling
the outstanding work. This fixes a possible deadlock due to work taking
the mutex usbhid_close() holds. Lockdep reported the problem.

Signed-off-by: Oliver Neukum <oliver@neukum.org>

--

--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -662,8 +662,8 @@ void usbhid_close(struct hid_device *hid)
 	spin_lock_irq(&usbhid->lock);
 	if (!--hid->open) {
 		spin_unlock_irq(&usbhid->lock);
+		hid_cancel_delayed_stuff(usbhid);
 		usb_kill_urb(usbhid->urbin);
-		flush_scheduled_work();
 		usbhid->intf->needs_remote_wakeup = 0;
 	} else {
 		spin_unlock_irq(&usbhid->lock);
