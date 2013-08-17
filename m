From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v1 23/49] hid: usbhid: prepare for enabling irq in complete()
Date: Sun, 18 Aug 2013 00:24:48 +0800
Message-ID: <1376756714-25479-24-git-send-email-ming.lei@canonical.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:42624 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3HQQ3D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 12:29:03 -0400
In-Reply-To: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <ming.lei@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Complete() will be run with interrupt enabled, so change to
spin_lock_irqsave().

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/hid/usbhid/hid-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index bd38cdf..2445fd6 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -489,8 +489,9 @@ static void hid_ctrl(struct urb *urb)
 	struct hid_device *hid = urb->context;
 	struct usbhid_device *usbhid = hid->driver_data;
 	int unplug = 0, status = urb->status;
+	unsigned long flags;
 
-	spin_lock(&usbhid->lock);
+	spin_lock_irqsave(&usbhid->lock, flags);
 
 	switch (status) {
 	case 0:			/* success */
@@ -525,7 +526,7 @@ static void hid_ctrl(struct urb *urb)
 	}
 
 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-	spin_unlock(&usbhid->lock);
+	spin_unlock_irqrestore(&usbhid->lock, flags);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
 }
-- 
1.7.9.5

